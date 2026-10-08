All provides a single Drupal admin page that edits the default settings of every content type at once, instead of opening each content type's edit form individually.

---

All is a site-builder convenience module. It adds one administration form at `/admin/structure/types/all` (route `all.types`, gated by the core `administer content types` permission) that lists every node content type in a table with one row per type. For each type you can toggle Display author/date (`display_submitted`), New revision (`new_revision`), Published (`status`), Promoted (`promote`) and Sticky (`sticky`), and choose the Preview mode (Disabled / Optional / Required). Saving writes those values straight into each `node.type.<id>` config entity, so the effect is identical to editing the per-type form — just done for all types on one page. It reaches the form through an action link and a menu tab on the content-types collection (`/admin/structure/types`). The module is node-focused: if the `node` module is not installed the table is empty. It has no front-end output, no services, no plugins, no Drush commands, and works on Drupal 8 through 11.

---

- Turn on "Create new revision by default" for every content type in one save.
- Turn off the author/date submission info across all content types at once.
- Publish-by-default or unpublish-by-default all content types together.
- Set the Preview button to Disabled (or Optional/Required) for all types simultaneously.
- Flip the Promoted-to-front-page default on for all content types quickly.
- Set the Sticky default for all content types on a single screen.
- Standardise revision behaviour when onboarding editorial workflow to an existing site.
- Audit at a glance which content types currently create new revisions or show submission info.
- Speed up initial site build when you have many content types to align.
- Reach the page from the "Quick edit all types" action link on Structure > Content types.
- Reach the page from the "All-at-once content type configuration" tab on the content-types collection.
- Reduce the "five clicks per content type" repetition of the core per-type forms.
- Apply a house style (no author/date, revisions on, preview optional) across all bundles.
- Reset several content types back to the same publishing defaults after experimentation.
- Bring a newly imported content type in line with the rest without hunting through its form.
- Compare revision/preview/publishing defaults for all types side by side in one table.
- Prepare a site's content-type defaults before creating the first nodes.
- Keep multi-type sites consistent by managing shared defaults centrally.
- Avoid the grep/sed-on-config-files alternative for bulk default changes.
- Grant the ability only to trusted administrators who already hold `administer content types`.
