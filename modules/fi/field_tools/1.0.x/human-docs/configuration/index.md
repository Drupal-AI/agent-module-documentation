# Configuration

Field Tools has no settings form — you use it, rather than configure it. This page
tours the actions it adds to each bundle's *Manage fields* area, the site-wide
reports, the one-click Clone link, and the permission that controls the reports.

## The per-bundle "Tools" tabs

On every fieldable bundle's *Manage fields* page (for a content type, that is
**Structure → Content types → *(your type)* → Manage fields**), Field Tools adds a
set of actions under a **Tools** area. These are available to users with the core
**administer *(entity type)* fields** permission. The paths below use a node type as
the example; the same tabs appear for taxonomy vocabularies, media types, and any
other entity that uses Field UI.

- **Clone fields** (`…/fields/tools/clone-fields`) — bulk-clone one or more fields
  from this bundle to one or more other bundles in a single submission. Ideal when
  building several similar content types.
- **Clone displays** (`…/fields/tools/clone-displays`) — copy an entire form display
  or view display to another bundle of the same entity type. Fields present on both
  are overwritten; fields only on the target are left untouched.
- **Copy display settings** (`…/fields/tools/copy-display-settings`) — copy just one
  field's widget or formatter settings from this bundle to another, rather than the
  whole display.
- **Export to code** (`…/fields/tools/export-to-code`) — export the bundle's
  configured fields as **base-field PHP code**, handy for moving them into a custom
  content entity or module.
- **Export to YAML** (`…/fields/tools/export-to-yaml`) — export the bundle's field
  configuration as **config YAML** for config-based deployment.

## The single-field "Clone" link

In a bundle's field list, Field Tools adds a **Clone** operation next to each field.
Use it to copy that one field to another bundle without opening a bulk form. When a
field is cloned this way (or via **Clone fields**), its form- and view-display
settings are also copied onto destination displays whose **view-mode names match**
the source — so, for example, a field arrives already configured for the *Teaser*
and *Full content* view modes if those exist on the destination.

## Deleting field storage

Field Tools also attaches a dedicated **delete** form to field storage, so you can
remove an orphaned `field_storage_config` cleanly from the field reports area.

## Site-wide reports

Under **Reports → Fields** (`/admin/reports/fields`), Field Tools adds:

- **Field list** (`/admin/reports/fields/tools`) — every field instance on the site.
- **Reference fields** (`/admin/reports/fields/references`) — all entity-reference
  fields and what they point at. Useful before refactoring your content model.
- **Field graph** (`/admin/reports/fields/graph`) — a visual reference graph of how
  entity types reference each other. This one only appears when the optional
  **GraphAPI** module is installed.

These reports are gated by the **Access field tools pages** permission.

## Multiple import

Field Tools also adds a **Multiple import** configuration form at
`/admin/config/development/configuration/multiple/import` (gated by the core *import
configuration* permission), for importing several configuration items at once.

## Doing it from code

Every UI action above is backed by a service you can call directly from custom code
or `drush php:eval` — `field_tools.field_cloner`, `field_tools.display_cloner`,
`field_tools.display_settings_copier`, and `field_tools.references.info`. That is
usually faster than driving the forms for scripted or repeatable work. See the
[`agent/`](../agent/start.md) docs for the method signatures.

## Permission

Grant at **People → Permissions**:

- **Access field tools pages** (`access field tools pages`) — controls access to the
  three reports under `/admin/reports/fields`.

The per-bundle clone, copy, and export actions are **not** gated by this permission;
they require the relevant core **administer *(entity type)* fields** permission
(e.g. *Administer content fields* for nodes), which site administrators already hold.
