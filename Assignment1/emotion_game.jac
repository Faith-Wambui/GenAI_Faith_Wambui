"""An Emotion Guessing Game"""

import random;
import from byllm.llm { Model }

# Define emotions to guess
glob emotions = [
    "joy", "sadness", "anger", "fear", "surprise", 
    "love", "calm", "excitement", "peace", "curiosity"
];

glob llm = Model(model_name="gemini/gemini-2.0-flash", verbose=False);

"""Provide a poetic hint for the emotion"""
def give_emotion_hint(guess: str, correct_emotion: str) -> str by llm();

walker EmotionGame {
    has guess: str;

    can start with `root entry;
    can process_emotion_guess with turn entry;
}

node turn {
    has correct_emotion: str;  # no initialization here
}

import "emotion_game.impl";

with entry {
    root spawn EmotionGame(guess="happy");
}