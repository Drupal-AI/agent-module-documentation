# Configuration

Nice Menus has two layers: a **global settings form** for behaviour shared by every menu, and
**per-block configuration** for each menu you place.

## Global settings

Go to **Configuration → User interface → Nice Menus**
(`/admin/config/user-interface/nice_menus`), which requires the *manage nice menu settings*
permission. These values apply to all Nice Menus blocks:

| Setting | Default | What it does |
|---|---|---|
| **Load Superfish JavaScript** | On | Loads the Superfish + hoverIntent JS (needed for hover-intent behaviour and legacy IE). Turn off to run pure-CSS menus only. |
| **Load default CSS** | On | Loads the module's default menu styling. Turn off to style the menus entirely from your theme. |
| **Hover delay** | 800 (ms) | How long a submenu stays open after the mouse leaves (Superfish close delay). |
| **Animation speed** | slow | Open/close animation speed: `slow`, `normal`, or `fast`. |

You can also set these with Drush:

```bash
ddev drush config:set nice_menus.settings nice_menus_js true -y
ddev drush config:set nice_menus.settings nice_menus_sf_speed fast -y
```

## Per-block configuration

Place a **Nice Menus** block at **Structure → Block layout** (`/admin/structure/block`) — it is in
the *Menus* category — choosing the region where the navigation should appear. Each block instance
has these settings:

| Setting | Default | What it does |
|---|---|---|
| **Name** | — | An optional internal label for the block. |
| **Menu** | Navigation (root) | The source **menu parent**: pick a whole menu, or a specific parent link to show only that sub-tree. |
| **Depth** | -1 (all) | How many child levels to show below the chosen parent. `-1` = all levels, `0` = none, or a specific number. |
| **Style** | right | The expand direction: **down** (horizontal drop-down bar), **right** (vertical, flies out right), or **left** (vertical, flies out left). Adds a `nice-menu-<style>` class. |
| **Respect "Show as expanded"** | No | When Yes, only branches whose links have core's *Show as expanded* option checked will expand. |

Typical setups:

- **Horizontal drop-down header nav:** source = *Main navigation*, depth = `-1`, style = **down**,
  placed in a header/primary-menu region.
- **Sidebar fly-out:** source = a custom menu, style = **right** (or **left** for a right-hand
  region).

You can place several independent Nice Menus blocks from different source menus on the same page,
and even reuse one menu as both a drop-down header and a sidebar fly-out via two blocks.

## Theming

Every menu gets `nice-menu`, `nice-menu-<menu-name>`, and `nice-menu-<style>` CSS classes, and the
markup is themed through the `nice_menus` theme hook / `nice_menus.html.twig` template. To style
menus entirely yourself, turn off **Load default CSS** in the global settings and target those
classes from your theme. See [`agent/configure/settings.md`](../agent/configure/settings.md) for
the underlying config keys, cache metadata, and a Drush snippet for creating a block
programmatically.
