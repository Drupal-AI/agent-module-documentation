<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Custom Admin Menu

Settings form route `custom_admin_menu.settings_form` at `/admin/config/system/custom-admin-menu`,
gated by permission `administer custom_admin_menu configuration`. Form class
`Drupal\custom_admin_menu\Form\SettingsForm` (a plain `FormBase` writing config object
`custom_admin_menu.settings`). The `.info.yml` has no `configure:` key, so the modules page shows no
"Configure" link; reach the form via Configuration to System, or the menu link the module adds under
Configuration to User interface.

## Step 1 — create the menu (required, easy to get wrong)

The module renders links from a menu loaded by machine id **`custom-admin-menu`** (hyphens). There
is no menu-creation UI in this module and the shipped optional config
`system.menu.custom_admin_menu.yml` uses the id `custom_admin_menu` (underscores), which the code
does **not** read. So:

1. Structure to Menus to Add menu, set the machine name to exactly `custom-admin-menu`.
2. Add menu links pointing at the admin paths/routes you want in the toolbar.

```php
// Create the menu the module reads and add a link.
\Drupal\system\Entity\Menu::create(['id' => 'custom-admin-menu', 'label' => 'Custom Admin Menu'])->save();
\Drupal\menu_link_content\Entity\MenuLinkContent::create([
  'title' => 'Content', 'link' => ['uri' => 'internal:/admin/content'], 'menu_name' => 'custom-admin-menu',
])->save();
```

## Step 2 — enable and choose insertion mode

Form fields (all persist to `custom_admin_menu.settings`):

| Field label | Config key | Type | Meaning |
|---|---|---|---|
| Enable custom admin menu | `enable` | bool | Master switch. When off, all toolbar hooks return early. |
| Insert custom items in admin toolbar | `include_in_admin` | bool | **Merged mode** (on) vs **separate-menu mode** (off). |
| Insertion type | `insertion_type` | `prepend`\|`append` | Merged mode only; where custom links sit relative to default items. Saved as NULL when `include_in_admin` is off. |
| Wrap default admin menu in a single root menu item | `wrap_admin` | bool | Merged mode only; collapse the whole default admin tree under one "Admin" root so custom links lead. |
| Shortcuts region | `shortcuts_region` | string | Admin-theme region machine name (or empty) — see below. |

### Merged mode (`include_in_admin = true`)

Handled in `hook_preprocess_menu` for `menu__toolbar__admin`. The default admin items
`admin_toolbar_tools.help` and `admin_toolbar_tools.flush` are kept as leading "main" items; the
custom menu items are then `prepend`ed or `append`ed around the remaining default items. If
`wrap_admin` is on, the default items are nested under a single collapsed "Admin" item first. Users
lacking `access_default_menu` get only the main items + custom items (default tree removed); users
lacking `access_custom_menu` get no custom items.

### Separate-menu mode (`include_in_admin = false`)

Handled in `hook_toolbar_alter`. Users without `access_default_menu` have the default
`administration` toolbar tab removed entirely; users with `access_custom_menu` get a new root-level
toolbar tab (`custom-admin-menu`) whose tray renders the custom menu. `insertion_type`/`wrap_admin`
are ignored in this mode.

## Step 3 (optional) — shortcuts region

Selecting a region name in "Shortcuts region" makes the module render the **blocks placed in that
region of the admin theme** into the toolbar as an extension (`custom_admin_menu.shortcuts` service,
theme hook `custom_admin_menu_shortcuts`). Blocks are access-checked per user; title blocks get the
current page title. The region list comes from the configured admin theme
(`system_region_list(<admin theme>)`).

## Setting config by PHP / Drush

Note: `custom_admin_menu.settings` has **no config schema**, so `drush cset` warns "new config
object / new config key" — pass `-y` to accept, or set via PHP.

```php
$c = \Drupal::configFactory()->getEditable('custom_admin_menu.settings');
$c->set('enable', TRUE)
  ->set('include_in_admin', TRUE)      // merged mode
  ->set('insertion_type', 'prepend')   // prepend|append
  ->set('wrap_admin', FALSE)
  ->set('shortcuts_region', '')        // '' = no shortcuts
  ->save();
```

```bash
drush cset custom_admin_menu.settings enable 1 -y
drush cset custom_admin_menu.settings include_in_admin 1 -y
drush cset custom_admin_menu.settings insertion_type prepend -y
drush cr   # or just resave the form — saving flushes all caches automatically
```

Saving the settings form flushes all persistent caches (it invokes `cache_flush` and clears every
cache bin), so changes appear immediately without a manual rebuild.

## Per-item visibility (roles / languages)

Individual custom-menu items can be limited by role or interface language, but only through the menu
link plugin **`metadata`** (`need_roles`, `disallowed_roles`, `allowed_languages`) — there is no UI
checkbox for it on standard menu-link forms. See [../api/extend.md](../api/extend.md).
