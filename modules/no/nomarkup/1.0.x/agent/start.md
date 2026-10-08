<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# No Markup — agent index

Adds a per-formatter **"Remove field markup"** toggle to every field's *Manage display* row.
When on, the field renders through a bare template with no wrapper HTML. No settings form
(`configure: null`), no permission, no dependencies. Its only persistent state is a
**third-party setting** on a formatter component in an `entity_view_display` config entity.

- **Enable it on a field / read where it's stored / separator / referenced-entity option** →
  [configure/remove-markup.md](configure/remove-markup.md)
- **How it works (theme suggestions, templates) and the `nomarkup` Views style** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Stored at `core.entity_view_display.<entity>.<bundle>.<view_mode>` →
  `content.<field>.third_party_settings.nomarkup.{enabled,separator,referenced_entity}`.
- `enabled` bool; `separator` (default `|`) joins multi-value output; `referenced_entity`
  only applies to the `entity_reference_entity_view` formatter on entity_reference fields.
- Also provides a Views style plugin `nomarkup` (theme `views_view_nomarkup`).
