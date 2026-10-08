# Configuration

All of Menu Manipulator's behavior is driven from one settings form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → User interface → Menu Manipulator**
   (`/admin/config/user-interface/menu-manipulator`).

## Language filtering

- **Filter menus by language** (`preprocess_menus_language`, on by default) — the
  master switch. When on, the menus you select below show only the links that
  belong to the current interface language.
- **Resolve language from the linked entity**
  (`preprocess_menus_language_use_entity`, on by default) — when on, a link's
  language is taken from the entity it points to; when off, it is taken from the
  link's own language / translation.
- **Menus to filter** (`preprocess_menus_language_list`) — tick each menu that
  should be language‑filtered. By default the **main** and **footer** menus are
  filtered and the account, admin, links, and tools menus are not. Turning a menu
  on here means its non‑matching links are dropped at render time, while access
  checks on each remaining link still run.

With filtering on, a single menu can serve every language: as a visitor switches
language, the menu automatically shows just that language's links, so you no
longer need a duplicate menu per language.

## Per‑link icons

- **Add icons to menu links** (`preprocess_menus_icon`, on by default) — the
  master switch for icons.
- **Menus with icons** (`preprocess_menus_icon_list`) — tick each menu whose links
  should render an icon.
- **Available icons** (`menu_link_icon_list`) — a list of icon names (one per line
  or comma‑separated) that becomes the set of choices offered on the menu‑link
  edit form.

## Assign language and icon to individual links

Once configured, edit any menu link (under **Structure → Menus**). The link edit
form now includes a **language** selector — set it to the language that link
belongs to — and, for icon‑enabled menus, a way to pick one of your available
icons. The chosen language is stored back on the link and used when the menu is
filtered.

## Save

Click **Save configuration**. Changes take effect on the next page render — the
settings are stored in the `menu_manipulator.settings` config object, which
exports and imports like any other config for deployment.
