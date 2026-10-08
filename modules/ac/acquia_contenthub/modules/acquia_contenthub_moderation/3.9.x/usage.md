Experimental Content Hub submodule for subscriber sites: it imports syndicated content into a
configured content-moderation state per workflow (for example `draft`) rather than publishing it
outright, creating a pending forward revision when the target state is unpublished.

---

By default Content Hub imports arrive in whatever state the CDF carries, which on a subscriber can
mean content is published immediately. This submodule lets an editor pick, per workflow, the
moderation state that incoming content should land in. It stores that choice in
`acquia_contenthub_moderation.settings` under `workflows.<workflow_id>.moderation_state`, set
through an "Import Moderation State" select added to the core workflow edit form. At import time
the `CreateModeratedForwardRevision` subscriber (on the base module's `PRE_ENTITY_SAVE` event,
priority 5) applies that state to the imported entity — and, when the state is not a published
one, marks the revision non-default so the live version on the subscriber is untouched until an
editor promotes it. It depends on `acquia_contenthub_subscriber` and core `content_moderation`,
warns on install, and raises a requirements error for any workflow left unconfigured. No routes,
permissions, or Drush commands.

---

- Import syndicated content as `draft` (or another state) instead of published.
- Keep an editorial review step for content arriving from publishers.
- Create pending forward revisions for unpublished imported content.
- Avoid overwriting a subscriber's live revision with incoming syndication.
- Configure a distinct import state per workflow.
- Route imports for different content types into different moderation states.
- Hold syndicated content for local approval before it goes live.
- Set the import state directly from the workflow edit form.
- Set the import state via `drush cset` for automation.
- Apply the import state only to the languages present in the CDF.
- Enforce governance over what syndicated content is published on a subscriber.
- Surface a requirements error when a workflow has no import state configured.
- Combine content moderation with Content Hub subscriber imports.
- Support staged publishing workflows across a multi-site network.
- Let editors promote imported drafts to published on their own schedule.
