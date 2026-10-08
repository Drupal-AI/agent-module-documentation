# Potx Extract Translations (PET) — manual setup guide

**Potx Extract Translations (PET)** (`drush_pet`) adds a Drush command that
extracts translatable strings from your Drupal code and writes them out as PO
translation files, one per project and language. It builds on the
[POTX](https://www.drupal.org/project/potx) (Translation Template Extractor)
engine, giving module, theme and profile developers a fast, repeatable way to
generate up-to-date `.po` files from source on the command line — no clicking
through UI tools.

This `1.1.x` release provides the command `potx:extract-translations` (alias
`pet`). For each matched extension it gathers the project's source files, runs
POTX, and writes a `translations/<project>.<lang>.po` file inside the project
directory. It also patches each project's `.info.yml` with the correct
`interface translation project` and `interface translation server pattern` so
Drupal knows where to load the translations from. You can extract a single named
project or process everything at once, and filter by project type or by a path
segment such as `custom`, `contrib` or `shared`.

Because it only adds a Drush command — and because it writes into your project's
source tree — this module is meant for **development / local use**, not
production runtime. It depends on the POTX module, and this release targets
Drupal 11.3+ or 12 with Drush `^13`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

> **Note on versions:** this is the **1.1.x** line (Drupal 11.3+/12, Drush ^13),
> which renames the command to `potx:extract-translations` (alias `pet`) and
> documents its options in full. The older **1.0.x** line targets Drupal 10.5/11.
> Pick the version that matches your core.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   make sure POTX and a translatable language are present.

There is **no configuration page** for this module — it ships no settings form,
no config UI and no permissions. It is used entirely through its Drush command.

## How to use it

PET adds no admin page. After enabling it, run the command from the command line.
Its behavior, argument and options:

- **`drush potx:extract-translations [project]`** (or the alias `drush pet
  [project]`) — extract translatable strings and write `.po` files. Give a
  project's machine name to target just that module/theme/profile; omit it to
  process all matched projects.
- **`--type=module|theme|profile`** — restrict to one project type. Any other
  value errors out.
- **`--group=custom`** *(default `custom`)* — only include projects whose
  filesystem path contains this segment (for example `custom`, `contrib`,
  `shared`).
- **`--language=nl`** — extract a single language code. When omitted, PET uses
  all configured, unlocked, translatable languages (or the site's default
  language on a monolingual site).

For each project × language, PET collects the project's files (excluding any
nested `modules/` — submodules are handled as their own projects), runs POTX, and
either writes `translations/<project>.<lang>.po` or, when no translatable strings
are found, skips that pairing. It finishes with a progress bar and a summary
table of Project / Language / File (or "Skipped").

Some examples:

```bash
# A single project.
drush potx:extract-translations my_module

# All custom modules.
drush potx:extract-translations --type=module

# All themes under a "shared" path segment.
drush potx:extract-translations --type=theme --group=shared

# Only Dutch, across all custom projects.
drush potx:extract-translations --language=nl

# Everything: all types, all languages, the custom group.
drush potx:extract-translations
```

Because the command edits the project source tree (creating a `translations/`
directory and modifying `.info.yml`), run it locally and commit the results with
your code — don't run it against a production install.
