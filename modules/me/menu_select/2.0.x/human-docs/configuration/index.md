# Configuration

Menu Select is almost configuration‑free. The improved tree‑based parent picker is
**always on** once the module is installed — it automatically replaces the core "Parent
item" drop‑down, and there is no switch to enable it. The only choice you make is whether
to also offer the **autocomplete search box**, and who may use it.

## The search toggle

1. Go to **Configuration → Content authoring → Menu Select**
   (`/admin/config/content/menu_select`). You need the **Administer site configuration**
   permission.
2. Tick or untick **Enable searching for a menu link** (config key
   `search_enabled`, on by default).

When on, editors who also hold the search permission (below) get an autocomplete text
box above the tree, letting them type a link's title and jump straight to it. When off,
they get the tree only — a simpler UI.

You can also set it from the command line:

```bash
# Turn the search box off site-wide
drush config:set menu_select.settings search_enabled 0 -y
# Turn it back on
drush config:set menu_select.settings search_enabled 1 -y
# Read the current value
drush config:get menu_select.settings search_enabled
```

> **Note:** The module's `.info.yml` does not declare a `configure:` route, so tools that
> read that key (and this project's `data.json`) show the configure link as empty. The
> settings form above nonetheless exists at `/admin/config/content/menu_select`, and a
> menu link to it appears under Configuration → Content authoring.

## The search permission

The search box only appears when **both** `search_enabled` is on **and** the current user
holds the search permission:

| Permission | Machine name | Notes |
|------------|--------------|-------|
| Use menu select search | `use menu select search` | Marked *restrict access* — grant it only to trusted editors. Granting it also lets the user view links across all menus via the autocomplete. |

Grant it to a role, for example:

```bash
drush role:perm:add editor 'use menu select search'
```

The tree picker on its own needs no special permission beyond the normal ability to edit
the menu link or node.
