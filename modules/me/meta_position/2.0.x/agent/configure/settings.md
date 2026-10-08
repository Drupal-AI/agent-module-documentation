# Configure Meta Position

## Config object — `meta_position.settings`

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled` | int 0/1 | 0 | Master switch — repositions the node form advanced panel when 1 |
| `node_types` | sequence of strings | `{}` | Bundle machine names to apply to; **empty = all content types** |

Install defaults (`config/install/meta_position.settings.yml`): `enabled: 0`, `node_types: {}`.

Set with Drush:
```
ddev drush cset meta_position.settings enabled 1 -y
ddev drush cset meta_position.settings node_types.0 article -y
```

## Settings form

- Form `Drupal\meta_position\Form\MetaPositionConfig` (ConfigFormBase).
- Route `meta_position.settings`, path `/admin/config/content/meta`.
- **Permission requirement: `administer site`** (as written in `meta_position.routing.yml`). This is not a
  permission Drupal core defines, so no standard role holds it; only user 1 passes the access check unless a
  custom module/role defines `administer site`.
- Fields: `enabled` (checkbox) and `node_types` (checkboxes of all node types, visible only when `enabled` is
  checked). On submit, `node_types` is stored as the filtered (checked-only) list.

## What it does to the node form

`meta_position.module`:
- `meta_position_form_node_form_alter()` adds a `#process` callback.
- `meta_position_form_node_form_process()`: if `enabled` and the node's bundle is in `node_types` (or
  `node_types` is empty), it sets `$form['advanced']['#type'] = 'vertical_tabs'`, turns `$form['meta']` into a
  `details` element titled "Information", and attaches library `meta_position/node_meta` (CSS only — see
  `css/node_meta.css`). No JavaScript, no render of untrusted data.
