# Configuration

Bulk Edit Terms works as soon as it is enabled — the action appears on the Content
overview with no setup. The only thing to configure is the widget used for
multi-value term fields, plus the permissions that decide who can do what.

## Open the settings form

1. Log in as a user with the **Administer bulk edit terms** permission.
2. Go to **Configuration → Content authoring → Bulk Edit Terms**, or navigate
   directly to `/admin/config/content/bulk_edit_terms`.

## The setting: multi-value widget type

The form has a single option:

- **Multi-value widget type** (`multi_value_widget_type`, default
  **`entity_autocomplete`**) — the form widget used to collect values for
  multi-value taxonomy-term fields on the confirmation screen. The default is an
  entity autocomplete field, where editors type and pick terms. Change it if you
  prefer a different widget for entering term values in bulk.

Click **Save configuration** to store it. The setting lives in the
`bulk_edit_terms.settings` config object:

```yaml
# config: bulk_edit_terms.settings
multi_value_widget_type: 'entity_autocomplete'
```

## Permissions

Two permissions govern the module, and they are deliberately separate:

- **Administer nodes** (core, marked as a restricted permission) — gates the action
  itself and the confirmation form. Only users with this permission see and can run
  *"Update term references for the selected content"*. This is a powerful
  permission, so grant it only to trusted editorial roles.
- **Administer bulk edit terms** (this module) — gates *only* the widget-type
  settings form above. You can give this to a config-only role that manages the
  widget setting without granting them the ability to run bulk edits.

## Access is always enforced per node and per field

Beyond those permissions, the module checks access for every change it makes. On
the confirmation form and again when applying, it verifies that the current user
has **update** access to each node and **edit** access to each term field. A field
is skipped for any node where the user lacks that access. In other words, an editor
can only bulk-change term fields on nodes and fields they were already allowed to
edit — the bulk action never bypasses normal access control.
