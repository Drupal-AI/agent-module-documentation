Set Author is an Entity Share Client import processor that decides which local user becomes the author (`uid`) of a content entity as it is pulled in from a remote site.

---

Set Author adds a single `set_author` import processor plugin to the Entity Share Client pipeline (it has no admin page, permissions, Drush commands, or config of its own — it is configured per import config on the Entity Share channel/import UI). When an entity is imported, the processor reads the source `uid` relationship from the JSON:API payload. It first tries to match the referenced user to a local account by UUID; if that fails it fetches the referenced user resource from the remote and matches by email, then by username. If `Create author if it does not yet exist` is enabled it will create a local user from the remote name/mail/status when no match is found. If nothing matches and creation is off (or fails), it falls back to a configured default `Shared author` user (anonymous by default). The resolved id is written to the entity's `uid` before it is saved. It runs in the `process_entity` stage at weight 110 and is unlocked, so it can be toggled per import config. The module depends on `entity_share:entity_share_client` (`drupal/entity_share ^3.0`) and supports Drupal 10 and 11.

---

- Preserve original authorship when syndicating nodes/content between Drupal sites via Entity Share.
- Map remote authors to existing local accounts by UUID, email, or username during an import.
- Assign a single fallback "shared author" to all imported content when the source author has no local counterpart.
- Default imported content to the anonymous user when no author mapping is possible.
- Auto-provision local user accounts for remote authors that do not yet exist on the destination site.
- Keep author attribution consistent across a content staging (stage → live) workflow.
- Attribute pulled content to a generic service/bot account instead of whoever ran the import.
- Normalise authorship across a multi-site content hub where the same editors exist on several sites.
- Avoid orphaned or import-user authorship on content pulled from an external source.
- Re-home content authored by users that were never migrated to the destination site.
- Ensure "Authored by" fields and author-based Views/filters keep working after a cross-site import.
- Support editorial workflows where imported content should appear under an editorial team account.
- Bring across author identity when consolidating several sites into one.
- Reassign authorship automatically as part of a scheduled/cron Entity Share pull.
- Let author-based access control (e.g. per-author edit permissions) behave correctly on imported content.
- Choose per import config whether a given channel preserves, remaps, or overrides authorship.
- Fall back gracefully when a remote author account is deleted or missing on the source.
- Populate a fresh site's users on-demand from the authors of the content you import.
- Match authors even when local UUIDs differ, by falling back to email/username lookup.
- Keep content ownership sensible when the source site and destination site have divergent user sets.
