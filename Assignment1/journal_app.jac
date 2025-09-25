"""Journal Application Runner"""

import journal;

# Sample journal entries to start with

walker init {
    has entry_count: int = 0;

    can setup with `root entry;
}

impl init.setup {
    if (!(root --> `?journal_entry)) {
        spawn root --> JournalApp( ...);
        spawn root --> JournalApp(...);
    }
}

# Interactive journal session
walker daily_journal {
    has new_entry: str;

    can start with `root entry;
}

impl daily_journal.start {
    std.out("Welcome to your AI Journal! 📔");
    std.out("What would you like to do?");
    std.out("1. Write new entry");
    std.out("2. Read previous entries");
    std.out("3. Exit");

    # For demo, auto-create a new entry
    spawn root --> JournalApp(
        entry_text="Reflecting on AI journaling - it's amazing how technology can help us understand ourselves better.",
        entry_date="2024-06-01"  # Use fixed date or assign in implementation
    );

    # To read entries, implement a walker ability or call appropriately
    # Example:
    spawn root --> daily_journal.read_entries();
}

with entry {
    root spawn init();
    root spawn daily_journal();
}