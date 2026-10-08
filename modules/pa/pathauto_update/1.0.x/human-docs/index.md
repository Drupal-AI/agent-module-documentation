# Pathauto Update — manual setup guide

**Pathauto Update** (`pathauto_update`) fixes a long‑standing gap in Pathauto:
aliases go stale when the *values behind their tokens* change. Pathauto builds an
alias from a token pattern at save time and then forgets. A pattern like
`[node:field_category:entity:name]/[node:title]` produces `/health/flu-advice` —
but when someone renames the "Health" term to "Wellbeing", every alias built from
it silently keeps saying `health`, because nothing resaved those nodes. The usual
remedy is an expensive, easy‑to‑forget mass resave.

This module tracks the dependency instead. When an entity with an alias is saved,
it records which entities, configuration, and other aliases that alias's tokens
depend on. Later, when one of those dependencies changes, the aliases that relied
on it are **automatically regenerated**. Dependencies are worked out
automatically from the tokens in your Pathauto pattern — if your pattern contains
`[site:name]`, aliases using it regenerate when the site name changes. Developers
can support additional token types by adding a `PatternTokenDependencyProvider`
plugin rather than patching the module.

**There is nothing to configure.** During installation the module collects the
dependencies of existing aliases; future aliases are tracked automatically. The
one operational requirement is that regeneration happens through **Drupal's queue
system**, so your site must process queues regularly (see "How to use it").

Two things to keep in mind on a large site: renaming a widely‑used term can
cascade into regenerating thousands of aliases, so make sure that work is batched
or queued; and if the **old** aliases still matter for SEO, this module changes the
alias but does not preserve the old one — Pathauto's own "create a redirect"
setting is what keeps the old URL alive.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (Pathauto, Token, and URL Entity are required).

This module has **no settings form** — there's nothing to configure. Its one
operational need, queue processing, is covered under "How to use it" below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). Installation
   automatically indexes the dependencies of your existing aliases.
2. Make sure your site **processes queues regularly** — for example on cron runs,
   or with a tool like the *Drush Queue Run All* module. Regenerated aliases are
   produced by two queues:
   - `pathauto_update_path_alias_dependency_updater`
   - `pathauto_update_path_alias_updater`
3. You can process them manually at any time with Drush:

   ```bash
   drush queue:run pathauto_update_path_alias_dependency_updater
   drush queue:run pathauto_update_path_alias_updater
   ```
4. To preserve old URLs for SEO, keep Pathauto's own **"create a redirect"** option
   enabled — this module updates the alias but does not keep the previous one
   alive on its own.
