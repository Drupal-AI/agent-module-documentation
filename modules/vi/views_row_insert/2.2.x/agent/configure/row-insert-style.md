# Configure the Row Insert style

Plugin id `row_insert`, title "Row Insert". Select it on a view display under
*Format → (style)*. `usesRowPlugin = TRUE`, `usesGrouping = FALSE`. No admin settings page.

## Where it is stored

In the view config entity `views.view.<viewid>`:

```yaml
display:
  default:
    display_options:
      style:
        type: row_insert
        options:
          use_plugin: true
          data_mode: vri_text        # vri_text = custom HTML, vri_block = a block
          block_name: false          # block plugin id / "block_content:<uuid>" when data_mode=vri_block
          custom_row_data: '<strong>Your HTML is here</strong>'
          rows_number: 2             # insert after every Nth row
          row_header: false          # also insert one row before all results
          row_footer: false          # also insert one row after the last result
          row_limit_flag: false      # cap number of inserted rows
          row_limit: '0'             # the cap (0 = unlimited)
          class_name: false          # CSS class(es) wrapping each inserted row
          row_class: false           # CSS class added to each ORIGINAL row
          default_rows: false        # re-add views-row / views-row-N classes
          strip_rows: false          # add odd/even + first/last classes
```

## Option reference (from `ViewsRowInsert::defineOptions()` / `buildOptionsForm()`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `use_plugin` | bool | TRUE | Master on/off; when FALSE the view renders normally with no inserted rows. |
| `data_mode` | radios | `vri_text` | `vri_block` = insert a block; `vri_text` = insert `custom_row_data`. |
| `block_name` | select | FALSE | Block to insert (any block plugin id; `block_content:<uuid>` for a custom block). Used only when `data_mode = vri_block`. |
| `custom_row_data` | textarea | `<strong>Your HTML is here</strong>` | Raw HTML row content. **Unrestricted** — rendered with Twig `raw`. |
| `rows_number` | number ≥1 | 2 | Insert an extra row after every this-many original rows. |
| `row_header` | bool | FALSE | Prepend one inserted row at the top. |
| `row_footer` | bool | FALSE | Append one inserted row at the bottom (only if trailing rows remain). |
| `row_limit_flag` | bool | FALSE | Enable a per-page cap on inserted rows. |
| `row_limit` | number ≥0 | `0` | The cap when `row_limit_flag` is on (0 = no limit). |
| `class_name` | textfield | FALSE | Class(es) applied to inserted rows (sanitized to `[a-zA-Z0-9-_ ]`). |
| `row_class` | textfield | FALSE | Class applied to each original (non-inserted) row. |
| `default_rows` | bool | FALSE | Re-add `views-row` and `views-row-<n>` classes. |
| `strip_rows` | bool | FALSE | Add `views-row-odd/even` plus `views-row-first`/`-last`. |

## Set it with drush (example)

```bash
drush php:eval '
  $v = \Drupal\views\Entity\View::load("my_view");
  $d = $v->getDisplay("default");
  $d["display_options"]["style"] = ["type" => "row_insert", "options" => [
    "use_plugin" => TRUE, "data_mode" => "vri_text",
    "custom_row_data" => "<div class=\"ad\">AD</div>", "rows_number" => 3,
  ]];
  $v->set("display", ["default" => $d] + $v->get("display"));
  $v->save();
'
```

Block mode: a `block_content` custom block is loaded by UUID and rendered via its view builder;
other block plugins are instantiated and access-checked before rendering (forbidden → empty).
