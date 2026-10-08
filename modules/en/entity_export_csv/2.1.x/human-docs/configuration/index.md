# Configuration

There are two stages: whitelist what may be exported, then run (and optionally
save) an export.

## 1. Whitelist exportable entity types

1. Log in as a user with the **Administer entity export csv** permission.
2. Go to **Configuration → Content authoring → Entity Export CSV → Settings**
   (`/admin/config/content/entity-export-csv/settings`).
3. For each content entity type you want to allow (Content/node, Users, Taxonomy
   terms, Media, …), tick **Enable**. Optionally restrict it to specific **bundles**
   — leaving the bundle list empty means all bundles of that type are allowed.
4. The **multiple** option sets the default number of columns offered when a
   multi-value field is split across columns.
5. Save. Only content entity types are offered here. If the private filesystem is
   not configured, the form warns that exports will fall back to the temporary
   filesystem.

## 2. Run an export

1. As a user with the **Use entity export csv** permission, go to **Content →
   Entity Export CSV** (`/admin/content/entity-export-csv`).
2. Choose an enabled entity type and bundle.
3. Field by field, decide whether to **include** the field and how to render it.
   Each field offers options appropriate to its type, including:
   - **Header** — what label to use for the column header.
   - **Property** — which of the field's properties to export (for example a link
     field's URI, its title, or both).
   - **Property separator** and **separate column** — whether multiple
     properties/values go into one delimiter-separated column or one column per
     property/value.
   - **Format** — for example the date format on datetime, date range, and
     timestamp fields, or key-vs-label on list fields.
4. Run the export. Large exports process through the Batch API so they do not time
   out, and the finished CSV is streamed to you for download.

## 3. Save reusable export configurations (optional)

To repeat an export, save it as a configuration entity. Manage these at
**Configuration → Content authoring → Entity Export CSV → Configurations**
(`/admin/config/content/entity-export-csv/configurations`). Each configuration
stores the target entity type and bundle, a **delimiter** (for example comma versus
semicolon), and the full per-field map. The collection supports add, edit, delete,
**enable**, **disable**, and **duplicate** operations — so you can quickly create a
variant, or turn a configuration off without deleting it. Because they are
configuration entities, they export and import with Drupal's configuration
management and deploy across environments.

## Field types and extensibility

Each field is rendered by a *field-type export plugin*. The module ships plugins
for plain fields plus address, entity reference, file, link, datetime, date range,
timestamp, list, and geolocation fields, so most common fields export sensibly out
of the box. If you have a custom or contrib field type that needs special handling,
a developer can add a `@FieldTypeExport` plugin — see the sibling
[`agent/`](../agent/start.md) docs for the plugin details.

## Permissions

Under **People → Permissions**:

- **Administer entity export csv** — reach the settings page and manage saved
  export configurations. Trusted roles only.
- **Use entity export csv** — run the export form and download CSVs. Grant to the
  editors who need self-service exports.
