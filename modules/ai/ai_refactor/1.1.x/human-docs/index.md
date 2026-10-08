# AI Refactor — manual setup guide

**AI Refactor** (`ai_refactor`) is a **developer Drush tool** that reads a PHP
file, finds the methods inside it, and asks an AI provider to analyse them and
suggest refactors. It parses the file into a syntax tree (using
`nikic/php-parser`), collects each class method — its name, visibility, and
source — and sends each one to the AI module's chat operation for review, keeping
a small log of the results.

It is **command‑line only**. There are no pages, forms, blocks, or permissions,
and nothing is exposed to the web. You run it from a terminal against a file path
you supply. The command sends the method bodies to your AI provider, so only run
it against code you are allowed to share, and only in a trusted developer
environment.

The OpenAI provider for the AI module (`ai_provider_openai`) is a required
dependency and must be configured with a working API key (managed through the AI
provider layer and the Key module). As with any AI suggestion, **review the
output before applying it** — the tool proposes changes, it does not make them.

This guide is written for a **human**. If you want a terse, token‑cheap
reference for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and its developer requirements.

## How to use it

Run the analyze command against a PHP file, from the command line:

```bash
drush ai_refactor:analyze /path/to/File.php
```

`ma:analyze` is a shorter alias for the same command. The tool parses the file,
enumerates each class method, sends it to the AI provider, and appends the
suggestions to a local log for you to read and act on manually.

> **Using DDEV?** Run it as `ddev drush ai_refactor:analyze …` from your host, or
> without the `ddev` prefix inside the container.
