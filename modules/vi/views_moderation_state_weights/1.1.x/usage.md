<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views moderation state weights exposes each Content Moderation state's configured **weight** to Views, so you can display it as a column and — more usefully — sort content by its editorial workflow order (draft → review → published) instead of alphabetically by state id.

---

Content Moderation stores an ordering weight for every state in a workflow, but core Views only exposes the state *id/label*, which sorts alphabetically. This module adds a Views **field** handler (`moderation_state_weight_field`) and **sort** handler (`moderation_state_weight_sort`), both labelled "Moderation state weight", to every moderated entity's data and revision tables via `hook_views_data()`. To keep the weight queryable, the module maintains its own table, **`views_moderation_state_weights`** (primary key `workflow` + `moderation_state`, plus `weight`), which it populates on install and keeps in sync through `workflow` entity insert/update/delete hooks (only for `content_moderation`-type workflows). The Views handlers join the base table → the `content_moderation_state` revision data table → this weights table, so a view can order rows by real workflow position. There is no configuration UI, no permissions, no Drush, and no exported config — you just add the field/sort in the Views UI on any moderated entity view. The weights table is an internal implementation detail rebuilt from workflow config.

---

- Sort a content moderation dashboard by workflow order (draft, needs review, published) instead of alphabetically.
- Show a "Moderation state weight" column in an editorial content view.
- Order a moderation queue so the least-progressed items appear first.
- Build an editor's "to-do" view that surfaces drafts before published content by weight.
- Sort content descending by state weight to see published/archived items last.
- Combine the weight sort with other sorts (e.g. changed date) for a stable moderation list.
- Expose workflow progression order in a view without hardcoding state ids.
- Sort a media moderation view by state weight (works for any moderated entity type).
- Provide a consistent ordering that follows the workflow even after states are renamed.
- Drive a colour-coded status board where rows are grouped/ordered by state weight.
- Feed a REST/JSON view of moderated content ordered by editorial progress.
- Order a "pending review" block by how far each item is through the workflow.
- Let reviewers page through content in workflow order across bundles.
- Reflect a reordered workflow in views automatically (the weights table re-syncs on workflow save).
- Sort taxonomy-moderated or custom-entity views by moderation weight the same way as nodes.
- Replace fragile alphabetical state sorting in an existing content admin view.
- Surface archived content at the end of a list by giving it the highest weight.
- Build a KPI view counting items at each workflow position, ordered by weight.
- Show the numeric weight next to the state label for debugging a workflow's ordering.
- Order a multi-workflow site's content correctly per its own workflow weights.
