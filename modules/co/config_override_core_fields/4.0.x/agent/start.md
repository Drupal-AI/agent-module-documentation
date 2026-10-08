<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Override Core Fields — agent index

A **helper/data-provider only** — no user-facing feature, no config, no permissions, no
plugins, no configure route. Its entire job is one `hook_form_alter()` that tags elements on
core system-settings forms with `#config['key'] = '<config_object>:<key>'`, so a consumer
(most notably [COI](https://www.drupal.org/project/coi)) can tell which config each field
edits and flag overrides.

- **The form → config-key mapping it adds, which forms are covered, and the `#config`
  convention** → [api/form-config-hints.md](api/form-config-hints.md)

Key facts:
- Nothing changes visibly on its own; enabling it just adds render-array metadata.
- Convention: `$element['#config']['key'] = 'system.site:name'` (a `config.name:dotted.key`).
- Covered forms are a fixed list keyed by form id (system site info, performance, cron, file
  system, logging, maintenance, themes, update, user settings, search, views UI).
- Consumers read `#config['key']` (or the core WIP `#config_data_store['key']`).
