# Configuration

Media Title Length has a single setting — the maximum length of the media name
(title) field. Saving the form applies the value both to the field definition and,
immediately, to the database column, so the change takes effect at once.

## Open the settings form

1. Log in as a user with the **modify title length** permission (this module's own
   permission — grant it only to trusted administrators at **People → Permissions**,
   `/admin/people/permissions`).
2. Go to **Configuration → Media → Media Title Length settings**, or navigate
   directly to `/admin/mtl/config`.

## Media title length

- **Media title length** — enter the maximum number of characters allowed in a media
  entity's name. The value must be a whole number between **1 and 65535** (the form
  validates that it is numeric and within that range). Core's default is **255**.

When you save, the module updates the media `name` base field's `max_length` and runs
a live schema change on the `media_field_data` and `media_field_revision` tables (and
the Admin Audit Trail reference column, if that module is installed) so the `varchar`
column matches the new limit.

## Important: increasing vs. decreasing

- **Increasing** the length is safe — widening the column never affects existing
  data.
- **Decreasing** the length below the length of names you already store risks
  **truncating** that existing data when the column is narrowed. Before reducing the
  limit, make sure no current media names exceed the new value (and take a database
  backup first).

## Save

Click **Save configuration**. The new length applies immediately — new and existing
media can now use names up to the limit you set. To change it again later, simply
re-open this form and save a new value.
