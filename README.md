# A Boltzmann Machine for Solving Sudoku

See the Rust implementation: https://github.com/vberger/silinapse/blob/master/examples/sudoku-boltzmann-machine.rs

## Installation and Running the Programm

Make sure you have Haskell and Stack installed.

1. Clone the repo.
2. Use 'stack build` to build and 'stack run boltzmann-sudoku' to run Main.hs

## Notes

You will probably need to play around with the hyperparameters 
(first three definitions in app/Main.hs) to get a good result. 
Due to using an older laptop, I was unable to run the program 
with more than 1 million iterations. At this number, I got fairly good results:
on average only about two empty spots from the sudoku grid. 
