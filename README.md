# A Boltzmann Machine for Solving Sudoku

See the Rust implementation: https://github.com/vberger/silinapse/blob/master/examples/sudoku-boltzmann-machine.rs

## Status: Incomplete

There are duplicate numbers in rows/columns. The culprit seems to be the setting of initial weights, which relies on complicated indexing.

## Installation

1. Clone the repo.
2. Use 'stack build` to build and 'stack run boltzmann-sudoku' to run Main.hs
