# Configuration

Default Value does nothing until you tell it which fields should receive a
fallback. That is all done on its settings page.

## Open the settings

1. Log in as a user with the appropriate administration permission (an
   administrator by default — the module provides its own permission for this).
2. Go to **Configuration → System → Default Value Settings** (config route
   `default_value.config`).

## Choose the supported entities and fields

On the settings page you select the entities whose fields should be given a
default value, and set the default that each configured field should present when
it is otherwise empty. Configure the default **per field** — decide, field by
field, what value an existing entity should show when that field has no stored
value.

## How the default behaves

Keep these two points in mind as you configure:

- **It is applied on load, not saved.** The configured value is presented when
  the entity is loaded; it is not written to the database unless the entity is
  subsequently saved. Think of it as a runtime fallback for display and use, not
  a bulk data update.
- **It does not affect access.** Default Value changes the loaded value only — it
  has no bearing on permissions or who can see or edit the entity.

## Save

Click **Save configuration**. The defaults apply to matching fields the next time
those entities are loaded.
