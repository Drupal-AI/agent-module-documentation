# Remove system.schema key/value — manual setup guide

**Remove system.schema key/value** (`rmkv`) is a targeted recovery tool for one
specific, maddening Drupal failure state. It happens when a module is removed from
the codebase — deleted from `modules/`, dropped from Composer — *without being
uninstalled first*. The code is gone, but the module's entry in the
`system.schema` key/value store remains. Drupal now knows about a module it can no
longer find: update runs warn about it, `drush pm:uninstall` can't act (there's no
code left to run `hook_uninstall()`), and the site carries a phantom dependency.

The correct fix is surgical — delete the orphaned `system.schema` entry directly —
but doing that by hand means a raw key/value delete against the database, which is
exactly the kind of manual operation that's easy to get wrong. This module packages
that fix as **Drush commands**, so the operation is named, repeatable, and far less
error-prone than a hand-written query.

Two commands do the work:

- **`drush rmkv:check`** — check whether a given machine name *can* be removed from
  the `system.schema` store (a safe, read-only look before you leap).
- **`drush rmkv`** — remove the specified machine name from the `system.schema`
  store.

Please treat this as a **maintenance and recovery tool, not a site feature**. It
belongs in a developer's or operator's toolkit, run deliberately when this
situation arises — not left enabled as part of a site's normal function. Because it
deletes schema bookkeeping, use it only when you are certain which entry is
orphaned: removing the wrong key would tell Drupal that a still-present module has
been uninstalled. **Back up your database before running it.**

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no configuration page** — it is a command-line recovery utility.
Its usage is described below. (From v2.0.0 onward the optional in-browser form has
been split into a separate `rmkv_form` submodule.)

## How to use it

1. **Back up your database first.** This operation deletes schema bookkeeping and
   is not something to do casually.
2. Identify the machine name Drupal is complaining about (the "Module *X* has an
   entry in the system.schema key/value storage, but is missing from your site"
   warning).
3. Check that it is safe to remove:

   ```bash
   drush rmkv:check the_missing_module
   ```

4. If the check confirms the entry is orphaned, remove it:

   ```bash
   drush rmkv the_missing_module
   ```

5. Rebuild caches and confirm the warning is gone.

> **Confirm which entry is orphaned before removing it.** Removing the key for a
> module whose code is *still present* would tell Drupal it has been uninstalled,
> which is worse than the warning you started with. That is what `drush rmkv:check`
> is for.
