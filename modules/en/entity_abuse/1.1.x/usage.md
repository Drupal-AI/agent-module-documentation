Entity Abuse lets site users submit abuse complaints ("reports") against any content entity, and gives moderators a Views-based queue to review them.

---

The module defines a dedicated `entity_abuse_report` content entity that records who reported what: the reporting user (`uid`), the reported entity's type and id (`entity_type`, `entity_id`), timestamps, and a configurable field set (by default a single formatted-text "Message" field). On the settings form at `/admin/structure/entity-abuse` you choose which content entity types expose a "Report abuse" pseudo-field, how the report link opens (a full page, a dialog, or a modal), what happens to a user's reports when their account is cancelled (delete or re-assign to anonymous), and what to do when a visitor lacks permission to report (hide the link or show a "no access" message). Each enabled entity type gains an "Abuse report link" display component whose lazy-built link points logged-in users to add, edit, or cancel their own report for that entity. Report add/edit/delete are standard Drupal entity forms gated by granular per-entity permissions ("add", "view/edit/delete own", "view/edit/delete any"), the report entity ships Field UI, Manage form display and Manage display support, config schema, config-translation, and a bundled "Abuse reports" View (admin page plus a per-user "My abuse reports" tab). Reports can only be created against entity types you enabled and entities the reporter is allowed to view.

---

- Let authenticated users flag inappropriate nodes for moderator review.
- Add a "Report abuse" link to user profiles so members can report abusive accounts.
- Allow comments to be reported as spam or abuse.
- Enable complaints against taxonomy terms or other custom content entities.
- Give a community site a lightweight abuse-reporting workflow without a full ticketing system.
- Provide a moderation queue (the "Abuse reports" admin View at `/admin/entity-abuse-reports`) listing all reports with the reporting user, date, message, and a link to the reported entity.
- Let each user see and manage their own reports on the "My abuse reports" tab at `/user/{uid}/abuse-reports`.
- Open the report form in a modal or dialog so users never leave the page they are reporting.
- Configure the report link to redirect to a standalone page instead of a dialog.
- Customize the "Add complaint", "Edit complaint", and "Cancel complaint" link labels per site voice.
- Show a custom, formatted status message after a report is added, updated, or cancelled.
- Display a formatted "you have no access" message to visitors who cannot report.
- Hide the report link entirely from users who lack the "add" permission.
- Add extra fields to the report (e.g. a reason category, severity) via Field UI on the report entity.
- Change how the default "Message" field is captured by editing Manage form display.
- Translate all configurable labels and messages with the core Configuration Translation module.
- Re-assign a departing user's reports to anonymous (or delete them) automatically on account cancellation.
- Grant moderators "view any" abuse reports while restricting regular users to "view own".
- Let trusted users edit or cancel their own submitted reports before a moderator acts.
- Build custom moderation dashboards or bulk-processing views on the `entity_abuse_report` base table (integrates with Views and Views Bulk Operations).
- Track how much abuse a specific piece of content has attracted by filtering reports on `entity_id`/`entity_type`.
- Prevent duplicate reports: the module surfaces an edit/cancel link instead of a second add link when the current user already reported that entity.
- Extend abuse reporting to any content entity type the site defines, not just core node/comment/user/term.
