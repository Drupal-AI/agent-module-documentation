Media Expire automatically unpublishes media entities once a per-bundle date field passes, and can render a configured fallback media item in place of the expired one.

---

You enable expiry per media type on the *Edit* form (`admin/structure/media/manage/{type}`): the module adds an "Expire configuration" fieldset with an **Activate media expire** checkbox, an **Expire field** select (any non-base `datetime` field on that bundle), and an optional **Fallback media** autocomplete. These are stored as third-party settings on the `media_type` config entity (`enable_expiring`, `expire_field`, `fallback_media` as a UUID). On every cron run (and via `drush media:expire-check`), `MediaExpireService::unpublishExpiredMedia()` queries each expiring bundle for published media whose expire date is in the past, sets them unpublished, and clears the expire field value. When an unpublished media of an expiring bundle is viewed, `hook_ENTITY_TYPE_build_defaults_alter` swaps its render output for the fallback media (or an empty build if none). A custom access control handler and route subscriber make the fallback viewable to users with the *view media* permission, and a GraphQL data producer (`FallbackEntity`) exposes the fallback for decoupled sites. There is no dedicated settings page and no permission of its own.

---

- Automatically unpublish a promotional banner media item after its campaign end date.
- Expire licensed stock imagery when the license date passes.
- Take time-limited video assets offline automatically without editor intervention.
- Show a "content no longer available" fallback image in place of an expired media item.
- Configure expiry independently per media type (image, video, document, etc.).
- Use any datetime field on the bundle as the expiry trigger.
- Run expiry on normal cron so no manual step is needed.
- Force an immediate expiry sweep on demand with `drush media:expire-check` (alias `mec`).
- Clear the expire date after unpublishing so an item is not repeatedly reprocessed.
- Keep a default/placeholder asset displayed for any expired media of a bundle.
- Automatically hide seasonal media (holiday graphics) after the season ends.
- Provide a graceful fallback for expired hero images in Layout Builder or view modes.
- Expose the fallback media for an expired item through GraphQL on a decoupled front end.
- Sunset downloadable files (PDFs) attached as media after a compliance deadline.
- Rotate homepage media by expiring old items on a schedule.
- Let editors set an expiry date when creating media, then forget about it.
- Ensure out-of-date media stops appearing in listings once unpublished.
- Use a single fallback item to cover many expired items of the same type.
- Migrate legacy "valid until" metadata into an automated unpublish workflow.
- Combine with content moderation by unpublishing expired assets automatically.
