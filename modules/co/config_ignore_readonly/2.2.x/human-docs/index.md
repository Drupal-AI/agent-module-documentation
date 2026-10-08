# Config Ignore Readonly — manual setup guide

**Config Ignore Readonly** (`config_ignore_readonly`) is a small bridge between two
popular configuration-management modules: **Config Ignore** and **Config Readonly**.
Its job is to let a handful of settings forms stay editable in the admin UI even while
the rest of your site's configuration is locked down.

Here's the problem it solves. **Config Readonly** protects a production site by making
*every* config form read-only — submit buttons are disabled with a warning, so nobody
can accidentally change configuration that should only ever come from your deployment
pipeline. But there are usually a few settings you *do* want editable per environment
(a third-party API key, a "from" email address, `system.performance`, and so on).
**Config Ignore** already lets you mark exactly those configuration items as "ignored"
so they can drift per environment. This module joins the two: it takes the list of
config that Config Ignore is ignoring and tells Config Readonly to keep *those* forms
submittable, while everything else stays locked.

The result is a "locked except these" configuration posture built entirely from contrib
modules — and you maintain a single list (in Config Ignore) rather than two. The module
itself has **no UI, no settings, no permissions, and no Drush** — it is a single hook,
so once the three modules are enabled it just works.

This guide is written for a **human**. If you want terse, token-cheap references for an
AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable this module
   alongside Config Ignore and Config Readonly.

## Where it lives in the admin menu

Nowhere of its own. You control its behaviour entirely through **Config Ignore's**
settings — this module adds no admin pages, settings, or menu items.

## How to use it

Because the module has no configuration, using it means managing Config Ignore's ignore
list. **To make a config form stay editable while Config Readonly is active, add that
form's configuration name to Config Ignore's ignore list.**

For example, to keep the *Basic site settings* form (which edits `system.site`) editable
on a locked-down site, add `system.site` to Config Ignore. The simplest way with Drush:

```bash
# See the current ignore list:
drush cget config_ignore.settings ignored_config_entities

# Add a config name to it (simple mode is a flat list of names / glob patterns):
drush cset config_ignore.settings ignored_config_entities.0 system.site -y
```

After a cache rebuild, the *Basic site settings* form at
`/admin/config/system/site-information` stays submittable even with Config Readonly
active, while every other form remains locked. Glob patterns work just as they do in
Config Ignore, e.g. `system.*` or `webform.webform.*`.

### Good to know / limitations

- Only Config Ignore's **simple**-mode list (its import/update patterns) is used.
- **Force-import** patterns (`~name`) and **partial / sub-key** patterns
  (`config.name:some.key`) are **not** honoured — the whole config name must be ignored.
- A form that edits **several** config objects at once only becomes editable when **all**
  of those config names are ignored.
- The module respects other modules' `hook_config_ignore_ignored` alterations, so
  patterns added programmatically are included too.
