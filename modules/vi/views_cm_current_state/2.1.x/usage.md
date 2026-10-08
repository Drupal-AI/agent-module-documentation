<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views content moderation current state adds a single Views field, "Current state", that shows the Content Moderation state of the **latest** revision of each row's entity — including a not-yet-published forward (draft) revision that the core "Moderation state" field does not surface.

---

The module registers one Views field handler, `current_state_views_field` (plugin id `current_state_views_field`, class `CurrentStateViewsField`), via `hook_views_data()` on the special global `views` table under the "Content revision" group, so the field is available in **any** view regardless of its base table. Unlike the core `moderation_state` field, which reflects the default (published) revision loaded for the row, this handler loads the entity's *latest* revision with `getLatestRevisionId()` / `loadRevision()` and returns that revision's `moderation_state` label resolved through the entity's workflow (`content_moderation.moderation_information` → `getWorkflowForEntity()->getTypePlugin()->getState()->label()`). If the latest revision has no moderation state (the entity is not under moderation), it falls back to returning "Published" or "Unpublished" based on the published flag. The handler overrides `query()` to a no-op (it adds nothing to the SQL query and computes its value at render time from `$row->_entity`), so it is a pure render-time field with no sortable/filterable database column. It requires both `views` and `content_moderation`, ships no configuration, no permissions, no Drush, and no settings form — you simply add the field to a view.

---

- Show the live editorial state (Draft, Needs Review, Published, Archived) of the newest revision in a moderated-content view.
- Build an editors' dashboard listing nodes whose latest revision is still in "Draft" while an older revision is published.
- Distinguish content with a pending forward revision from content whose published revision matches the latest.
- Add a "Current state" column to a content overview view that mirrors what editors see, not the published-revision state.
- Report on articles awaiting review across a workflow by displaying their current moderation state.
- Provide a moderation-status column in a view whose base table is not the entity's own (thanks to the global `views` table registration).
- Surface the moderation state of media entities, taxonomy terms, or any moderated entity type in a Views listing.
- Create a "My drafts" view for authors that shows each item's current workflow state.
- Give reviewers a queue view where the current state column reflects unpublished pending edits.
- Combine with the core "Moderation state" field in one view to compare default-revision vs latest-revision state side by side.
- Colour-code or rewrite the current-state value in Views to build a status badge.
- Filter visually (by eye) a table of content by its true current editorial state.
- Show "Published"/"Unpublished" for non-moderated content types in the same column, so a mixed view still renders a status.
- Feed a REST/JSON export view that must include each entity's current moderation state.
- Display current state in a block view of recently edited content for the admin toolbar area.
- Audit which nodes have a latest revision differing in state from the live one.
- Add current-state visibility to a moderated commerce or custom entity listing.
- Let content managers spot stuck-in-review items without opening each node's revisions tab.
- Populate an editorial calendar view with the working state of each scheduled item.
- Provide a lightweight status column without writing a custom Views field plugin yourself.
- Include current moderation state in an exported CSV of content for stakeholders.
- Show the draft state of translations' latest revisions in a multilingual content view.
- Drive conditional Views row styling from the rendered current-state text.
- Give a workflow overview page one column that always tells the truth about the newest revision.
