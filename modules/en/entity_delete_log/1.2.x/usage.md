Entity Delete Log records a row in a dedicated database table every time an entity of a selected type is deleted, capturing who deleted it, when, the entity's title/id/bundle, its author and revision count.

---

The module is deliberately small: it defines a `hook_entity_predelete()`/`hook_entity_delete()` pair plus a settings form and a Views-backed report. On the settings page (`/admin/config/content/entity-delete-log`, route `entity_delete_log.settings`, permission *administer site configuration*) you tick which **content entity types** should be logged; the choice is stored in the simple config `entity_delete_log.settings` under the key `entity_types`. When an entity of a ticked type is deleted, `hook_entity_delete()` inserts a row into the base table `entity_delete_log` with the acting user id (`uid`), entity id/type/bundle/title, the entity author, its created timestamp, deletion timestamp, and — for revisionable entities — the revision count (captured in `hook_entity_predelete()` via `\Drupal::state()` and consumed on delete). The data can be reviewed at `/admin/reports/entity-delete-log`, a Views view (`views.view.entity_delete_log`) gated by the *access site reports* permission, with exposed Entity Type / Entity Bundle filters and relationships to both the acting user and the original author. Two alter hooks — `hook_entity_delete_log_alter()` and `hook_entity_delete_log_post_process()` — let other modules mutate the logged variables before insertion or react afterwards. It ships no config schema, no Drush commands, no plugins, and no permissions of its own.

---

- Keep an audit trail of which nodes were deleted, by whom, and when.
- Record deletions of users so you know which account removed a member and when.
- Log taxonomy term deletions to trace vocabulary clean-ups.
- Track media entity deletions for digital-asset governance.
- Capture the title of a deleted entity even though the entity itself is gone.
- Record the original author of deleted content for accountability.
- Store the revision count a revisionable entity had at deletion time.
- Provide a Reports page (`/admin/reports/entity-delete-log`) for site editors with "access site reports".
- Restrict which editors can create/administer logging via "administer site configuration".
- Filter the deletion report by entity type (e.g. only `node`).
- Filter the deletion report by bundle (e.g. only `article`).
- Sort deletions by deletion date to find the most recent removals.
- Enable logging selectively for only the entity types that matter (config key `entity_types`).
- Integrate the log data into custom dashboards by querying the `entity_delete_log` table.
- Extend the logged fields from a custom module via `hook_entity_delete_log_alter()`.
- Fire external notifications (Slack, email) after a deletion via `hook_entity_delete_log_post_process()`.
- Detect accidental mass deletions by reviewing the report after a bulk operation.
- Attribute deletions to the correct acting user even for anonymous-triggered deletes (falls back to uid).
- Build a Views-based CSV export of deletions for compliance reporting.
- Correlate a deleted node's author account with the person who deleted it via the two user relationships.
- Provide forensic evidence when content unexpectedly disappears from the site.
- Log deletions across many content types with a single checkbox each.
- Add the deletion-log data as a relationship in other custom Views.
- Preserve deletion history independently of node revisions (which are gone once the entity is deleted).
