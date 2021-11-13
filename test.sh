#!/bin/bash

# Runs the same steps locally that will be run in CI.
# If this passes, the CI build should as well.

mix credo --strict
CREDO_RES=$?
if [ $CREDO_RES -ne 0 ]; then
  echo ""
  echo "☆ ==================================== ☆"
	echo "☆ Credo found problems with your code. ☆" >&2
	echo "☆ Please fix the issues above before   ☆" >&2
	echo "☆ committing.                          ☆" >&2
  echo "☆ ==================================== ☆"
  echo ""
  exit $CREDO_RES
else
  echo ""
  echo "★ ============================== ★"
  echo "★   Credo linter passed.         ★"
  echo "★ ============================== ★"
  echo ""
fi

mix format --check-formatted
FORMAT_RES=$?
if [ $FORMAT_RES -ne 0 ]
then
  echo ""
  echo "☆ ==================================== ☆"
	echo "☆  Format check failed.                ☆" >&2
	echo "☆  Please run $ mix format             ☆" >&2
	echo "☆  before committing.                  ☆" >&2
  echo "☆ ==================================== ☆"
  echo ""
  exit $FORMAT_RES
else
  echo ""
  echo "★ ============================== ★"
  echo "★   Formatting looks good!       ★"
  echo "★ ============================== ★"
  echo ""
fi

# You might consider adding the --stale flag here as well.
# Doing so will cause Mix to attempt to run only the tests that reference modules
# that have changed since the last CI run.
# https://hexdocs.pm/mix/1.12/Mix.Tasks.Test.html#module-the-stale-optionmix test
mix test
TEST_RES=$?
if [ $TEST_RES -ne 0 ]
then
  echo ""
  echo "☆ ==================================== ☆"
	echo "☆  One or more tests failed.           ☆" >&2
	echo "☆  Please fix them before committing.  ☆" >&2
  echo "☆ ==================================== ☆"
  echo ""
  exit $TEST_RES
else
  echo ""
  echo "★ ============================== ★"
  echo "★   Tests passed.                ★"
  echo "★ ============================== ★"
  echo ""
fi

mix dialyzer --plt
mix dialyzer
DIALYZER_RES=$?

if [ $DIALYZER_RES -ne 0 ]
then
  echo ""
  echo "☆ ========================================= ☆"
	echo "☆  Dialyzer checks failed.                 ☆" >&2
	echo "☆  Please fix typespecs before committing. ☆" >&2
  echo "☆ ======================================== ☆"
  echo ""
  exit $DIALYZER_RES
else
  echo ""
  echo "★ ============================== ★"
  echo "★   Dialyzer passed.             ★"
  echo "★ ============================== ★"
  echo ""
fi

exit 0