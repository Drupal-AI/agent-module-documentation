# Configuration

The module has one small settings form: a list of the entity types on your site,
each with a checkbox. You decide which of them should have their deletions logged.

## Choose which entity types to log

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Content authoring → Entity Delete Log**, or navigate
   directly to `/admin/config/content/entity-delete-log`.
3. You will see every content entity type on the site listed as a checkbox — for
   example **Content** (nodes), **User**, **Taxonomy term**, **Media**, and so on.
   Tick the ones whose deletions you want to record.
4. Click **Save configuration**.

That is the whole configuration. Only ticked types are logged; leaving a type
unticked means its deletions are ignored. On a fresh install nothing is selected,
so the module logs nothing until you save a selection here.

## What gets recorded

When an entity of a logged type is deleted, one row is written to the module's
`entity_delete_log` table capturing:

- the entity's **id, type, bundle and title** (the title is captured at deletion
  time, so it is preserved even though the entity is gone),
- the entity's **original author** and its **created** date,
- for revisionable entities, the **number of revisions** it had,
- the **time of deletion**, and
- the **acting user** — the account that performed the deletion.

## Read the report

Go to **Reports → Entity Delete Log** (`/admin/reports/entity-delete-log`). This
page is a Views listing and requires the **Access site reports** permission, so
you can let trusted editors see it without giving them configuration access.

The report is sorted with the most recent deletions first and offers exposed
filters for **Entity Type** and **Entity Bundle** — so you can narrow it to, say,
only deleted articles. It also includes relationships to both the acting user and
the original author, and because it is a normal Views view you can clone or
extend it — for example to build a CSV export for compliance, or add the deletion
data as a relationship in another view.

## For developers

Two alter hooks are available for other modules:
`hook_entity_delete_log_alter()` to change the values before a row is inserted,
and `hook_entity_delete_log_post_process()` to react after a deletion is logged
(for instance firing an external notification). Details are in the
[`agent/`](../agent/start.md) docs.
