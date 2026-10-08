<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Purge Akamai Optimizer — agent orientation

Optimises Akamai cache-tag purging under the Purge framework (hashing, tag reduction, priority tags, purge-everything purger).

- Version 2.0.x, core `^9.3||^10`, deps akamai + purge + purge_queuer_coretags. Settings `/admin/config/akamai/purge-akamai-optimizer-settings` (`administer akamai`).
- Services: `ReduceTags`, `QueueTags`, `TagsHashingSubscriber`; purger `AkamaiPurgeEverything`; cron cleanup + priority tags.
- Admin-only settings form is the only surface; no external HTTP in this module, no untrusted input. Nothing exploitable found.