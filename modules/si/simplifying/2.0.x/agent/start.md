# Simplifying — agent index

Config-driven admin declutter tool. One settings form (`/admin/config/development/simplifying`,
route `simplifying.settings`) writes one config object `simplifying.settings`; hooks then hide
toolbar tabs, admin menu links, entity-form fields, local task tabs and contextual links. All
hiding is UI convenience (`#access = FALSE` / pruning admin chrome), **not** access control.
Depends on `js_cookie`. No Drush, no plugin types.

- **Settings form, every `simplifying.settings` key, defaults, the full-administration cookie** →
  [configure/settings.md](configure/settings.md)
- **The three alter hooks other modules can implement** → [hooks/hooks.md](hooks/hooks.md)
- **The three (all restricted) permissions** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object: `simplifying.settings` (schema `config/schema/simplifying.schema.yml`); no config entities.
- Field hiding runs via `hook_form_{node,user,comment,taxonomy_term,block_content}_form_alter`
  (forced to run last by `hook_module_implements_alter`) → `EntityFields::hideFields()`.
- Full-administration bypass: presence of the `simplifying` browser cookie → `SettingsActions::isFullAdministration()` returns TRUE and no hiding is applied.
- Own DB table `simplifying_entity_unread` tracks new/unread entities for a toolbar indicator.
- Optional integration with contrib `basket` admin menu (`simplifying_basket_admin_page_alter`).
- AJAX route `simplifying.local_task_toggle` (`/simplifying/{action}`) toggles local-task tabs
  (writes config).
