The unsubscribe submodule (experimental) lets a subscriber site disconnect an individual imported entity from further pushed updates, so local edits to that entity are not overwritten by syndication.

---

It adds a checkbox — "Disable auto updating of this entity" — to entity forms for entities that
are tracked by the subscriber (`acquia_contenthub_subscriber.tracker`). When checked, the
entity's tracker status is set to `AUTO_UPDATE_DISABLED`, so subsequent imports from Content
Hub skip it and local changes persist. Importantly, the form element is added with
`#access => FALSE` by default: exposing it requires custom code to decide when editors may
unsubscribe an entity, so the module is a building block rather than a turnkey UI. It only acts
on entities the subscriber already tracks, requires `acquia_contenthub_subscriber`, is
experimental, and has no settings form, permissions, or Drush commands.

---

- Stop pushed updates from overwriting a locally edited imported entity.
- Let a subscriber "fork" a specific syndicated entity for local customization.
- Preserve manual edits on a delivery site for chosen content.
- Toggle a tracked entity's auto-update status to disabled.
- Re-enable auto updating later by unchecking the box.
- Build an editorial "detach from source" feature on top of the checkbox.
- Gate who can unsubscribe entities via custom `#access` logic.
- Keep most content syndicated while pinning a few local overrides.
- Prevent a hero/landing entity from being reverted by the publisher.
- Support exception workflows in an otherwise fully-syndicated site.
- Act only on entities already tracked by the subscriber module.
- Store the decision in the subscriber tracker (no extra config).
- Combine with the subscriber import queue to skip flagged entities.
- Provide a hook point for site-specific unsubscribe governance.
- Let operators protect locally curated content from remote updates.
