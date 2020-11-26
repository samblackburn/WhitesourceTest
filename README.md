# WhitesourceTest
Some test scripts to understand the behaviour of a vulnerability scanner

## How to use
The folder structure is supposed to be a bunch of test scenarios - right now there's just `CloneDevart` which is the scenario where SQL Clone references Devart.
The PowerShell script in that folder will download 2 versions of the WhiteSource agent and run them against a simple csproj a few times.

## How not to use
This is a public repo.  Please don't put any real API tokens in here.  When run in offline mode, the scanner requires a token, but it doesn't need to be valid.
