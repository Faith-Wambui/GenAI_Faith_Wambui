"""A Personal Journal with AI Insights"""

import from byllm.llm { Model }
import datetime;

glob llm = Model(model_name="gemini/gemini-2.0-flash", verbose=True);

"""AI helps reflect on journal entries"""
def reflect_on_entry(entry: str) -> str by llm();

"""AI suggests related thoughts or prompts"""
def suggest_prompts(previous_entries: list) -> str by llm();

walker JournalApp {
    has entry_text: str;
    has entry_date: str;
    
    can create_entry with entry {
        # Create a new journal entry node
        new_entry = spawn here --> journal_entry(
            content=self.entry_text,
            date=self.entry_date,
            timestamp=datetime.datetime.now()
        );
        std.out("📖 Journal entry saved!");
        
        # Get AI reflection
        reflection = reflect_on_entry(self.entry_text);
        std.out("💭 AI Reflection: " + reflection);
        
        # Connect to previous entry if exists
        if (root --> `?journal_entry) {
            last_entry = root --> `?journal_entry;
            new_entry ++> next_entry;
            last_entry ++> next_entry --> new_entry;
        }
        
        # Suggest next writing prompts
        all_entries = [root --> *journal_entry];
        if (all_entries.length > 2) {
            prompt = suggest_prompts(all_entries.content);
            std.out("✨ Suggested next topic: " + prompt);
        }
    }
    
    can read_entries with entry {
        std.out("\n=== YOUR JOURNAL ===");
        entries = [root --> *journal_entry];
        
        for i in range(entries.length - 1, -1, -1) {
            entry = entries[i];
            std.out("\n📅 " + entry.date);
            std.out("📝 " + entry.content);
            std.out("---");
        }
    }
}

node journal_entry {
    has content: str;
    has date: str;
    has timestamp: datetime.datetime;
}

edge next_entry;