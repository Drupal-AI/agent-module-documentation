<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Preserve Changed Timestamp UI adds a "Preserve changed time" checkbox to the node edit form. When an editor ticks it, saving the node keeps its existing `changed` ("Last saved") timestamp instead of advancing it to the current time — the fix for a one-character typo correction pushing an article back to the top of every "recently updated" listing.

---

The module adds a boolean base field `preserve_changed_time` to node entities (`hook_entity_base_field_info`), which an admin exposes per bundle on the manage form display. `hook_form_node_form_alter` shows the checkbox on the edit form, seeds its default from the site setting, and hides it for new nodes or for users without the "Allow Preserve Changed Time" permission. On save, `hook_entity_presave` resets the node's changed time to the original entity's value when the box is checked, then clears the flag so the choice applies to that single save only. A settings form at `/admin/config/system/preserve-changed-ui` (route `preserve_changed_ui.settings_form`, config `preserve_changed_ui.settings:enable_preserve_changed_time`) sets the checkbox's default state across all node types. It is node-only (depends on core `node`), ships no Drush commands or plugins, and carries a wide core requirement `^8.8 || ^9 || ^10 || ^11`; the current release is `1.0.0-beta2`.

---

- Fix a typo without bumping an article to the top of "recently updated" listings.
- Keep a sitemap's `lastmod` accurate to substantive changes only.
- Avoid re-notifying subscribers over a trivial edit.
- Preserve chronology in a "latest content" view sorted on `changed`.
- Correct metadata without changing an entity's ordering position.
- Enable the checkbox on selected content types via their form display.
- Set the site-wide default so the box is pre-ticked for minor-edit workflows.
- Keep feed ordering meaningful across cosmetic edits.
- Let only trusted editors preserve the timestamp, via the dedicated permission.
- Avoid direct database edits just to fix a `changed` value.
- Correct an author byline or field label quietly.
- Fix an accessibility attribute without flagging the node as freshly updated.
- Keep the "Last saved" column stable in admin content lists after a small fix.
- Make the "does this count as an update?" decision explicit on the edit form.
- Support an editorial policy about what edits should move the changed date.
- Prevent unnecessary search re-indexing triggered by a `changed` bump.
- Keep cache keys that derive from `changed` stable across a no-op edit.
- Retain accurate change history for genuine content revisions.
- Apply the preserve choice as a one-shot toggle that resets after each save.
- Configure the default behaviour once, then override per node as needed.
- Batch-correct spelling across nodes without reshuffling every listing.
