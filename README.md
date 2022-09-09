# progressbar
Progress: a progress bar for Matlab\
Writes a text progress bar to the console

## Syntax:
 `nb = progress(fraction, text)`

## Input:
 * fraction: number between 0 and 1 (where 1 means the process has ended)
 * text: label to display beside the progress bar

## Output:
 * out: number of bytes printed, can be used to delete the progress bar with `fprintf(repmat('\b', 1, out));`

## Usage: 
In a for loop, write `progress(j/maxiter, 'text')` to display a progress bar:
 ```
  >> j = 2; maxiter = 10;
  >> progress(j/maxiter);
  [====                ] 20.0%
 ```
Subsequent calls to the progress bar will delete the last `out` bytes, if something else has been printed to stdout this will delete that and not the progress bar. 
Avoid this by typing `progress reset`
