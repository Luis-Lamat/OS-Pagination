# [Paging](http://en.wikipedia.org/wiki/Paging) Memory Management Method for an Operating System
This is a simulation of the method for memory management of an operating system.
This project was made as part of our operating systems class and its main objective
is to visualize the allocation of processes in physical memory and page
swapping with virtual memory.

## Input File
The app runs the main.rb file. In there you can find the name of the file that 
is used for the command input. Edit input.txt or add your on file for tests.
```ruby
input_file = File.new("input.txt", "r")
```

## Supported Commands
| Input Commands | Command Meaning                                                    | Example   |
| -------------- | ------------------------------------------------------------------ | --------- |
| `P n p`        | **P**rocess load with `n` bytes and `p` id                         | `P 10 1`  |
| `A d p m`      | **A**ccess the `d` address of process `p` (`m` is the modify bit)  | `A 3 1 0` |
| `L p`          | **L**iberate process `p`                                           | `L 1`     |
| `F`            | **F**in. Erase memories, print performance metrics report.         | `F`       |
| `E`            | **E**xit.                                                          | `E`       |