# Configuration

## Settings page
- Route: `uikit_components.admin` — path `/admin/config/user-interface/uikit_components`
  (the `configure` route in `uikit_components.info.yml`).
- Permission: `administer site configuration` (Drupal core; the module defines none of
  its own).
- Form: `Drupal\uikit_components\Form\AdminForm` (`ConfigFormBase`,
  form id `uikit_components_form`).
- Local tasks (`uikit_components.links.task.yml`): **Configure** (admin form),
  **Core components** (`uikit_components.core`), **Advanced components**
  (`uikit_components.advanced`). A menu link (`uikit_components.links.menu.yml`) puts it
  under Configuration › User interface.

The main form only renders fields when the UIkit base theme is installed (it reads the
UIkit library version via `UIkitComponents::getUIkitLibraryVersion()`; if the theme is
missing it shows an error and no fields):

| Field | Type | Config key | Default |
|-------|------|-----------|---------|
| UIkit Framework Version | item (read-only) | — (display only) | from UIkit theme's `uikit.libraries.yml` |
| Enable configurable menu styles | checkbox | `additional_menu_styles` | `true` |

`additional_menu_styles` drives the whole menu-styling feature
([theme/menu-styles.md](../theme/menu-styles.md)). `AdminForm::submitForm()` saves it and
calls `drupal_flush_all_caches()`.

### Core / Advanced forms
`CoreForm` (`uikit_components_core_form`) and `AdvancedForm`
(`uikit_components_advanced_form`) currently render only empty fieldsets (Layout,
Navigations, Elements/Common, JavaScript) and save empty config objects
`uikit_components.core` / `uikit_components.advanced`. They are placeholders for future
per-component toggles — no functional settings in this release.

## Config objects & schema
`config/schema/uikit_components.schema.yml` defines:

- `uikit_components.settings` (type `mapping`) — `uikit_framework_version` (string).
  Note: the installed default (`config/install/uikit_components.settings.yml`) actually
  ships `additional_menu_styles: true`, which is the value the code reads/writes.
- `uikit_components.core` / `uikit_components.advanced` (`config_object`) — empty
  `uikit_components` mapping placeholders.
- `block.settings.*.third_party.uikit_components` — `uikit_navbar_alignment` (integer),
  the navbar block third-party setting.

## Set via Drush / PHP
```bash
# Toggle the configurable menu styles feature.
drush config:set uikit_components.settings additional_menu_styles true
drush cr
```
```php
\Drupal::configFactory()
  ->getEditable('uikit_components.settings')
  ->set('additional_menu_styles', TRUE)
  ->save();
```

Per-menu styles are **not** stored in config — they live in Drupal state keyed by menu
id (see [theme/menu-styles.md](../theme/menu-styles.md) and
[api/helpers.md](../api/helpers.md)).
