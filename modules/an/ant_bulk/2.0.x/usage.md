<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Auto Node Translate Bulk runs Auto Node Translate over many nodes at once — the bulk companion to a module that otherwise translates one node at a time.

---

Auto Node Translate hands a node's fields to a machine-translation provider and writes the translations back. That is exactly what new content needs and does nothing for the thousands of existing nodes a site already has when it goes multilingual. This module supplies the missing bulk path. A form at `/ant-bulk/translate` lets an editor pick target languages and content types (only types with content translation enabled are offered), optionally cap the number of nodes, and choose whether to overwrite existing translations; a `TranslationManager` service (`ant_bulk.manager`) builds the node list and dispatches a Batch that calls `auto_node_translate`'s translator on each node. A Drush command `ant_bulk:translate` (alias `anttrans`) does the same from the CLI for one content type and language at a time. When `content_moderation` is installed, the form can assign a moderation state to the new translations. A small settings form toggles whether only published nodes are processed, and a `hook_ant_bulk_translation_items_alter()` hook lets other modules drop nodes from a run. The provider, credentials and field mapping all belong to `auto_node_translate` — this module only orchestrates which nodes and languages flow through it. Composer requires `auto_node_translate ^3.0` and core `^10.2 || ^11`.

---

- Translate a backlog of existing nodes in one operation.
- Add a new language to an established multilingual site.
- Run bulk translation from Drush on a schedule or during deploys.
- Translate one content type at a time into one target language.
- Seed machine translations for human post-editing.
- Reduce manual translation effort at launch.
- Cap a run to the newest N nodes with the batch-size field.
- Skip nodes that already have a translation, or overwrite them.
- Restrict processing to published nodes only via the settings form.
- Assign a content-moderation state to newly created translations.
- Translate content migrated in from another system.
- Fill gaps where some translations are missing.
- Provide draft translations for editorial review.
- Support a site expanding into a new market.
- Re-translate after source content changes, with overwrite on.
- Exclude specific nodes from a run through the alter hook.
- Translate a whole content type before an event or launch.
- Reuse the same provider configuration as single-node translation.
- Kick off large runs from the CLI to avoid browser timeouts.
- List only translation-enabled content types for selection.
