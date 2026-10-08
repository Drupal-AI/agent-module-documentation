# Config Ignore Auto — manual setup guide

**Config Ignore Auto** (`config_ignore_auto`) is an extension of the
[Config Ignore](https://www.drupal.org/project/config_ignore) module. It watches
for configuration that gets **edited on the live site** and automatically adds each
changed config object to Config Ignore's ignore list — so those in-place edits are
protected from being overwritten the next time you import configuration
(`drush cim`).

The classic scenario is a client-managed site: your editors build Views, Webforms,
blocks, menus, and taxonomy in the admin UI on production, and you deploy code with
`drush cim`. Normally an import would revert their live edits back to whatever is in
your exported config. With Config Ignore Auto turned on, each thing they change is
quietly added to the ignore list, so their work survives your deployments.

The module is **inactive until you switch it on**. The recommended pattern is to
enable it only in production via a `settings.php` override, so it never captures
config changes made during local development, CI, or config sync. It is deliberately
careful about *when* it records changes: it ignores nothing during config sync,
during module install/uninstall, or while the site is in maintenance mode — so that
database updates (`hook_update_N`) that change config are not accidentally captured.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   Config Ignore) and enable the module.
2. [Configuration](configuration/index.md) — the settings form, turning it on in
   production, the whitelist, sync directions, and how to review the auto-generated
   ignore list.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Configuration
synchronization → Ignore Auto**
(`/admin/config/development/configuration/ignore_auto`). It requires the core
**Import configuration** permission (`import configuration`).
