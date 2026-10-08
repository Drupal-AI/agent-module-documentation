<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autoban — agent index

Automatically bans IP addresses by scanning the **dblog/watchdog** table for matching log
entries and, when a rule's **threshold** is exceeded, banning the IP through a **ban provider**
(core Ban by default). Depends on `dblog`. Config UI at `/admin/config/people/autoban`
(configure route `autoban.settings`, permission `administer autoban`).

State lives entirely in config: the `autoban.settings` object + one `autoban.autoban.<id>`
config entity per rule (`config_export`: id, type, message, referer, threshold, window,
user_type, provider, rule_type).

- **Create/read ban rules (the `autoban` config entity) and global settings keys** →
  [configure/rules-and-settings.md](configure/rules-and-settings.md)
- **Ban providers: the `ban_providers` tagged-service system + `AutobanProviderInterface`
  (and which submodule supplies which provider id)** → [plugins/ban-providers.md](plugins/ban-providers.md)
- **Drush `autoban:ban`** → [drush/ban.md](drush/ban.md)
- **Permission `administer autoban`** → [permissions/permissions.md](permissions/permissions.md)

Submodules (documented separately, nested under this project):
`autoban_ban` (core Ban provider `ban`), `autoban_advban` (`advban`/`advban_range`),
`autoban_dblog` (adds ban links to the Recent log messages report).

Key fact: a rule's `provider` field stores a ban-provider **id** (e.g. `ban`); rules run on
cron (`autoban_cron`), on every request in force mode (`autoban_force_mode`), from the UI, or
via `drush autoban:ban`.
