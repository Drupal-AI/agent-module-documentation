<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Track Usages records which target entities (files, terms, media, nodes, …) are used by which top-level source entities, traversing intermediate media/paragraph entities but storing only the source-to-target relation.

---

The tracker service descends through a source entity's fields, follows entity references, embeds, links and other reference-carrying fields via pluggable "track" plugins, and collects the target entities it reaches — recording only the relation between the topmost source entity and the final target, so the usage table stays compact even on deeply nested content. Unlike Entity Usage (which records every one-step relation), Track Usages skips the middle "traversable" entities and keeps just the endpoints, while separately storing the traversal path so callers can reconstruct how a target is reached. Tracking scenarios are defined as `track_usage_config` config entities, so a site can run several independent configurations at once (e.g. node→file in one, node→term in another). Recording can run in real time on entity insert/update/delete, or be rebuilt in bulk via batch, a cron queue, or an instant run — from the admin UI or the `track_usage:update` Drush command. The module ships no end-user UI and no public routes; it is backend API/infrastructure that other code queries through the `RecorderInterface`/`ReaderInterface` services. As with any usage tracker, an empty usage record means "not tracked", not necessarily "not used" — completeness depends on which track plugins run and whether the data has been (re)built.

---

- Find which files a node uses, traversing its media and paragraph fields.
- Track which taxonomy terms a piece of content references.
- Record node-to-media usage across nested paragraph structures.
- Keep the usage table compact by storing only source-to-target endpoints.
- Run several independent tracking scenarios via separate config entities.
- Track only active (default) revisions, or every revision, per configuration.
- Record entity changes in real time on insert/update/delete.
- Rebuild usage data in bulk as a batch process from the admin UI.
- Defer a bulk rebuild to a cron-run queue for large data sets.
- Rebuild usage data instantly for small data sets or testing.
- Rebuild a configuration from the CLI with `drush track_usage:update <config>`.
- Query targets used by a source or traversable entity via `getTargetsForEntity()`.
- Reconstruct the reference path(s) to a target via `getPathsToTarget()`.
- Follow references authored as plain HTML links in rich-text fields.
- Track entities referenced through Linkit, Entity Embed, or Media Embed.
- Track CKEditor-inserted images back to their file entities.
- Track entity references placed inside Layout Builder or block fields.
- Track dynamic entity reference fields and core link fields.
- Re-track a commented entity when a new comment references it.
- Clean up usage records automatically when entities, revisions, or translations are deleted.
- Remove a configuration's records automatically when that config entity is deleted.
- Restrict all configuration to holders of the "administer track usage" permission.
- Restrict which reference types are followed by selecting specific track plugins per config.
- Scope source, traversable, and target entities down to individual bundles.
- Extend URL-to-entity resolution with a custom `hook_track_usage_entity_guess()`.
- Warn editors when a config change requires a full tracking-data rebuild.
- Use it as a scalable alternative to Entity Usage when only endpoints matter.
