# Paragraphs View Modes — agent index

Provides one Paragraphs **behavior plugin**, `paragraphs_viewmode_behavior`, that lets editors
pick a paragraph's view mode per instance. No settings form, no configure route, no permissions,
no Drush, no plugin type of its own. Depends on `paragraphs`.

- **Enable the behavior on a paragraph type + the three settings keys, and where they are stored** →
  [configure/behavior.md](configure/behavior.md)
- **How the per-paragraph choice is saved and how the view mode is actually swapped at render** →
  [api/mechanism.md](api/mechanism.md)

Key fact: settings live on `paragraphs.paragraphs_type.<type>` →
`behavior_plugins.paragraphs_viewmode_behavior` with keys `enabled`, `override_mode`,
`override_available` (map), `override_default`. The per-paragraph pick is stored as the behavior
setting `view_mode` on the paragraph entity, and applied via `hook_entity_view_mode_alter()`.
