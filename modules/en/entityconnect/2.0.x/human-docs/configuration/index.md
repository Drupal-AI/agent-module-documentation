# Configuration

Entity Connect is configured in two layers: a **global default** that sets whether
the add/edit buttons appear (and as text or icons), and a **per-field override**
on each Entity Reference field. A field's own setting wins over the global
default. There are also three permissions to grant.

## Permissions

Set these under **People → Permissions**:

- **Administer entityconnect** (`administer entityconnect`) — required to open the
  global settings form below.
- **Entityconnect add button** (`entityconnect add button`) — whether a role sees
  the add (+) button and can reach the add detour.
- **Entityconnect edit button** (`entityconnect edit button`) — whether a role
  sees the edit (pencil) button and can reach the edit detour.

**Important:** these button permissions are safe to grant to editors. They only
decide whether the *button and detour* are offered — the actual create and edit
happen on Drupal's standard core forms, which enforce their own permissions. A
user with the add-button permission but without, say, *create article content* is
simply denied by core exactly as if they'd navigated to the add form directly. The
detour also stashes the parent form in per-user private tempstore, so one user
can't resume another user's in-progress form.

## Global default settings

Go to **Configuration → Content authoring → Entity Connect**
(`/admin/config/content/entityconnect`). The form writes to the
`entityconnect.administration_config` configuration. It controls the default
visibility of the two buttons and whether each shows as text or an icon:

- **Add button** (`buttons.button_add`, default on) — show the add (+) button by
  default.
- **Edit button** (`buttons.button_edit`, default on) — show the edit (pencil)
  button by default.
- **Add icon** (`icons.icon_add`, default off) — show the add button as an icon
  (on) rather than a text button (off).
- **Edit icon** (`icons.icon_edit`, default off) — same choice for the edit
  button.

A common pattern is to turn the buttons on globally and hide them on the few
fields where they aren't wanted, or turn them off globally and enable them only on
chosen fields.

## Per-field overrides

Each Entity Reference field can override the global defaults on its own field-edit
form. Go to the field under **Manage fields** (for example on a content type),
open the reference field, and you'll find the same button/icon options there,
stored as third-party settings on the field. Whatever you set on the field takes
precedence over the global default for that field.

## Notes

- Only Entity Reference **field storage** fields are targeted — base fields aren't
  supported.
- The buttons work with all the default Entity Reference widgets (autocomplete,
  select, checkboxes/radios) and with multi-value fields (per value).
