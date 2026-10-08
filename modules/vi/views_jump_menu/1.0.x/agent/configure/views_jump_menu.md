# Configure — Jump Menu Views style

There is **no** admin settings page and no `configure` route. All configuration is per-view,
set on the display's **Format**. Config is stored in the view's config entity under
`display_options.style` and validated by schema `views.style.jump_menu`.

## Set it up (UI)

1. Edit or create a view (`/admin/structure/views/view/<id>`).
2. **Format → Format:** choose **Jump Menu**.
3. **Show:** must be **Fields** (the style requires fields; `usesFields = TRUE`, `usesRowPlugin = FALSE`).
4. Add at least the two fields you will use as the label text and the destination URL
   (e.g. a Title field and a Rendered-entity / entity link URL field). Fields that render
   HTML are decoded to plain text for the label.
5. Open the Jump Menu **format settings** and set the options below. At minimum set
   **Label field** and **URL field** — the menu renders no options until **Label field** is set.

## Style options (plugin `defineOptions()`)

| Option key | Type | Default | Purpose |
|---|---|---|---|
| `label_field` | select (view field id) | `''` | Field whose rendered text is each `<option>` label. Menu is empty until set. |
| `url_field` | select (view field id) | `''` | Field providing each option's destination URL. |
| `select_text` | textfield | `-- Select --` | Text of the pre-selected first `<option>` (also the select `title`). |
| `select_label` | textfield | `''` | ARIA `aria-label` on the `<select>` for screen readers. |
| `new_window` | checkbox | `FALSE` | Open the chosen URL in a new tab (`_blank`, `noopener`) instead of same window. |
| `class` | textfield | `''` | Extra class(es) on the `<select>` element. |
| `wrapper_class` | textfield | `''` | Class on the wrapping `<div>` around the select. |

The label/URL field dropdowns are populated from the display's field labels
(`getFieldOptions()` = `-- Select --` plus `displayHandler->getFieldLabels(TRUE)`).

## Config schema (`views.style.jump_menu`)

`class` (string), `wrapper_class` (string), `label_field` (string), `url_field` (string),
`new_window` (boolean), `select_text` (label), `select_label` (label).

## Export shape (inside the view)

```yaml
display:
  default:
    display_options:
      style:
        type: jump_menu
        options:
          class: ''
          wrapper_class: ''
          label_field: title
          url_field: view_node
          new_window: false
          select_text: '-- Select --'
          select_label: 'Jump to page'
```

## Update hook

`views_jump_menu_update_8101` — batched update that adds the `new_window: FALSE` key to any
existing `jump_menu` display that predates that option. Run via `drush updatedb`.
