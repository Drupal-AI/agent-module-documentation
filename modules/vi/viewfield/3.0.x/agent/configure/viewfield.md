# Configure a Viewfield

Viewfield has **no module settings form** (no `configure` route). All configuration is per
field, on the bundle's **Manage fields** and **Manage display** screens.

## 1. Add the field

Structure → the bundle (e.g. Content type) → **Manage fields → Add field** → choose
**Viewfield** (field type `viewfield`, group "Field types"). Choose cardinality (number of
values = number of distinct view displays this entity may store). Storage `target_type` is
fixed to `view` and hidden — you cannot reference another entity type.

## 2. Field settings (per-field)

Config: `field.field_settings.viewfield` (schema `config/schema/viewfield.schema.yml`).

| Setting | Default | Meaning |
|---|---|---|
| `force_default` | `0` (false) | "Always use default value". Hides the field in entity edit forms and always renders the configured **default value** for every entity in the bundle. If checked, a default value is **required** (validated). |
| `allowed_views` | `[]` | Checkboxes limiting which views authors may pick. Empty = allow all enabled views. |
| `allowed_display_types` | `['block' => 'block']` | Checkboxes limiting which display **types** (block, page, …) authors may pick. Empty = allow all. |

The underlying entity-reference `handler` / `handler_settings` are present but hidden (not
useful for this field).

## 3. Set the value (widget `viewfield_select`)

Default and only widget. Per delta the author:

1. Selects a **View** (`target_id`). Choosing one Ajax-loads that view's **Display** options.
2. Selects a **Display** (`display_id`).
3. Under **Advanced options** (a collapsed details element):
   - **Arguments** — contextual filters. Separate filters with `/`; within one filter use `+`
     or `,` for multi-value. Supports **tokens** (a token tree link is shown, scoped to the
     host entity type; `taxonomy_term` maps to the `term` token type). Max 255 chars.
   - **Items to display** — override the display's item count; this also disables the pager.
     Leave empty for the display's own limit.

When `force_default` is on, the widget is hidden on entity forms and only shown on the
field's default-value form.

## 4. Manage display (formatters)

Pick one of three formatters on **Manage display**:

| Formatter id | Label | Settings |
|---|---|---|
| `viewfield_default` | Viewfield | `view_title` (Above / Inline / Hidden / Visually Hidden), `always_build_output` (render even with no results — e.g. to force an attachment display), `empty_view_title` (title display when empty; only applies when `always_build_output` is on). Themed via `viewfield` + `viewfield_item` templates. |
| `viewfield_rendered` | Rendered entities | Renders the view's **result rows as entities** in a chosen `view_mode` (superset of all entity-type view modes; default `default`). **Single-cardinality fields only** (`isApplicable`). Note: entity access is only what the View enforces. The host entity is skipped if it appears in the results. |
| `viewfield_title` | Title and display name | Debug output: prints the view title, display name, and arguments as an item list; shows "Missing or broken view/display" if the display is gone. |

Config: `field.formatter.settings.viewfield_default`, `field.formatter.settings.viewfield_rendered`.

## Rendering notes

- Formatters read stored item values, unless `force_default` is set, in which case they use
  the field's configured **default value** instead.
- Arguments are token-replaced against the host entity, then passed to the view; an item only
  renders when both `target_id` and `display_id` are set and the view/display access passes.
- Arguments are merged into the view's cache keys, so the same view with different arguments
  can appear multiple times on one page without cache collisions.
