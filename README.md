### Installation

Linux

```
pip3 install pre-commit
```

Mac

```
brew install pre-commit
```

### Configuration

Create `.pre-commit-config.yaml` in the root of your repository and add the following:

```
repos:
  - repo: https://github.com/brightback/google-style-precommit-hook
    rev: v1.0.0
    hooks:
      - id: google-style-java
```
