# Configuration

Entity Reports works as soon as it is enabled — the report pages appear under
**Reports** automatically. The settings form is entirely about **narrowing the
scope** of what gets reported, and the permissions decide who may view or
administer the reports.

## Open the settings form

1. Log in as a user with the **Administer entity reports** permission.
2. Go to **Configuration → Development → Entity reports**
   (`/admin/config/development/entity-reports`).

## Choose which entity types are reported

The settings form lets you limit reporting to a selected set of entity types.
Rather than generating a page for every fieldable entity type on the site, you can
tick only the ones you care about (for example just Node and Media). Any entity
type left unselected is excluded from the report pages and exports. This keeps the
report focused and, because the reports expose your content model, lets you avoid
surfacing structures you would rather not document.

Click **Save configuration** to apply your selection.

## Permissions

Entity Reports defines two permissions under **People → Permissions**:

- **View entity reports** — required to open every report page and export.
  Although its name sounds harmless, the reports enumerate every bundle, field,
  field type and field setting on the site, which is valuable reconnaissance
  material. This permission is **not** flagged as restricted, so grant it only to
  trusted roles and treat it as an information‑disclosure permission.
- **Administer entity reports** — required to open the settings form above and
  change which entity types are reported.

## Exports

Each report page offers export links. Out of the box the structure can be exported
as **JSON** and **XML**; enabling the **Entity Reports CSV** submodule adds a
**CSV** export as well. Exports respect the same **view entity reports**
permission, so the same access considerations apply to the downloadable files.
