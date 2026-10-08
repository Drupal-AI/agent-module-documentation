# Configuration

The tweaks are **opt‑in per content type**. You enable them on the form display of
the DKAN content type whose metadata form you want to improve — typically the
*data* type.

## Turn the tweaks on

1. Go to **Structure → Content types → *(your DKAN data type)* → Manage form
   display**.
2. On that form‑display edit form you'll find this module's JSON Form options,
   stored as third‑party settings. Enable the ones you want:
   - **Navigation** — adds a jump‑to‑property panel so editors can move directly to
     any property in a long schema.
   - **Close details** — adds a button that collapses all the open detail elements
     of multi‑value properties at once, giving a cleaner overview.
   - **Remove multi‑value** — adds a per‑value remove checkbox so a single item can
     be deleted from a multi‑value property.
3. Save the form display.

Each toggle is independent — enable only the behaviours you want. Because the
settings are stored as third‑party settings on the form display, they are
exportable configuration and roll between environments with config sync.

## Theming (optional)

The added interface elements have their own theme hooks you can override in your
theme:

- **`dkan_json_form_navigation`** — the navigation panel.
- **`dkan_json_form_close_button`** — the close‑all button.

The module also adds template suggestions to the JSON‑form‑generated elements,
making them easier to target from your theme.

## Result

With the options enabled, open a dataset edit form for that content type: the
navigation panel and the close/remove controls appear on the schema‑generated
form, making large metadata schemas quicker to edit.
