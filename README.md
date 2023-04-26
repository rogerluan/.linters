# .swiftlinters

This repo contains my personal (and thus, opinionated) configuration files to be used with [SwiftLint](https://github.com/realm/SwiftLint) and [SwiftFormat](https://github.com/nicklockwood/SwiftFormat).

## Installation

1. Install SwiftLint and SwiftFormat. You can check each of their repos for specific installation instructions.
2. Copy the config files from this repo, into your own repo.
3. There's no step 3 :)

## Optional: configure precommit hook

I suggest you configure a precommit hook to run formatters before each commit. This will ensure that your code will always be automatically formatted.

The Python script https://github.com/hallettj/git-format-staged helps us automatically format staged files, even if they're only partially staged (e.g. when you stage just selected lines from a file, even though more parts of the file was modified). However, to avoid copy-pasting a Python script into your iOS project, I created https://github.com/rogerluan/git_stage_formatter, a gem that wraps the Python script and makes it easier to install, using RubyGems, something iOS developers are more familiar with.

To install the gem, add `gem "git_stage_formatter"` to your `Gemfile`, and run `bundle install`. Then, copy the contents of the [`precommit.sh`](/precommit.sh) file to your own `.git/hooks/pre-commit` file, changing the path of your SwiftFormat binary accordingly. This will run SwiftFormat before each commit, automatically formatting your Swift staged files.

# Contact

Twitter: [@rogerluan_](https://twitter.com/rogerluan_)
