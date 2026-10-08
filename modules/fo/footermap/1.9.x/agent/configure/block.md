# Configure the Footermap block

There is no admin settings page. Place the **Footermap** block (`footermap_block`, category
*Sitemap*) via *Structure → Block layout* (or in code), then configure its settings.

## Settings (block config → `settings` mapping, schema `block.settings.footermap_block`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `footermap_avail_menus` | sequence (checkboxes) | `[]` | Which menus to include. Value is a menu machine name → itself for selected menus. **A menu only renders if selected here.** |
| `footermap_recurse_limit` | integer | `0` | Max depth of menu items to show. `0` = unlimited. Sets `MenuTreeParameters::setMaxDepth()`. |
| `footermap_display_heading` | boolean/radios | `1` | Show each menu's label as a column heading (`title_display` visible vs hidden). |
| `footermap_top_menu` | string | `''` | Optional **menu-link plugin id** to use as the tree root (renders a sub-branch instead of whole menus). When set, `getMenus()` resolves that link's menu and the tree root is set to this plugin id. |

Plus the standard core block settings (`label`, `label_display`, region, visibility, weight).

## Example (exported block config)

```yaml
# block.block.footermap.yml (excerpt)
plugin: footermap_block
settings:
  id: footermap_block
  label: 'Site map'
  label_display: '0'
  footermap_recurse_limit: 2
  footermap_display_heading: 1
  footermap_top_menu: ''
  footermap_avail_menus:
    main: main
    footer: footer
```

## Behavior notes

- Only enabled links are shown (`onlyEnabledLinks()`); the root is excluded (`excludeRoot()`).
- Menu items are ordered by weight (via the template preprocess `uasort`).
- Access is evaluated as the **anonymous** user (see `start.md`), so restricted links never
  appear regardless of who views the page. If a menu shows nothing, its links are not anonymous-
  accessible.
- Multiple Footermap blocks can be placed with different menu selections/depths.
- Per the module's help text, avoid an unlimited-depth full sitemap in the footer without
  caching on large sites (the block itself caches per `languages`).
