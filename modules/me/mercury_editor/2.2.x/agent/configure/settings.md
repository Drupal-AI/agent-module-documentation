<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Mercury Editor

Single config object **`mercury_editor.settings`** (plus `mercury_editor.menu.settings`). Main
form route **`mercury_editor.settings`** at `/admin/config/content/mercury-editor` (permission
*administer site configuration*). Three sibling forms are tabs on the same page:

| Route | Path | Purpose |
|---|---|---|
| `mercury_editor.settings` | `/admin/config/content/mercury-editor` | Bundles, edit-tray theme, mobile presets. |
| `mercury_editor.skip_form_settings` | `…/skip-form` | Paragraph types whose create form is skipped (`skip_create_form`). |
| `mercury_editor.menu_settings` | `…/menu` | Component menu groups (`mercury_editor.menu.settings` → `groups`). |
| `mercury_editor.dialog_settings` | `…/dialog` | Dialog defaults, tray width, rollover padding. |

## Enabling Mercury Editor for a bundle

The authoritative key is **`bundles`** — a nested map `entity_type → { bundle: bundle }`.
Ticking a bundle on the settings form writes e.g.:

```yaml
bundles:
  node:
    landing_page: landing_page
```

Only entity types that expose a `mercury_editor` form handler are listed (node, taxonomy_term,
block_content by default). The bundle must be set up for **Layout Paragraphs** (a
layout-paragraphs field) for the builder to have anything to edit. (`content_types` is a
legacy key migrated into `bundles` by update 9001 — do not use it.)

## `mercury_editor.settings` keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `bundles` | map | `{}` | Enabled bundles per entity type (see above). |
| `edit_screen_theme` | string | `''` | Theme for the edit tray; `''` = same as admin theme. |
| `mobile_presets` | list | iPhone 12 Pro / XR / Pixel 5 | Preview device sizes; form format `name|width|height` per line. |
| `skip_create_form` | list | `{}` | Paragraph types inserted without showing their create form. |
| `dialog_settings` | map | `_defaults` (fit-content, `lpb-dialog`, resizable) | Per-dialog-type width/height/class/resizable/drupalAutoButtons. |
| `dialog_tray_width` | int | `400` | Default width (px) of the edit tray. |
| `rollover_padding_block` | int | `10` | Vertical hover padding around components. |
| `rollover_padding_inline` | int | `0` | Horizontal hover padding. |
| `content_types` | (legacy) | — | Deprecated; migrated to `bundles`. |

## Read / write via drush + PHP

```bash
drush cget mercury_editor.settings bundles
```

```php
// Enable Mercury Editor on the node "landing_page" bundle:
$c = \Drupal::configFactory()->getEditable('mercury_editor.settings');
$c->set('bundles.node.landing_page', 'landing_page')->save();

// Disable: clear the key.
$c->clear('bundles.node.landing_page')->save();
```

The main form (`SettingsForm`, id `mercury_editor_settings_form`) saves `edit_screen_theme`,
`bundles`, and `mobile_presets`; the other tabs own the remaining keys.
