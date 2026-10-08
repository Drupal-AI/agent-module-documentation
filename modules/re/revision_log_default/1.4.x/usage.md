<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Revision Log Default automatically fills in a sensible revision log message whenever a revisionable content entity is saved without one, so revision histories describe what happened instead of being blank.

---

The module is a single `hook_entity_presave()` implementation with no configuration, no admin UI, no permissions, and no services. On every save of a content entity that implements `RevisionLogInterface` (nodes, and other revisionable entities), it checks whether the revision log message is empty; if it is, it generates one. New entities get "Created new &lt;bundle label&gt;"; a new translation gets "Created &lt;language&gt; translation"; an update diffs the entity against its original and produces "Updated the &lt;Field&gt; field" (or a list of field labels) — falling back to "Updated &lt;bundle label&gt;" when it cannot identify changed fields. While doing so it also repairs the revision creation time and revision author when they are missing or stale (common with Drush, REST, Quick Edit, and migrations). It is Content-Moderation- and Workbench-Moderation-aware: for moderated entities it compares against the latest revision rather than the default revision. It never overwrites a log message that was explicitly provided. Certain fields are ignored when diffing (`changed`, the revision key, any `revision*` field, and empty comment fields), and path/alias fields are compared specially.

---

- Give every node revision a meaningful log message without training editors to write one.
- Auto-label revisions created programmatically (`Node::create()->save()`) that would otherwise have empty logs.
- Populate revision logs for content imported by migrations, which normally leave them blank.
- Add revision messages to content created or updated over REST/JSON:API where no log is supplied.
- Fix empty revision logs from Quick Edit / in-place editing saves.
- Describe an update as "Updated the Title field" so the revisions tab reads like a changelog.
- List multiple changed fields (e.g. "Updated the Body and Tags fields") on a single edit.
- Fall back to "Updated Article" when the specific changed field cannot be determined.
- Record "Created new Article" automatically the first time a node is saved.
- Record "Created German translation" when a new translation of an entity is added.
- Keep revision authorship correct by setting the revision user when the current user is anonymous (CLI/migration) — falling back to the entity owner.
- Correct a stale revision timestamp so the revision reflects the actual save time.
- Improve moderated-content histories by diffing against the latest (not default) revision under Content Moderation.
- Support Workbench Moderation sites with the same latest-revision comparison.
- Provide better audit trails for compliance without a heavyweight logging module.
- Make the node "Revisions" tab useful out of the box on editorial sites.
- Avoid a wall of blank entries in revision lists on high-churn content.
- Let custom code that saves entities skip building log messages by hand.
- Preserve any explicitly-set revision log message (the module only acts when it is empty).
- Work with any revisionable entity type that implements `RevisionLogInterface`, not just nodes.
- Reduce boilerplate in custom modules that create/update content and want readable revisions.
- Give content teams a low-effort audit trail of who changed what and when.
- Pair with core's revision UI to review "Updated the &lt;field&gt;" messages across a node's history.
- Standardise revision-message wording across an entire site automatically.
