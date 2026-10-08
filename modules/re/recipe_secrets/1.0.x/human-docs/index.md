# Recipe Secrets — manual setup guide

**Recipe Secrets** (`recipe_secrets`) keeps sensitive values out of the
configuration a Drupal recipe ships. Recipes are reusable packages of config,
and they are meant to be shared and committed to version control — but config
files sometimes contain API keys, passwords, or other secrets that must never be
committed. This module lets a recipe reference secrets by name instead of baking
them in, pulling the real values from a `.env` file at import time.

The mechanism is a small placeholder syntax. In a config file that a recipe
imports, you write `!secret {{SOME_NAME}}` where the sensitive value would
normally go. During the configuration import that the recipe drives, the module
replaces each placeholder with the value of the matching variable from your
`.env` file. Because the real secret lives only in `.env` — which stays out of
version control — the recipe itself remains safe to share, and different
environments can supply different values without touching the config.

Think of this as a companion to proper secret management, not a replacement for
it. It solves the specific problem of secrets leaking into recipe config; you
should still store the underlying values securely (environment variables, and a
[Key](https://www.drupal.org/project/key) entity where a module supports one)
and never commit a real secret anywhere.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. It
works entirely through the `.env` file and the `!secret` placeholder syntax,
described in "How to use it" below.

## How to use it

1. **Enable the module before importing recipe config.** The replacement happens
   during the import process, so Recipe Secrets must already be active when the
   recipe runs.

2. **Define your secrets in the site's `.env` file** — one variable per secret:

   ```
   API_KEY=your-api-key-here
   DB_PASSWORD=your-secure-password
   ```

   Keep this file out of version control. Each environment (local, staging,
   production) has its own `.env` with its own values, which is what lets one
   recipe work everywhere without edits.

   > **Using DDEV?** Store the value with DDEV's dotenv command rather than
   > hand-editing, for example
   > `ddev dotenv set .ddev/.env --api-key=<value>` (the flag `--api-key`
   > becomes the variable `API_KEY`), then `ddev restart`. Never commit
   > `.ddev/.env`.

3. **Reference the secret in your recipe's config files** using the `!secret`
   syntax, wrapping the variable name in double braces:

   ```yaml
   pi.settings:
     api_key: '!secret {{API_KEY}}'

   database:
     password: '!secret {{DB_PASSWORD}}'
   ```

   When the recipe is applied, each `!secret {{NAME}}` is swapped for the value
   of `NAME` from `.env`, so the imported, active configuration holds the real
   secret while the recipe on disk holds only the placeholder.
