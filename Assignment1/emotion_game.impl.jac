impl EmotionGame.start {
    if not [root --> (`?turn)] {
        rand_idx = random.randint(0, emotions.length - 1);
        new_turn = spawn root --> turn();
        new_turn.correct_emotion = emotions[rand_idx];
        visit new_turn;
    } else {
        existing_turn = [root --> (`?turn)][0];
        visit existing_turn;
    }
}

impl EmotionGame.process_emotion_guess {
    user_guess = self.guess.lower();
    correct = here.correct_emotion.lower();

    if user_guess != correct {
        std.out("Guess: '" + self.guess + "'");
        hint = give_emotion_hint(self.guess, here.correct_emotion);
        std.out(hint);
        std.out("Try again!\n");

        new_turn = spawn here --> turn();
        new_turn.correct_emotion = here.correct_emotion;
        visit new_turn;
    } else {
        std.out("🎉 Brilliant! You guessed the emotion: '" + here.correct_emotion + "'");
        std.out("You're emotionally intelligent! 🌟\n");
        disengage;
    }
}