<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exclude fields from bulk update

The module's `configure` route is the **exclude** form, not the update form.

- Route: `bulk_update_fields.bulk_update_exclude_form` → `/admin/bulk_update_fields/exclude`
  (`BulkUpdateExcludeForm`, a `ConfigFormBase`).
- Config object: `bulk_update_fields.settings`, key **`exclude`** — a sequence (list) of field
  **machine names**. Any field listed here is removed from the field-picker on the bulk-update form,
  so it can't be mass-overwritten.

## Config shape

```yaml
# bulk_update_fields.settings
exclude:
  - body
  - field_secret_ref
```

Schema (`config/schema/bulk_update_fields.schema.yml`): `exclude` is a `sequence` of `string`.

## Read / set via drush

```bash
drush cget bulk_update_fields.settings exclude
```

```php
// Set the exclude list programmatically.
\Drupal::configFactory()->getEditable('bulk_update_fields.settings')
  ->set('exclude', ['body', 'field_secret_ref'])
  ->save();
```

## Via the UI

Go to *Configuration → User interface → Bulk update exclude fields*
(`/admin/bulk_update_fields/exclude`). The form lists node fields (base fields such as `title`,
`status`, `uid`, `created`, `changed`, `body`'s siblings, etc. are pre-filtered out of the list of
selectable options). Tick the fields to exclude and save. Values persist to
`bulk_update_fields.settings:exclude`.

Note: the option list on this form is built from **node** fields only, but the stored list is applied
to the bulk-update field picker generally.
