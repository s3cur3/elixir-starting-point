# elixir-starting-point

This is a base project for setting up a GitHub Actions-based Elixir
continuous integration (CI) system.

It builds on [the Hashrocket post](https://hashrocket.com/blog/posts/build-the-ultimate-elixir-ci-with-github-actions)
on setting up the ultimate Elixir CI, with a couple important tweaks:

1. It runs the actions on all PRs (you'll want to set up branch protection rules to
   make sure the tests actually pass before merging!)
2. It separates out the CI jobs that don't depend on each other. Thus, if your code
   fails the format check, you'll still get feedback on whether it passed the tests,
   Credo, and Dialyzer, etc. 

The important bits here for including in your project are:

- `.github/`
- `.formatter.exs`
- `config/.credo.exs` (though do note that I've made some opinionated choices here)
- `mix.exs`, or at least the dependencies, Dialyzer config, and ExCoveralls config there
- Optional: `.dialyzer_ignore.exs` (otherwise you'll need to remove that line from `mix.exs`)
- Optional: `test.sh` for devs to run locally before committing (you could wire this
  up as a pre-commit hook if it's fast enough)
- Optional: `.idea/` if you use Jetbrains Intellij as your IDE (this gets you run
  configurations for formatting & ExUnit tests)
