# Configuration

"Configuring" Content Entity Builder means **building an entity type**. The whole
module is a workflow you run from **Structure → Content types**
(`/admin/structure/content-types`). The steps below walk through it end to end.

> **Before you start:** this tool creates entity types and can generate code, both
> of which have access implications. Use it as a trusted developer, know what each
> setting does before saving, and review the result afterwards.

## 1. Add a content entity type

Go to **Structure → Content types** (`/admin/structure/content-types`) and add a
new content entity type — for example `author`. Choose a **Mode**:

- **Basic** — one entity, one table. The cleanest option.
- **Basic Plus** — Basic plus bundle support.
- **Advanced** — bundles, translatable, owner, changed timestamp, and published
  status.
- **Full** — a node‑like type: Advanced plus revisions.

Pick the least complex mode that meets your needs.

## 2. Add base fields

Open the type at `/admin/structure/content-types/manage/{type}` (for example
`.../manage/author`) and add its base fields — for instance **Name**, **Age**,
**Description**.

## 3. Configure the entity type settings

Still on the manage screen, configure the entity type settings, including its
**entity keys** and **entity paths**. Make sure you understand each value before
changing it — these define how the entity is identified and where it lives.

## 4. Save to sync with the database

Click **Save**. This is the step that syncs your configuration to the actual
database table for the entity type.

## 5. Manage bundles (non‑Basic modes only)

If you chose any mode other than Basic, a **Bundles** tab appears. Use it to add
and manage the bundles of your entity type.

## 6. Manage form and view display

Configure how the entity is edited and displayed:

- **Form display:** `/admin/structure/content-types/manage/{type}/form-display`
- **Display:** `/admin/structure/content-types/manage/{type}/display`

## 7. Add content

Add entities at the add path (for example `/author/add`) — this path is one of the
things you configure in step 3.

## 8. Set permissions

Configure the entity type's permissions at **People → Permissions**
(`/admin/people/permissions`), and review the generated **access handler** so the
new entity is protected the way you intend.

## 9. Export to module code (optional)

Open the **Export** tab to reach `/admin/structure/content-types/export`. From
there you can export your custom entity types to module code and download them —
a big time‑saver if you want a hand‑maintainable custom content‑entity module.

## Save and clear cache

After significant changes, clear the cache (`drush cr`). The maintainers
specifically recommend this whenever the module behaves unexpectedly.
