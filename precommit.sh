#!/bin/zsh

# Check if `git_stage_formatter` is available and discard any stdout/stderr output.
bundle info git_stage_formatter >/dev/null 2>&1

# Check the exit status of the command
if [ $? -ne 0 ]; then
  # If the command failed, `git_stage_formatter` couldn't be found in the $PATH.
  # Let's source `~/.zshrc` to try to fix that.
  # This happens because this script (precommit hook) is running from a Git client that doesn't source the
  # lifecycle files regular shells normally source (e.g. `~/.zshrc`).
  echo "Sourcing ~/.zshrc to be able to run git_stage_formatter…"
  source ~/.zshrc
fi

SWIFTFORMAT_BIN=Pods/SwiftFormat/CommandLineTool/swiftformat
RUBOCOP_BIN_DIR=$(bundle info rubocop | grep "Path:" | awk -F ": " '{print $2}' | sed -e 's/^[[:space:]]*//')
RUBOCOP_BIN="$RUBOCOP_BIN_DIR/exe/rubocop"

bundle exec git_stage_formatter --formatter \"$SWIFTFORMAT_BIN stdin --stdinpath '{}'\" "*.swift"
bundle exec git_stage_formatter --formatter \"$RUBOCOP_BIN --autocorrect-all --stderr --stdin '{}'\" "*.rb" "fastlane/*" "Gemfile" "Podfile" "Rakefile" "dangerfiles/*" 2>/dev/null

if [ $? -ne 0 ]; then
  echo "Precommit hook couldn't lint everything for you. Run 'rake lint' before committing again."
  exit 1
fi
