import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hangman/thanks.dart';
import 'dart:math';

import 'buttonwidget.dart';

class HangmanView extends StatefulWidget{
  @override
  State<HangmanView> createState() => _HangmanViewState();
}

class _HangmanViewState extends State<HangmanView> {

  //Here we initialize our variables required for the game of hangman, starting with the list of 10 random words

  var wordList = ["aluminium", "mayor", "prospect", "wing", "staff", "table", "crisis", "satisfied", "slam", "incongruous"];

  bool isPlaying = false;
  bool isComplete = false;

  Random random = Random();

  // We initialize everything to 0 or an empty string, then create the default 'word in progress'.
  int randNum = 0;
  int wordLength = 0;
  int incorrectGuesses = 0;
  int correctGuesses = 0;
  String wordToGuess = "";
  String wordInProgress = " _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _";
  String guessesText = "";

  String buttonText = "Start";

  TextEditingController inputChar = TextEditingController();

  @override
  Widget build(BuildContext context) {

    if (wordToGuess == "")
      {
        initializeVars();
      }

    // This block sets the string to the correct png file required for the current state of the game,
    // tracked by incorect guesses.
    String pngString = "Frame0.png";

    if (incorrectGuesses < 7)
      {
        pngString = "Frame$incorrectGuesses.png";
      }
    else
      {
        pngString = "Frame6.png";
      }

    String guessText = "Incorrect Guesses: " + incorrectGuesses.toString() + "  Correct Guesses: " + correctGuesses.toString();

    return Scaffold(
      backgroundColor: Colors.white,

      // This block creates the on-screen elements

      body: Row(
        children: [
          SizedBox(height: 1000, width: 200,),
          Column(
          children: [
            SizedBox(height: 300, width: 293, child: Image.asset(pngString)),
            Visibility(maintainState: true, maintainAnimation: true, maintainSize: true, visible: isComplete, child: Text("Congrats! You guessed the word in " + (incorrectGuesses + correctGuesses).toString() + " guesses. Play again?", style: TextStyle(fontSize: 28),)),
            SizedBox(height: 20,),
            Text(wordInProgress, style: TextStyle(fontSize: 30),),
            SizedBox(height: 20,),
            Text(guessText),

            // The following elements are made visible or invisible based on the booleans initialized earlier

            Visibility(visible: isPlaying && !isComplete, child: SizedBox(height: 60, width: 60, child: TextFormField(controller: inputChar,))),
            Visibility(visible: !isComplete, child: InkWell(onTap: isPlaying ? makeGuess : startGame, child: CustomButton(buttonText)),),
            SizedBox(height: 20,),
            Visibility(visible: isComplete, child: InkWell(onTap: playAgain, child: CustomButton("Play Again"),)),
            Visibility(visible: isComplete, child: InkWell(onTap: quitGame, child: CustomButton("Quit"),)),
            SizedBox(height: 20,),
            // TextField(),
          ],
        ),

    ]
      ),
    );
  }
  initializeVars()
  {
    randNum = random.nextInt(10);
    wordLength = wordList[randNum].length;
    wordToGuess = wordList[randNum];


    wordInProgress = wordInProgress.substring(0, wordLength*2);
  }

  makeGuess()
  {
    String guessChar = inputChar.text;

    inputChar = TextEditingController();

    var correctIndices = [];

    // Here we iterate through each character in the word chosen from the list at the top.
    // If the input character matches any of the characters in the word, we store the index
    // in a list to use later.
    for (int i = 0; i < wordLength; ++i)
      {
        if (guessChar == wordToGuess.substring(i,i+1))
          {
            correctIndices.add(i);
          }
      }

    // This block determines whether a guess was correct or incorrect based on if the list was empty or not
    if (correctIndices.isEmpty)
      {
        incorrectGuesses += 1;
      }
    else
      {
        correctGuesses += 1;
      }

    // And finally we iterate through our list of indices, replacing any dashes with the correctly guessed letter
    for(int i in correctIndices)
      {
        int index = (i*2)+1;

        wordInProgress = wordInProgress.substring(0,index) + guessChar + wordInProgress.substring(index+1, wordInProgress.length);

      }


    bool wordIsDone = true;

    // In the following block, we will iterate through the word in progress,
    // and if there arent any spaces left, we know we have guessed the word
    for(int i = 0; i < wordInProgress.length; ++i)
      {
        if (wordInProgress.substring(i,i+1) == "_")
          {
            wordIsDone = false;
          }
      }

    if (wordIsDone)
      {
        isComplete = true;
      }
    // Set state is the function call to use to reset all on-screen values to the new ones we
    // generated in the function.
    setState(() {});
  }

  startGame()
  {
    isPlaying = true;
    buttonText = "Make Guess";

    setState(() {});
  }

  playAgain()
  {
    // This simply pops the current frame off the stack, and adds a new Hangman frame to it, which restarts the game.
    Navigator.of(context, rootNavigator: true)
        .pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HangmanView()),
    );
  }

  quitGame()
  {
    // This block pops the game off the stack, and adds a "thank you" splash screen.
    Navigator.of(context, rootNavigator: true)
        .pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ThanksView()),
    );
  }
}