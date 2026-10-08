# Config Ignore — manual setup guide

**Config Ignore** (`config_ignore`) keeps chosen pieces of configuration from
being overwritten when you import configuration into a site — for example with
`drush config:import` or the **Configuration synchronization** screens. Drupal's
normal config workflow replaces the site's active configuration with whatever is
in the sync folder on import (and the reverse on export). That is a problem when
some settings must stay different on each environment: an API key on production,
a `system.site` name and email, or development-only module settings you never
want deployed. Config Ignore lets you list those configuration names so they are
**skipped** during the transform, and the site's own active value is preserved.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with a screenshot, from installing the module to listing the
configuration you want protected. If you are looking for terse, token-cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

![The Config Ignore settings page, showing the mode selector and pattern examples](images/settings.png)

## Where it lives in the admin menu

Config Ignore adds an **Ignore** tab to core's configuration management screens,
at **Configuration → Development → Configuration synchronization → Ignore**
(`/admin/config/development/configuration/ignore`). It sits alongside the built-in
**Synchronize**, **Import**, and **Export** tabs, so the ignore list lives right
next to the import/export tools it affects. Access uses core's *import
configuration* permission, so any user who can synchronize configuration can edit
the ignore list.

## Contents

1. [Installation](installation/index.md) — install Config Ignore with Composer and
   enable it.
2. [Configuration](configuration/index.md) — list the configuration names to
   ignore, using exact names, wildcards, and single-key patterns.
