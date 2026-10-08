# Configure — global settings & per-component attributes

## Global settings — `layout_builder_component_attributes.settings`

Form at `/admin/config/content/layout-builder-component-attributes`
(route `layout_builder_component_attributes.settings`,
requires `administer layout builder component attributes`). It controls **which attribute types
are allowed** in each of three groups. Config object keys (all default to `true`):

| Config key (group) | Element it targets | Sub-keys |
|---|---|---|
| `allowed_block_attributes` | block wrapper (outer) | `id`, `class`, `style`, `data` |
| `allowed_block_title_attributes` | block title | `id`, `class`, `style`, `data` |
| `allowed_block_content_attributes` | block content (inner) | `id`, `class`, `style`, `data` |

Each sub-key is a boolean. Set with drush, e.g. disallow inline styles on wrappers:

```
drush cset layout_builder_component_attributes.settings allowed_block_attributes.style false
```

Schema: `config/schema/layout_builder_component_attributes.schema.yml` (`type: config_object`);
defaults ship in `config/install/…settings.yml`, so settings export/deploy with
`drush config:export`. If an attribute is allowed then later disallowed, previously-entered
values for it stop rendering. If **all** sub-keys in a group are false, that group is hidden
from the per-component form.

## Per-component attributes form

Route `layout_builder_component_attributes.manage_attributes`
(`/layout_builder/update/block-attributes/{section_storage_type}/{section_storage}/{delta}/{uuid}`,
requires `manage layout builder component attributes` + Layout Builder `view` access). Reached
from the **Manage attributes** contextual link on a component (an off-canvas dialog, inserted
just after the **Configure** link).

The form shows a `details` group per non-empty category (Block / Block title / Block content
attributes), each with the allowed fields:

- **ID** — textfield; must be a valid CSS identifier.
- **Class(es)** — textfield (maxlength 512); space-separated; each must be a valid CSS class.
- **Style** — textfield (maxlength 512); inline CSS.
- **Data-\* attributes** — textarea; one per line, `name|value` (value optional), each name must
  begin with `data-` (e.g. `data-test|example-value` or `data-flag`).

On submit, values are stored on the component's `component_attributes` setting via
`$section->getComponent($uuid)->set('component_attributes', …)` (stored in the layout's
component `additional` data, then saved to the layout tempstore). There is no separate config
entity per block — the values live in the entity/section layout.
