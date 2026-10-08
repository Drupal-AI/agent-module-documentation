# Locale Download — manual setup guide

**Locale Download** (`locale_download`) gives administrators a controllable way to
download interface‑translation (`.po`) files from Drupal's remote localization
server into the site's local translations directory — without changing any
configuration and without manually running individual "check" and "update"
commands for each project. It is driven entirely by a Drush command.

The command first checks the translation status for all projects, then downloads
any missing translation files to your translations path. Because the translation
status cache and the files on disk can drift out of sync, a `--force` flag is
provided that clears the cache and re‑downloads all missing files. You can also
narrow the work to specific projects or languages.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — the module has no settings form. Everything
happens through the Drush command described below.

## Where it lives in the admin menu

Locale Download adds nothing to the admin menu. It is an administration tool
driven from the command line via Drush. Because it writes files to the
filesystem, run it in an environment where that is appropriate.

## How to use it

The core command is:

```bash
drush locale:download
```

This checks translations for all projects and downloads any missing files to your
translations directory. Useful options:

- **`--force`** — delete the translation status cache and download all missing
  files. Use this when the status cache and the files on disk have drifted apart.
- **`--projects`** — a comma‑separated list of projects to limit the download to.
- **`--languages`** — a comma‑separated list of language codes to limit the
  download to.

For example, to download translations for the `drupal` and `admin_toolbar`
projects in German only:

```bash
drush locale:download --projects drupal,admin_toolbar --languages de
```
