<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Purge Akamai Optimizer

Sits on top of the Purge + Akamai stack to make cache-tag purging efficient at CDN scale. It hashes cache tags, reduces/collapses the queued tag set, maintains a priority tag list, and offers an 'Akamai purge everything' purger for when tag-level purging is not enough.

---

# Installing & configuring

- Enable the module (requires akamai, purge, purge_queuer_coretags).
- Configure at `/admin/config/akamai/purge-akamai-optimizer-settings` (permission `administer akamai`).
- Settings are stored in `purge_akamai_optimizer.settings`.
- Cron drives old-identifier cleanup and priority-tag generation.

---

- `TagsHashingSubscriber` hashes cache tags for compact CDN invalidation keys.
- `ReduceTags` service collapses/reduces the queued tag set and removes old identifiers.
- `QueueTags` service manages the tags queued for purge.
- `AkamaiPurgeEverything` is a Purge purger plugin for full invalidation.
- `hook_cron()` calls `removeOldIdentifiers()` and conditionally `generatePriorityListTags()`.
- The settings form is gated by `administer akamai`.
- No anonymous or user-facing routes are exposed.
- No external HTTP calls are made by this module itself (Akamai calls are handled by the akamai module).
- No permissions of its own beyond reusing `administer akamai`.
- Config schema is provided for the settings.
- An `api.php` documents alter/extension points.
- Purely a performance/operations optimisation layer.
- Reduces purge queue volume to stay within Akamai rate/size limits.
- Intended for high-traffic sites using Akamai as the CDN.
- No untrusted input is processed; the attack surface is limited to the admin form.
- Nothing security-sensitive was identified in the module code.
