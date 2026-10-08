<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Read More Extra Field settings

No dedicated admin page and no `configure` route. The "Read more" field is enabled and
configured **per view mode** in Manage Display:
`admin/structure/types/manage/{bundle}/display[/{view_mode}]`. It shows up in the
**Extra fields** section (provided by `extra_field`/`extra_field_plus`) for any node bundle.
Enable it, drag it to a position, then use the field's settings gear.

## Settings (config keys)

Stored under the view display config, schema
`field.formatter.settings.extra_field_readmore_extrafield`. All are strings.

| Key | Form label | Effect | Default |
|---|---|---|---|
| `link_title` | Label | Anchor text of the link. | `Read more` |
| `link_classes` | Link classes | Extra CSS classes, space-separated, appended to `readmore-extrafield-link`. | `''` |
| `link_attr_title` | Link „title" attribute | Value of the anchor's `title` attribute. | `''` |
| `link_attr_rel` | Link „rel" attribute | Value of the anchor's `rel` attribute. | `''` |
| `link_attr_target` | Link „target" attribute | Value of the anchor's `target` attribute (e.g. `_blank`). | `''` |

Empty `link_title` falls back to the translated "Read more". The link always renders with
the base class `readmore-extrafield-link` and points at the node's canonical URL
(`entity.node.canonical`).

## Token support (optional)

If the contrib `token` module is enabled, `link_title`, `link_classes` and `link_attr_title`
are passed through `\Drupal::service('token')->replace(...)` against the host entity
(`clear => TRUE`), and a token browser link appears on the settings form. Without `token`
these values are used literally. `rel` and `target` are **not** token-processed.

## Export

Settings are part of the entity view display config entity — export/import with
`drush config:export` / `drush config:import`; they can differ per view mode and per bundle.
