<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Text Field Formatter — agent index

One field formatter (`text_field_formatter`) for `string` fields that extends core's
`StringFormatter` and wraps the value in an HTML tag with configurable classes and attributes.
No config UI, no permissions, no Drush, no dependencies beyond core.

- **The formatter: settings keys, where they're stored, how to set it** →
  [configure/formatter.md](configure/formatter.md)
- **`hook_default_wrap_tags_alter()` — add/remove available wrap tags** →
  [hooks/wrap-tags.md](hooks/wrap-tags.md)

Key facts:
- Formatter id `text_field_formatter` ("Text field formatter"), `field_types = {string}`.
- Settings (on top of StringFormatter's `link_to_entity`): `wrap_tag` (default `_none`;
  `div`/`h1`–`h6`/`span`, never `a`), `wrap_class` (space/comma-separated),
  `wrap_attributes` (one `attribute|value` per line), `override_link_label` (token-aware,
  used only with `link_to_entity`).
- Stored at `core.entity_view_display.<entity>.<bundle>.<mode>` → `content.<field>` with
  `type: text_field_formatter` and those `settings`.
