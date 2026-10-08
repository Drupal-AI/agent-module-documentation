Custom Table Operations registers existing (non-entity) database tables as config entities and gives administrators a UI to view, add, edit and delete their rows.

---

The module defines a single config entity type, `dbtable`, listed at `/admin/config/system/dbtable`. For each entry an administrator supplies the entity a label that must equal the name of a real database table, then selects the primary-key column and the columns to display (both populated by running `DESCRIBE <table>` against the live schema). Once saved, a data-listing page renders every row of that table as an HTML table with per-row Edit/Delete links and an "Add new record" action. Adds, edits and deletes are performed with the core database API (`select`/`insert`/`update`/`delete`) keyed on the chosen primary key. There is no custom permission: every route requires the core `administer site configuration` permission, and the entity's `admin_permission` is the same. The project is aimed at developers/admins who maintain bespoke tables created outside the Entity API; the maintainer explicitly warns against registering Drupal's own core tables.

---

- Give admins a simple CRUD screen over a custom table created by a bespoke feature, without writing a controller.
- Inspect the current rows of a non-entity table straight from the Drupal admin, without a database client.
- Register a lookup/reference table (e.g. a code-to-label map) and let a trusted admin add or correct entries.
- Edit a single row's field values via a generated form keyed on the primary key.
- Delete a stale record from a custom table through a confirm-step form.
- Add a new record to a custom table, with a duplicate-primary-key guard that blocks inserts whose key already exists.
- Choose exactly which columns of a wide table are shown in the listing by selecting them in the field list.
- Point the module at an integration/staging table populated by an external process and review its contents.
- Manage the primary-key selection per table so the CRUD links target the right unique column.
- Provide a lightweight admin editor for a table that has no Entity/Views layer built around it.
- List all registered custom tables and their machine names and primary keys on one collection page.
- Rename/relabel or remove a registered table definition without touching the underlying table data.
- Use the "Add table" action to onboard a newly created custom table into the admin UI.
- Give a site builder a way to spot-check data written by a custom form or webhook handler.
- Correct a bad value in a custom log/queue table during debugging.
- Serve as a starting-point/example of a config-entity-driven admin CRUD over raw SQL for developers.
- Keep table definitions in configuration so they can be exported and deployed with the rest of the site config.
- Offer non-developer admins controlled row editing on a table that would otherwise require SQL access.
- Validate on save that the named table and chosen primary-key column actually exist before storing the definition.
- Back out of an edit or delete safely using the Cancel links that return to the table's data listing.
