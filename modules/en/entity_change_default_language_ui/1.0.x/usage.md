<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity change default language UI adds a back-office interface, on top of the `entity_change_default_language` API module, for changing the default (original) language of nodes — either one node at a time or in bulk via a batch.

---

It exposes two Form API forms. A per-node form at `/node/{node}/change-default-language` (`ChangeDefaultLanguageForm`), reached from a *"Change default language"* operation link added to every node row on admin content lists, lets you pick the new original language, optionally create the translation in that language if it does not exist, and choose which existing translations to preserve — all others are removed. A site-wide batch form at `/admin/config/regional/change-default-language` (`ChangeDefaultLanguageBatchForm`), placed under *Configuration → Regional and language*, does the same across all nodes of a chosen content type that currently have a chosen original language, processing them in a Batch API run. The actual langcode rewrite and translation pruning is delegated to the `entity_change_default_language_ui.updater` service (`Updater`), which in turn calls the `entity_change_default_language` API module. Both forms target nodes only.

---
- Enable the `entity_change_default_language` API module, then this UI module.
- Change the original/default language of a single node from the admin content list.
- Open `/node/{node}/change-default-language` directly for one node.
- Pick a new original language for a node from the installed-language list.
- Create the translation in the new original language automatically if it is missing.
- Keep only selected existing translations while switching the original language.
- Remove translations you no longer need as part of the language change.
- Run the batch form at `/admin/config/regional/change-default-language` for bulk changes.
- Bulk-switch the original language of every node of one content type.
- Target only nodes whose current original language matches a chosen "from" language.
- Fix content that was imported or created under the wrong original language.
- Consolidate or correct original languages after a content migration.
- Normalise the original language across a large multilingual content set.
- Prepare content for a new primary site language before further translation work.
- Combine with core's translation UI for follow-up edits after the switch.
- Review the resulting default language on each node's translation overview.
- Use the batch progress messages to monitor a large site-wide language correction.
- Undo an accidental original-language assignment on many nodes at once.
- Reassign the original language when the source-content language policy changes.
- Clean up stale translations while re-basing a node's original language.
