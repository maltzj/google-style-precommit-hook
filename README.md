A handy [pre-commit](http://pre-commit.com/) hook which will run Google's java
code style formatter for you on your code!

Usage:

```
repos:
  - repo: https://github.com/bauerjs1/google-style-precommit-hook.git
    rev: cb7c169c4064b83762941e1c2222c8606817f7bb
    hooks:
      - id: google-style-java
```

*Note*: this file stores Google's code style formatter jar in a `.cache/`
directory so that it doesn't need to be re-downloaded each time.  You will
probably want to add `.cache/` to the `.gitignore` file of the project which
uses this hook.
