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

  var wordList = ["1", "2l", "3pp", "4asd", "5jkl;", "tests6", "7crayon", "crayons8", "test8769", "seag"];

  bool isPlaying = false;
  bool isComplete = false;

  Random random = Random();

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
            Visibility(visible: isPlaying && !isComplete, child: SizedBox(height: 60, width: 60, child: TextFormField(controller: inputChar,))),
            Visibility(
              visible: !isComplete,
              child: InkWell(
                onTap: isPlaying ? makeGuess : startGame,
                  child: CustomButton(buttonText)
              ),
            ),
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

    for (int i = 0; i < wordLength; ++i)
      {
        if (guessChar == wordToGuess.substring(i,i+1))
          {
            correctIndices.add(i);
          }
      }

    if (correctIndices.isEmpty)
      {
        incorrectGuesses += 1;
      }
    else
      {
        correctGuesses += 1;
      }

    for(int i in correctIndices)
      {
        int index = (i*2)+1;

        wordInProgress = wordInProgress.substring(0,index) + guessChar + wordInProgress.substring(index+1, wordInProgress.length);

      }


    bool wordIsDone = true;
    // In the following block, we will iterate through the word in progress, and if there arent any spaces left, we know we have guessed the word
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
    Navigator.of(context, rootNavigator: true)
        .pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HangmanView()),
    );
  }

  quitGame()
  {
    Navigator.of(context, rootNavigator: true)
        .pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ThanksView()),
    );
  }
}