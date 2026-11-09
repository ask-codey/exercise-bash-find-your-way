#!/usr/bin/env bats
# Checks your answers in answers.txt against the camp folder itself.
# Run it from this folder with:  bats check.bats
# You don't need to change this file.

setup() {
  cd "$BATS_TEST_DIRNAME"
}

# The answer written after "N)" in answers.txt, without spaces or quotes at either end or a slash at the end.
answer() {
  grep -E "^$1\)" answers.txt | head -n 1 | sed -E "s/^$1\)[[:space:]]*//; s/[[:space:]]+\$//; s/^[\"']//; s/[\"']\$//; s#/+\$##"
}

# Fails with a message when question N has no answer yet.
need() {
  if [[ -z "$(answer "$1")" ]]; then
    echo "Question $1 has no answer yet. Write it after \"$1)\" in answers.txt."
    return 1
  fi
}

@test "the camp folder is still here" {
  if [[ ! -f camp/welcome.txt ]]; then
    echo "The camp folder or its welcome.txt is missing. Download the exercise again to get it back."
    return 1
  fi
}

@test "1) the boathouse's hidden folder" {
  need 1
  a="$(answer 1)"
  if [[ "$a" != .* || "$a" == "." || "$a" == ".." || ! -d "camp/boathouse/$a" ]]; then
    echo "Question 1: \"$a\" isn't a hidden folder in camp/boathouse. Hidden names start with a dot, and ls shows them only with -a."
    return 1
  fi
}

@test "2) the file inside the hidden folder" {
  need 2
  a="$(answer 1)"; b="$(answer 2)"
  if [[ -z "$b" || ! -f "camp/boathouse/$a/$b" ]]; then
    echo "Question 2: \"$b\" isn't a file in the boathouse's hidden folder. Go into the folder from question 1 and look with ls."
    return 1
  fi
}

@test "3) how many things are in cabin-2" {
  need 3
  want="$(ls camp/cabins/cabin-2 | wc -l | tr -d ' ')"
  if [[ "$(answer 3)" != "$want" ]]; then
    echo "Question 3: \"$(answer 3)\" isn't it yet. Count every name plain ls shows in camp/cabins/cabin-2, files and folders."
    return 1
  fi
}

@test "4) the biggest file in the dining hall" {
  need 4
  want="$(ls -S camp/dining-hall | while read -r name; do [[ -f "camp/dining-hall/$name" ]] && { echo "$name"; break; }; done)"
  if [[ "$(answer 4)" != "$want" ]]; then
    echo "Question 4: \"$(answer 4)\" isn't the biggest file yet. In ls -l, the size in bytes is the number just before the date. Folders don't count."
    return 1
  fi
}

@test "5) the cabin with a hidden folder" {
  need 5
  a="$(answer 5)"
  hidden="$(ls -A "camp/cabins/$a" 2>/dev/null | grep '^\.' || true)"
  if [[ ! -d "camp/cabins/$a" || -z "$hidden" ]]; then
    echo "Question 5: \"$a\" isn't the cabin with a hidden folder. Look inside each cabin with ls -a."
    return 1
  fi
}

@test "6) the file in arts and crafts" {
  need 6
  a="$(answer 6)"
  if [[ ! -f "camp/arts and crafts/$a" ]]; then
    echo "Question 6: \"$a\" isn't a file in the arts and crafts folder. Its name has spaces: put it in quotes, or let Tab type it."
    return 1
  fi
}

@test "7) a relative path from camp to the pantry" {
  need 7
  a="$(answer 7)"
  want="$(cd camp/dining-hall/kitchen/pantry && pwd)"
  got="$(cd camp 2>/dev/null && cd "$a" 2>/dev/null && pwd || true)"
  if [[ "$a" == /* || "$a" == "~"* ]]; then
    echo "Question 7: a relative path doesn't start with / or ~. It starts from the folder you're in."
    return 1
  fi
  if [[ "$got" != "$want" ]]; then
    echo "Question 7: from camp, cd \"$a\" doesn't reach the pantry. The pantry is in the kitchen, and the kitchen is in the dining hall."
    return 1
  fi
}

@test "8) a relative path from cabin-2 to the boathouse" {
  need 8
  a="$(answer 8)"
  want="$(cd camp/boathouse && pwd)"
  got="$(cd camp/cabins/cabin-2 2>/dev/null && cd "$a" 2>/dev/null && pwd || true)"
  if [[ "$a" == /* || "$a" == "~"* ]]; then
    echo "Question 8: a relative path doesn't start with / or ~. It starts from the folder you're in."
    return 1
  fi
  if [[ "$got" != "$want" ]]; then
    echo "Question 8: from cabin-2, cd \"$a\" doesn't reach the boathouse. Each .. goes up one folder: how many do you need to get back to camp?"
    return 1
  fi
}
