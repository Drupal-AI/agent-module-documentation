# Smart Title UI — agent index

Optional admin submodule for **Smart Title**. Adds a single settings form at
`/admin/config/content/smart-title` where you tick which content-entity **bundles** are
Smart-Title-eligible. It renders no titles itself — the parent module does that. See the parent
for the underlying mechanism (the `smart_title.settings` config key and per-view-display
third-party settings):
[../../../../1.0.x/agent/configure/smart-title.md](../../../../1.0.x/agent/configure/smart-title.md).

Depends on `smart_title:smart_title`. Configure route `smart_title_ui.settings`. Defines one
permission; no Drush, no plugins, no config object or schema of its own (it edits the parent's
`smart_title.settings`).

- **The settings form: which bundles it lists, what saving writes, display cleanup** →
  [configure/settings.md](configure/settings.md)
- **The permission it defines** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Route `smart_title_ui.settings` → `/admin/config/content/smart-title`,
  `_form: \Drupal\smart_title_ui\Form\SmartTitleConfigForm`,
  `_permission: 'administer smart title'`, `_admin_route: TRUE`.
- Menu link `smart_title_ui.settings` under `system.admin_config_ui` (Configuration » User
  interface), title "Smart Title", weight 91.
- Form extends `ConfigFormBase`, form id `smart_title_config_form`, editable config
  `smart_title.settings`.
- Saving writes the checked `entity_type:bundle` list to `smart_title.settings.smart_title`,
  unsets the `smart_title` third-party settings (`enabled`, `settings`) on view displays of any
  unchecked bundle, and invalidates the `entity_field_info` cache tag.
- Stores no config of its own; safe to disable once bundles are chosen.
