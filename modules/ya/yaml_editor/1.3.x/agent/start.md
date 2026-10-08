<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# yaml_editor — agent start

Loads an **Ace** code editor over any `textarea[data-yaml-editor]` on **admin routes**,
giving YAML fields highlighting + 2-space indent. Two ways in: (1) a `hook_page_attachments`
that attaches the JS on admin routes, and (2) a `yaml_editor` field widget for `string_long`
fields (subclasses core `StringTextareaWidget`). Ace is loaded lazily from a configurable
CDN/source URL; the Ace theme is configurable. No YAML *validation*, just editing.

- Settings form + config keys (`editor_source`, `editor_theme`), route, permission → [configure/settings.md](configure/settings.md)
- Enable the editor on a field or in your own form (widget + `data-yaml-editor`) → [api/attach.md](api/attach.md)

Facts: config object `yaml_editor.config` · route `yaml_editor.config` →
`/admin/config/development/yaml_editor` · permission `configure yaml_editor` ·
library `yaml_editor/yaml_editor` · widget id `yaml_editor` (label "Text area with YAML
editor", field type `string_long`). No Drush commands, no dependencies, no submodules.
