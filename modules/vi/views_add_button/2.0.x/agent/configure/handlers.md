<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add & configure the button in a View

No settings page — it is per-view. In the Views UI, add **"Global: Entity Add Button"** to the
**Header** or **Footer** (area handler) or add the **"Entity Add Button"** **field**.

## Options (identical for area + field)

Config schema `views.area.views_add_button_area` / `views.field.views_add_button_field`:

| Option | Meaning |
|---|---|
| `type` | Target entity, stored as `"<entity_type>+<bundle>"` (e.g. `node+article`). The only non-tokenizable option. |
| `button_text` | Link text. |
| `button_classes` | Classes added to the `<a>` (e.g. `button` / `btn btn-primary`) so it renders as a button. |
| `query_string` | Query string appended to the URL (no leading `?`). |
| `context` | Extra route parameter value some entities need (e.g. a Group id). Usually empty. |
| `destination` | Bool — append a `destination` param so the user returns to the view after saving. |
| `tokenize` | Bool — enable replacement tokens taken from the **first result row**. |
| `render_plugin` | Override the `@ViewsAddButton` plugin used to build the URL/link (blank = auto by entity type). |
| `access_plugin` | Override the plugin used for the create-access check. |
| `button_attributes` | Extra HTML attributes on the `<a>`. |
| `button_prefix` / `button_suffix` | text_format HTML rendered before/after the button. |
| `button_access_denied` | text_format HTML shown instead of the button when the user lacks create access. |

Every option **except `type`** supports tokens; with `tokenize` on, tokens resolve from the first
row (handy with contextual filters). The button renders only if the current user has create access
to the chosen entity/bundle (else nothing, or the access-denied HTML).

## Where it is stored (view config)

Area in a display's header (footer is analogous):

```yaml
display:
  default:
    display_options:
      header:
        views_add_button:
          id: views_add_button
          table: views
          field: views_add_button
          plugin_id: views_add_button_area
          type: 'node+article'
          button_text: 'Add article'
          button_classes: 'button'
          destination: true
          tokenize: false
```

Field variant lives under `display_options.fields` with
`plugin_id: views_add_button_field`, `field: views_add_button_field`.

## Scriptable

Add the handler by editing the view's `display` array and saving the `view` config entity
(`\Drupal\views\Entity\View::load($id)`), or export/import the view config. Read back with
`drush config:get views.view.<id>`.
