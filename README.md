# Exercise: Find Your Way

Exercise code for the lesson **Exercise: Find Your Way** in Bash in Depth on [ask-codey.com](https://www.ask-codey.com).

Pine Lake Summer Camp is a folder world: every place is a folder and every note is a file. Explore it with `pwd`, `ls`, `cd` and Tab, and write what you find in `answers.txt`. A check script tells you which answers are right.

## Before you start

You need a terminal (the Terminal app on a Mac, Ubuntu on Linux or in WSL on Windows) and **bats**, the tool that runs the check. If `bats --version` doesn't print a version yet, install it:

```bash
sudo apt install bats       # Ubuntu, and Ubuntu in WSL
brew install bats-core      # a Mac, with Homebrew
```

## What's here

- `camp/`: the camp's folders and files. Explore them; don't change them.
- `answers.txt`: eight questions, each with a numbered line for your answer. For you to finish.
- `check.bats`: checks your answers against the camp folder. You don't need to change it.

## Run it

Open a terminal in this folder (the one with `answers.txt` in it), then start exploring:

```bash
cd camp
ls
```

Open `answers.txt` in any text editor to write your answers, and save it after each one.

## Check your work

From this folder (not from inside `camp`):

```bash
bats check.bats
```

At first almost every check fails: that is expected. Each answer you get right turns its check into a ✓. A failing check's message says which question it is and gives a hint.

## The rules

- Write each answer on its numbered line, after the `)`, like the example: `0) welcome.txt`.
- Write names exactly as `ls` shows them, dots included, but without quotes.
- Questions 7 and 8 want a **relative** path: one that starts from the folder you're in, not with `/` or `~`.

## Tips

- `pwd` tells you where you are whenever you lose track.
- Plain `ls` doesn't show names that start with a dot. `ls -a` does.
- `ls -l` shows each file's size in bytes, just before its date.
- A name with spaces needs quotes, or let Tab type it for you.

## Hand it in

When it works, push your solution to a public repo of your own on GitHub, then paste that repo's address into **Submit your exercise** on the lesson page at [ask-codey.com](https://www.ask-codey.com). That's what completes the lesson. The lesson page shows the Git commands, step by step.
