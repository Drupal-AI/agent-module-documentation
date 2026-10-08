# Translation template extractor (potx) — manual setup guide

**Translation template extractor** (`potx`) scans Drupal source code and produces
standard Gettext `.pot` **translation templates** — the files translators use as
the starting point for localizing a module, theme, folder or file. It can also
emit ready‑to‑use `.po` translation files when you target a specific language.

potx walks a component's files and finds every translatable string, wherever it
lives: PHP (`t()`, `$this->t()`, `format_plural()`, `TranslatableMarkup`),
JavaScript (`Drupal.t`, `Drupal.formatPlural`), Twig (`{% trans %}`, `|t`), plugin
annotations/attributes (`@Translation(...)`), `.info.yml` files, config schema
labels, and shipped default configuration. It then writes them into a Gettext
template that a translation team can work from.

There are two ways to use it: a **web interface** at *Configuration → Regional →
User interface translation → Extract*, which lists your installed modules and
themes so you can pick one and download its template; and a **Drush command**
(`drush potx`) for command‑line extraction, which is ideal for scripting or
extracting from arbitrary folders. The extractor targets a Drupal API version
(defaulting to the current one), which controls which code patterns it recognises.

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent — including the full option table and the `potx.inc` API
other tools call — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

potx has **no settings page** — its only screen is a one‑shot extraction form. You
will find it as the **Extract** tab on **Configuration → Regional → User interface
translation** (`/admin/config/regional/translate/extract`). Access is governed by
core's existing **Translate interface** permission; potx defines no permission of
its own.

## How to use it

### From the admin UI

1. Go to **Configuration → Regional → User interface translation → Extract**.
2. Pick the module or theme you want from the directory tree of installed
   components (directories with several components can be expanded, with an
   "extract from all in directory" option).
3. If your site has more than one language, you can optionally choose a
   **language‑dependent** template (which includes the correct plural formula) and
   tick **Include translations** to export existing translations too — this turns
   the download into a `.po` file rather than a `.pot`.
4. Submit, and the generated file streams to your browser as a download.

> If you get a blank white response, PHP's `memory_limit` is usually too low for
> the extraction — raise it and try again.

### From the command line

```bash
drush potx                             # extract from the current directory -> general.pot
drush potx multiple --modules=token    # per-module .pot for the token module
drush potx --files=web/modules/contrib/potx/potx.module
drush potx single --folder=web/modules/contrib/potx
```

`drush potx` takes a **mode** as its first argument:

- **`single`** (default) — fold every file into one output template.
- **`multiple`** — produce one `.pot` per module.
- **`core`** — Drupal‑core style output, folding `.info` strings into
  `general.pot`.

Useful options include `--modules=`, `--files=`, `--folder=`, `--api=` (target a
Drupal API version, e.g. `7` for legacy code), `--language=` (build a
language‑dependent template) and `--translations` (also export existing
translations — needs `--language`). Files are written to your **current working
directory**, so `cd` into the folder you want them in before running. See the
[`agent/`](../agent/start.md) docs for the full reference.
