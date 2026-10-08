# Configure Field Group Label

No module settings page — configure it as a field plus a field_group group.

## Setup

1. On the target bundle, create a **field_group** group (Manage form display / Manage display) as usual.
2. *Manage fields › Add field* → **Field Group Label** (`field_group_label_field_type`).
3. On *Manage display*, place that field **inside** the group whose label you want to override, and set
   its formatter to **Field Group Label** (`field_group_label_formatter`).
4. On *Manage form display*, use the **Field Group Label** widget so editors can type the per-entity label.

At render time the group's heading becomes the entered value (when non-empty); otherwise the group's
configured label is kept.

## Field type / storage

`field_group_label_field_type`: single-valued (`cardinality = 1`), required `value` stored as `varchar`
(or `varchar_ascii` when `is_ascii`), default `max_length` 255, `case_sensitive`/`is_ascii` storage
settings (as core string fields). A `Length` constraint enforces `max_length`. Storage-settings form
exposes **Maximum length**.

## Widget (`field_group_label_widget`)

Renders a `textfield` with `#maxlength` = the field's max_length. Settings:

| Setting | Default | Effect |
|---|---|---|
| `size` | `60` | Width of the textfield. |
| `placeholder` | `''` | Placeholder hint shown until a value is entered. |

## Formatter (`field_group_label_formatter`) + override mechanism

The formatter does **not** print the value in the field's own slot. `viewElements()` sets
`#access = FALSE`, escapes the first item (`nl2br(Html::escape($value))`), and exposes it as
`#field_group_label` (plus `#field_type`).

`field_group_label_field_group_pre_render(&$element, $group, $rendering_object)` then iterates
`$group->children`; for the first child whose `#field_type` is `field_group_label_field_type` it reads
`#field_group_label`, and if non-empty sets both `$element['#title']` and `$group->label` to it, then
`unset()`s that child (so the field row isn't shown) and breaks. Empty value → the group keeps its
original label. Only the first matching field per group takes effect.

Notes for agents:
- Put exactly one Field Group Label field inside a given group; additional ones are ignored.
- The label value is HTML-escaped before use, so it is rendered as plain text.
