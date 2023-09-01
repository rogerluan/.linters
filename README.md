# `.linters`

This repo contains my personal (and thus, opinionated) configuration files for a few linters:

- Swift
    - [SwiftLint](https://github.com/realm/SwiftLint)
    - [SwiftFormat](https://github.com/nicklockwood/SwiftFormat)
- Ruby
    - [RuboCop](https://github.com/rubocop/rubocop)

## Installation

1. Install the linters you're interested in using. You can check each of their repos for specific installation instructions.
2. Copy the config files from this repo, into your own repo.
3. There's no step 3 :)

For RuboCop, feel free to delete the extensions you're not using that are being declared in the `.rubocop.yml` file. For example, if you're not using Rails, you can delete the `rubocop-rails` extension.

## Optional: configure precommit hook

I suggest you to configure a precommit hook to run the formatters before every commit. This will ensure that your code will always be automatically formatted, effortlessly.

This Python script https://github.com/hallettj/git-format-staged helps us automatically format staged files, even if they're only partially staged (e.g. when you stage just selected lines from a file, even though more parts of the file were modified). However, to avoid copy-pasting a Python script into your iOS project, I created https://github.com/rogerluan/git_stage_formatter, a gem that wraps the Python script and makes it easier to install, using RubyGems.

To install the gem, add `gem "git_stage_formatter"` to your `Gemfile`, and run `bundle install`.

### Installing the precommit hook script

1. Copy the contents of the [`precommit.sh`](/precommit.sh) file to your repo
2. Create a symlink to the `precommit.sh` file in your `.git/hooks` folder:

```sh
ln -s -f ../../path/to/your/precommit.sh .git/hooks/pre-commit
```

**Note:** it _must_ start with `../../` because that's the relative path git will use (it's executed as if it was inside of `.git/hooks`, so it needs to go up 2 dirs before accessing your repo's files).

This command must be run by every developer in your team. If you want to automate this, you can add the following to your `Rakefile`:

```ruby
task :install_git_hooks do
  puts("Setting up git hooks…")
  system("ln -s -f ../../path/to/your/precommit.sh .git/hooks/pre-commit")
end
```

3. Review your `precommit.sh` file and update everything accordingly, e.g. the paths of the binaries, the file extensions it should be linting, etc. Common file paths differ between different projects and project types (e.g. iOS vs RoR projects).

# Contact

Twitter: [@rogerluan_](https://twitter.com/rogerluan_)
