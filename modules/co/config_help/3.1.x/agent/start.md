<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configurable Help (config_help) — agent index

**Admin-editable help topics stored as configuration (`config_help` config entity), shown alongside core Help Topics.**

- **Version:** 3.1.x
- **Core:** ^11.1 || ^12
- **Depends:** help, filter.
- **Configure:** `/admin/config/development/config-help` (`entity.config_help.collection`).
- **Routes:** collection/add/edit/delete under `/admin/config/development/config-help`; autocomplete `/config-help/autocomplete-topic` (`administer config help`).
- **Permission:** `administer config help` (also the entity `admin_permission`).
- **Entity:** `config_help` config entity (id, label, top_level, related, body, body_format); `HelpAccessControlHandler`.
- **Security:** All routes and entity operations gated by `administer config help`. Autocomplete escapes output (`HtmlEscapedText`). No anonymous or mutating public endpoints.

See [configure/topics.md](configure/topics.md).
