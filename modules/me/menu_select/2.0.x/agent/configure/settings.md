<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Menu Select

## What there is to configure

A single boolean toggles the autocomplete search box; the tree widget itself is always on
(there is nothing to enable it — it replaces the core parent selector automatically once the
module is installed).

| Config object | Key | Type | Default |
|---|---|---|---|
| `menu_select.settings` | `search_enabled` | boolean | `true` |

- **Config UI**: `/admin/config/content/menu_select` (route
  `menu_select.menu_select_config_form`, form `MenuSelectConfigForm`). The checkbox label is
  "Enable searching for a menu link". Access requires `administer site configuration`.
- Menu link to that form appears under *Configuration → Content authoring* (defined in
  `menu_select.links.menu.yml`).
- `info.yml` does **not** declare a `configure:` route, so tooling that reads the `configure`
  key sees `null` even though the form above exists.

## Set it with drush

```bash
# Turn the search box off site-wide
drush config:set menu_select.settings search_enabled 0 -y
# Turn it back on
drush config:set menu_select.settings search_enabled 1 -y
# Read the current value
drush config:get menu_select.settings search_enabled
```

## Permission

The search feature is additionally gated by a permission (see
`menu_select.permissions.yml`):

| Permission | Machine name | Notes |
|---|---|---|
| Use menu select search | `use menu select search` | `restrict access: true`; granting it also lets the user *view links across all menus* via the autocomplete. |

The search textfield only renders when **both** `search_enabled` is TRUE **and** the current
user has `use menu select search`. Grant it with:

```bash
drush role:perm:add editor 'use menu select search'
```

The tree widget (without search) needs no special permission beyond the normal ability to
edit the menu link / node.
