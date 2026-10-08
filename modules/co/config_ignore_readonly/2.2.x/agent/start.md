<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Ignore Readonly — agent index

Bridges **Config Ignore** and **Config Readonly**. When Config Readonly locks all config
forms, this module whitelists exactly the forms whose config is ignored by Config Ignore, so
those stay submittable. No UI, no settings (`configure: null`), no permissions, no schema, no
Drush, no plugins. Its entire behaviour is one hook.

- **How it works, which patterns it forwards, limitations, and how to make a form editable
  under readonly** → [api/mechanism.md](api/mechanism.md)

Key facts:
- Requires modules `config_ignore` (^3) and `config_readonly` (^1), both must be enabled.
- The single hook `config_ignore_readonly_config_readonly_whitelist_patterns()` returns
  `ConfigIgnoreConfig::fromConfig(config('config_ignore.settings'))->getFormated('simple')`
  — i.e. Config Ignore's `import`/`update` pattern list (`config_ignore.settings` key
  `ignored_config_entities` in simple mode).
- To make a config form editable while readonly is active, **add its config name to Config
  Ignore's ignore list** (`config_ignore.settings:ignored_config_entities`).
- Not supported: `~name` force-import patterns, `name:sub.key` partial patterns; and a form
  with multiple `getEditableConfigNames()` needs *all* of them ignored.
