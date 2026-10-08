<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add & configure the Add Content by Bundle area

There is **no admin settings page** (`configure: null`). You configure it entirely inside a
view, as an **area handler** in the header or footer.

## Add it via the Views UI

1. Edit a view (`/admin/structure/views/view/<id>`).
2. In the **Header** or **Footer** section click **Add**.
3. Check **Add Content by Bundle link** (category "add") and **Apply**.
4. Fill in the options (below) and **Apply**, then **Save**.

## Options / config keys

Stored at `display.display_options.<header|footer>.add_content_by_bundle`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `type` | string | base entity type of the view (else `node`) | Target entity type id (e.g. `node`, `taxonomy_term`). |
| `bundle` | string | `null` | Bundle machine name. In the form it is chosen per entity type; on submit it is flattened to a **plain string** (`submitOptionsForm`). |
| `label` | string | `Add a new entry` | The link text (required). |
| `class` | string | `button button--action button--primary` | Space-separated CSS classes; each is passed through `Html::getClass()`. |
| `target` | string | `''` | `''` = normal page, `tray` = off-canvas, `modal` = modal dialog. |
| `width` | int | `600` | Dialog width in px (only used when `target` is set). |
| `destination` | int (bool) | `0` | When truthy, the `destination` query param is removed (user is **not** returned to the view). |
| `params` | string | `''` | Extra query params, one `key|value` per line; supports Views argument tokens. |
| `login_redirect` | bool | `FALSE` | If the user lacks access and is anonymous, show a "Login to add your …" link to `user.login` instead of nothing. |
| `group` | int (bool) | `0` | (node only, needs Group module) link to create group content. |
| `form_mode` | array/string | `null` | (needs Form Mode Control) form mode to open; added to the URL as the `display` query param. |

The config schema is `views.area.add_content_by_bundle`
(`config/schema/add_content_by_bundle.views.schema.yml`).

## Read/edit via drush

```bash
# Inspect the footer area of a view:
drush config:get views.view.<id> display.default.display_options.footer.add_content_by_bundle
```

Example fragment inside `views.view.<id>`:

```yaml
display:
  default:
    display_options:
      footer:
        add_content_by_bundle:
          id: add_content_by_bundle
          table: views
          field: add_content_by_bundle
          plugin_id: add_content_by_bundle
          type: node
          bundle: article
          label: 'Add article'
          class: 'button button--action button--primary'
          target: modal
          width: 700
          empty: true          # standard views-area flag: show when no results
```

Set it programmatically:

```php
$view = \Drupal::entityTypeManager()->getStorage('view')->load('my_view');
$display =& $view->getDisplay('default');
$display['display_options']['footer']['add_content_by_bundle'] = [
  'id' => 'add_content_by_bundle', 'table' => 'views', 'field' => 'add_content_by_bundle',
  'plugin_id' => 'add_content_by_bundle', 'relationship' => 'none', 'group_type' => 'group',
  'type' => 'node', 'bundle' => 'article', 'label' => 'Add article',
  'class' => 'button button--action button--primary', 'target' => '', 'empty' => TRUE,
];
$view->save();
```

## Notes

- The link is only rendered if the current user passes the add-route access check for that
  bundle — see [../api/behavior.md](../api/behavior.md).
- `bundle` was stored as a multi-key array in an older release; `convertLegacyBundle()`
  normalizes both a plain string and that legacy array at runtime, but new saves store a
  plain string.
