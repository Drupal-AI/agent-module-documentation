# Config Ignore Webform — manual setup guide

**Config Ignore Webform** (`config_ignore_webform`) is a Webform-aware companion to
the [Config Ignore](https://www.drupal.org/project/config_ignore) module. Its job is
to keep everyday webform edits made on production — new forms, tweaked option lists
— from being overwritten when you run a configuration import during deployment,
while still letting you sync the webforms you *do* want managed in code.

By default it tells Config Ignore to ignore all `webform.webform.*` and
`webform.webform_options.*` configuration during import and export. But it's smarter
than a blanket rule in two ways:

- **Templates always sync.** Any webform marked as a template (`template: true`) is
  always imported/exported normally, so your reusable starting-point forms stay in
  code.
- **You choose the exceptions.** A settings form lets you pick specific
  non-template webforms and specific option lists that should still sync, even
  though everything else is ignored.

Under the hood it plugs into Config Ignore via `hook_config_ignore_ignored_alter()`
to add these Webform-specific rules (templates plus your allowlist). It requires
**Config Ignore** (`^3`) and **Webform** (`^6`), and supports Drupal 10.3+ and 11.

> **Understand the trade-off.** Ignored config is *not* tracked in version control —
> that's the whole point for editor-managed forms, but it means those forms live
> only in the database and won't be captured by `drush config:export`. Make sure
> your backup strategy covers them. (Don't confuse this with the separate *Webform
> Config Ignore* module, which uses a Config Filter plugin and has no template
> exceptions — it's a different project.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Config Ignore and Webform.
2. [Configuration](configuration/index.md) — pick which non-template webforms and
   option lists should still sync.

## Where it lives in the admin menu

Its settings form can be reached from either of two places:

- **Structure → Webforms → Config ignore** (`/admin/structure/webform/config/ignore`), or
- **Configuration → Development → Configuration synchronization → Webforms**
  (`/admin/config/development/configuration/webform-ignore`).
