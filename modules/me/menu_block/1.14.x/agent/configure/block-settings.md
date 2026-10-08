# Configure a menu block

Place a block from the **Menus** category at `/admin/structure/block` (or in Layout Builder).
Each menu gets its own derivative (`menu_block:<menu_name>`). Settings are stored in the block
config under `settings:` and validated by `config/schema/menu_block.schema.yml`.

## Settings keys (block `settings`)
| Key | Type | Meaning |
|---|---|---|
| `level` | int | Initial/starting visibility level (1 = always visible). |
| `depth` | int | Max number of levels to show from `level`; `0` = unlimited. |
| `expand_all_items` | bool | Show every child link regardless of active trail. |
| `follow` | bool | Make initial level follow the active menu item. |
| `follow_parent` | string | When following: `active` (the item) or `child` (its children). |
| `parent` | string | Fixed parent menu link id (`<menu>:<uuid>`); tree is rooted here. |
| `render_parent` | bool | Also render the parent item at the top of a children-only tree. |
| `hide_on_nonactive` | bool | Hide the block on pages not present in the menu. |
| `display_empty` | bool | Render the block even when the tree has no links. |
| `label_type` | string | Dynamic title source: `block`, `menu`, `active_item`, `parent`, `root`, `visibility_level_parent`, `fixed`. |
| `label_link` | bool | Turn the dynamic title into a link (for the item-based label types). |
| `suggestion` | string | Machine name → adds `menu__<suggestion>` theme suggestion. |

## Notes
- Defaults live in `MenuBlock::defaultConfiguration()` (`level`=1, `depth`=0, `label_type`=`block`, etc.).
- The legacy `expand` key is migrated to `expand_all_items` on save.
- `blockAccess()` returns forbidden when the tree is empty and `display_empty` is off.
- Example exported block config:
```yaml
settings:
  id: 'menu_block:main'
  label: 'Section navigation'
  level: 2
  depth: 2
  follow: true
  follow_parent: child
  parent: 'main:'
  render_parent: false
  hide_on_nonactive: true
  display_empty: false
  label_type: active_item
  label_link: false
  suggestion: main
```
