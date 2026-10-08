# L10n Tools — manual setup guide

**L10n Tools** (`l10n_tools`) is a maintenance tool for cleaning up Drupal's
interface‑translation tables. Those tables only ever grow: `locales_source` gains a
row for every translatable string any module has ever declared, `locales_target`
one for every translation of each, and `locales_location` one for every place a
string was found. Uninstalling a module does not remove its strings, and disabling
a language does not remove its translations. On a long‑lived multilingual site the
totals reach hundreds of thousands of rows, and the cost is real — every database
export and import carries them, the translation admin interface pages through them,
and cache warming and translation rebuilds slow down in proportion.

L10n Tools gives you an administration screen (and, per the project, Drush
commands) to prune the dead weight: translations that are identical to their source
string, orphaned or untranslated entries, and stale translation‑update status that
can be reset so it re‑checks localize.drupal.org. It depends only on core's
**Interface Translation** (`locale`) module.

Two cautions before you use it, because this tool **deletes data**:

- **Custom translations are not recoverable.** A string you translated by hand in
  the UI (rather than importing from a `.po` file) exists *only* in your database.
  If a cleanup judges it orphaned and deletes it, that work is gone and cannot be
  re‑downloaded. **Take a database backup first.**
- **"Orphaned" is a judgement about the current codebase.** A module that is only
  temporarily uninstalled, or enabled on another environment, has strings that look
  obsolete here but aren't. Don't run cleanups on a site whose module set is in
  flux.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the cleanup tool's tabs and what each
   one deletes, with the safety steps to take first.

## Where it lives in the admin menu

Once enabled, the tool adds a menu link at **Configuration → Regional and language
→ L10n Tools**. Access is gated by the **access l10n_tools form** permission, which
is correctly marked as restricted because the form deletes data.
