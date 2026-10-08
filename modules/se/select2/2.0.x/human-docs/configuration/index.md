# Configuration

Select2 has **no global settings form**. You configure it per field, on the
entity's **Manage form display** page, by choosing a Select2 widget and adjusting
its settings. Everything is stored as field-widget configuration, so it exports
with `drush config:export` and deploys across environments.

## Choose a widget

Go to **Structure → Content types → *(your type)* → Manage form display** (or the
equivalent for another entity type), find the field, and set its **Widget** to one
of:

| Widget | Field types it applies to | What it is for |
|--------|---------------------------|----------------|
| **Select2** | List fields (`list_integer`, `list_float`, `list_string`) | A searchable replacement for a plain allowed-values select. |
| **Select2 (entity reference)** | Entity reference fields | Reference fields, with optional autocomplete and autocreate on top. |

Then click the **gear icon** to open the widget's settings.

## Select2 widget settings

- **Width** (default `100%`) — the container width of the widget. Accept any CSS
  value such as `500px` or `50%`, or one of the special keywords (`element`,
  `computedstyle`, `style`, `resolve`) that derive the width from the element.

## Select2 (entity reference) widget settings

The entity reference widget has the **Width** setting above, plus:

- **Autocomplete** (off by default) — lazy-load the options over AJAX as the editor
  types, instead of rendering every option up front. Turn this on for fields that
  reference large numbers of entities so the form stays fast.
- **Match operator** (default *Contains*) — how typed text is matched against
  options: **Starts with** or **Contains**. Contains is more forgiving but heavier
  on very large datasets. This only applies when autocomplete is on.
- **Match limit** (default `10`) — the maximum number of suggestions returned; set
  `0` for unlimited. Also only applies when autocomplete is on.

## Autocreate ("tags" — create new entities on the fly)

There is no separate widget checkbox for autocreate. Instead it follows the
**entity reference field's own** selection-handler setting **"Create referenced
entities if they don't already exist"** (configured on the field's settings, along
with a target bundle if the field can reference more than one). When that is
enabled, the Select2 widget automatically switches into tags mode: an editor can
type a label that does not exist yet and the entity is created on save, with a
comma acting as the separator between multiple tags.

## Custom forms

For a `#type => 'select2'` render element in a custom form, override any Select2
option (for example `allowClear` or `minimumInputLength`) through the element's
`#select2` property. The element applies sensible defaults — placeholder, clear
button, RTL/translated UI, and a max-selection count from the field's cardinality —
which you can override per property.

## Save

Click **Update** on the widget settings, then **Save** the form display. The field
now renders as a Select2 box with your chosen behavior.
