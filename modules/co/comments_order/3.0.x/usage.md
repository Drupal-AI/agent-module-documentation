<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Comments Order lets you choose, per comment field, whether comments display oldest-first (ascending) or newest-first (descending), and how threaded child comments sort within that order.

---

The module adds three extra settings — **Comments order** (ASC/DESC), **Natural order for children**, and **Order by "Authored On" field** — to any comment-type field's edit form on a bundle's *Manage fields* page (`field_config_edit_form`). It stores them as third-party settings (`comments_order.order`, `comments_order.children_natural_order`, `comments_order.created_order`) on that field's `field.field.*` config. At display time it implements `hook_query_TAG_alter()` for the `comment_filter` query tag and rewrites the `ORDER BY`: for flat lists it flips `c.cid` (or switches to `c.created` when created-order is on); for threaded lists it reverses parent threads via a `SUBSTRING`/`SUBSTRING_INDEX` expression on `c.thread`, optionally keeping children in natural order or reversing them too. It also swaps the comment entity's storage handler for `CommentsOrderStorage` so pager ordinals (`getDisplayOrdinal()`) match the chosen direction, and adds a comment-form submit handler that redirects to the first page after posting when descending order is active. There is no admin settings page (`configure` is null) and no permissions, Drush, or plugins of its own.

---

- Show newest comments first on a blog article's comment thread (descending order).
- Keep the classic oldest-first ordering on a forum-style discussion where reading order matters.
- Reverse only parent comments while keeping each reply chain in natural chronological order.
- Fully reverse a threaded discussion so both parents and their children read newest-first.
- Order a flat (non-threaded) comment list by comment id descending for a "latest activity" feel.
- Switch a flat comment list to sort by the "Authored On" date instead of insertion id.
- Configure comment ordering per content type by editing each bundle's comment field separately.
- Apply different comment orders to different comment fields on the same entity type.
- Set newest-first ordering on a news site so the most recent reader feedback is visible immediately.
- Redirect commenters back to page 1 after they post when newest-first is enabled, so they see their comment.
- Present product-review comments newest-first without writing a custom query alter.
- Keep pager page counts and comment ordinals consistent with the chosen sort direction.
- Deploy comment-order preferences through configuration (`third_party_settings.comments_order` in `field.field.*`).
- Toggle a discussion between ascending and descending order per environment via config override.
- Standardise comment ordering across a multi-author publication from the Manage fields UI.
- Give moderators a newest-first view of incoming comments on high-traffic content.
- Order comments on a custom entity type (not just nodes) that uses a comment field.
- Reverse a long-running Q&A thread so the most recent answers surface first.
- Avoid a contrib "comment sort" custom module by using a single field setting instead.
- Keep children in reading order while surfacing the newest top-level questions first (natural children order).
- Fully invert a nested comment tree for a "most recent everywhere" experience.
- Sort feedback by authored date when comments were imported/backdated out of insertion order.
- Configure comment display direction without editing templates or view modes.
- Make comment threads on an event page show the latest remarks first.
