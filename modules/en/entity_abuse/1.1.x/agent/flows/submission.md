<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Report submission flow (routes, forms, link)

All routes are in `entity_abuse.routing.yml`. The `entity_abuse_report` entity's own links are declared
in the entity annotation (`src/Entity/EntityAbuseReport.php`), and local tasks in
`entity_abuse.links.task.yml`.

## Routes

| Route | Path | Access | Handler |
|---|---|---|---|
| `entity.entity_abuse_report.add_form` | `/entity-abuse-report/{entity_type}/{entity_id}` | `_entity_create_access: entity_abuse_report` | form `entity_abuse_report.default` (`EntityAbuseReportForm`) |
| `entity.entity_abuse_report.edit_form` | `/entity-abuse-report/{entity_abuse_report}/edit` | `_entity_access: entity_abuse_report.update` | same default form |
| `entity.entity_abuse_report.canonical` | `/entity-abuse-report/{entity_abuse_report}` | `_entity_access: entity_abuse_report.view` | `_entity_view: entity_abuse_report.full` |
| `entity.entity_abuse_report.delete_form` | `/entity-abuse-report/{entity_abuse_report}/delete` | `_entity_access: entity_abuse_report.delete` | `EntityAbuseReportDeleteForm` |
| `entity_abuse.settings` | `/admin/structure/entity-abuse` | `_permission: entity_abuse manage settings` | `EntityAbuseSettingsForm` |
| `entity_abuse.no_access` | `/entity-abuse-report-access/{entity_type}/{entity_id}` | `_access: 'TRUE'` | `EntityAbuseNoAccess::page` |

`{entity_type}` is constrained to `[a-z0-9_]+`, `{entity_id}` and `{entity_abuse_report}` to `\d+`. Add
and edit are standard entity-form (POST) submissions; delete is a confirm form.

## The link (how users reach the add/edit/cancel action)

`entity_abuse_entity_view()` (`entity_abuse.module`) adds an `entity_abuse_report_link` element as a
`#lazy_builder` for `entity_abuse.report_link_lazy_builder:getLink` on every enabled entity whose display
shows the "Abuse report link" component (`entity_abuse_entity_extra_field_info()` registers that component
for the enabled types/bundles).

`EntityAbuseReportLinkLazyBuilder::getLink($entity_id, $entity_type, $destination)`
(`src/EntityAbuseReportLinkLazyBuilder.php`, a `TrustedCallbackInterface`) decides the link, sets `#cache`
`max-age: 0`, attaches `core/drupal.dialog.ajax`, and themes via `entity_abuse_report_links`
(`templates/entity-abuse-report-links.html.twig`):

- No `add entity_abuse_report` permission → if `no_access_behavior` is `hide`, render nothing; else a link
  to `entity_abuse.no_access`.
- Already reported (via `EntityAbuseService::getExistingReport()`, keyed on entity_id + entity_type +
  current uid) → an **edit** link (if `edit own`) and/or a **cancel** = delete link (if `delete own`).
- Otherwise → a **create** link to the add form.
- When `report_link_behavior` is `dialog`/`modal` the anchor gets `use-ajax` + `data-dialog-type`.

## Add / edit form — `EntityAbuseReportForm`

`src/Form/EntityAbuseReportForm.php` extends `ContentEntityForm`.
- `validateForm()` resolves the reported entity from the route (`getReportedEntity()`) and, for a **new**
  complaint, errors out unless the target is a `ContentEntityInterface` whose `access('view')` passes and
  whose type is in `getEnabledEntityTypes()` — reports can only target enabled types and entities the
  reporter is allowed to view.
- `save()` sets `entity_type`/`entity_id` from the reported entity on create, shows the configured added/
  edited status message (`check_markup`), and redirects to the report canonical page.

## Delete ("cancel") form — `EntityAbuseReportDeleteForm`

`src/Form/EntityAbuseReportDeleteForm.php` extends `ContentEntityDeleteForm`; confirm text "Cancel your
report", description/message drawn from `note_cancel_report` / `message_report_canceled`, redirects to
`<front>`.

## No-access page — `EntityAbuseNoAccess::page`

`src/Controller/EntityAbuseNoAccess.php` returns the admin-configured `message_no_access` as
`#type: processed_text`. Route is `_access: 'TRUE'` so it can render for anonymous visitors; it emits only
site-admin-authored config text (the `{entity_type}`/`{entity_id}` params are unused except a `@todo`).
