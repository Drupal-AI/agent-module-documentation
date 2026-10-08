# Requirements Manager — agent index

Admin UI to hide or re-severity individual entries on the Status Report (`/admin/reports/status`) via
`hook_runtime_requirements_alter()`. Depends on core `system`. Requires PHP 8.3 / Drupal 11.2+. Provides
config schema; no permission of its own (uses `administer site configuration`), no Drush, no plugin types.

- **The settings form, the config structure, and how the alter hook applies overrides** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config UI: route `requirements_manager.settings_form` → `/admin/config/system/requirements-manager`
  (`RequirementsManagerSettingsForm`, permission `administer site configuration`).
- Overrides stored in `requirements_manager.settings` → `requirements` (sequence keyed by requirement id,
  each `{action, severity?, reason?}`); only non-`show` actions are saved.
- Applied by `RequirementsManagerHooks::runtimeRequirementsAlter()` (`#[Hook('runtime_requirements_alter',
  order: Order::Last)]`): `hide` unsets the key; `change_severity` remaps to Info/OK/Warning/Error and
  appends an alteration notice.
