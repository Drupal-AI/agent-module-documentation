# Configuration

Organization Field has a small settings form that controls how its autocomplete
talks to the ROR registry. The defaults work out of the box against the public
ROR API, so you only need this page if you want to point at a different endpoint
or change how many suggestions appear.

## Open the settings form

1. Log in as a user with the **Administer organization_field configuration**
   permission (an administrator by default).
2. Go to **Configuration → Content authoring → Organization Field**, or navigate
   directly to `/admin/config/content/organization_field`.

## Settings, field by field

- **ROR API URL** (`ror_api`) — the base URL of the ROR REST API that the
  autocomplete widget queries. Leave it at the public ROR endpoint unless you run
  or subscribe to a different ROR‑compatible service.
- **Number of autocomplete results** (`ror_items_depth`) — the cap on how many
  matching organizations the widget lists as you type. A smaller number keeps the
  suggestion list tidy and fast; a larger number surfaces more matches for
  ambiguous names.

Click **Save configuration** to apply your changes.

## The field itself

Beyond this form, most of the "configuration" for Organization Field happens on
the field's own display. The field type stores the organization name, one or more
URLs (the first is treated as the default), and a ROR ID URL. On the entity's
**Manage display**, choose the **default** formatter for a plain rendering or the
**configurable** formatter to customize labels and link behavior.

## Uninstalling cleanly

When you want to remove the module, first delete every Organization field using
the dedicated field‑deletion form at
`/admin/modules/uninstall/entity/organization_field` (requires the **Administer
organization_field** permission). The module's uninstall validator will block
removal until those fields are gone, which protects you from leaving orphaned
field data behind.
