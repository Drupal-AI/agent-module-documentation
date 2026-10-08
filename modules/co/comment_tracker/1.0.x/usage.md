<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Per-user read/unread comment tracking on top of core comments: exposes new/read/total counts to node templates and an is_new_comment flag to comment templates, with JavaScript that marks a comment read once it has been on screen for a few seconds.

---

Comment tracker adds a lightweight "new comments" layer to Drupal's core comment system. For each signed-in user it remembers which individual comments that user has actually seen, storing one small `comment_tracker` record per (user, comment) pair. From that read-state it hands theme templates the data needed to highlight unread activity: node templates receive a `comment_stats` object with counts of new, read and total comments (the user's own comments excluded), and comment templates receive an `is_new_comment` boolean. A small JavaScript behavior uses an IntersectionObserver to detect when a comment has been at least half visible for five seconds, then calls a mark endpoint so the comment is recorded as read and its "new" indicator is removed on the fly. Tracking is opt-in per comment type via an "Enable Comment Tracker" checkbox on the comment-type edit form (stored as a third-party setting); the module ships no settings page, no CSS and no templates, leaving the actual markup and styling of indicators to the theme. It is a read-state tracker in the spirit of "new since last visit", not a comment hit-counter or analytics tool.

---

- Show a "new comment" badge on comments a signed-in user has not read yet.
- Show an unread-comment counter on nodes that have tracked comments.
- Track read state per individual user (one `comment_tracker` entity row per user + comment).
- Exclude a user's own comments from new/read/total counts.
- Turn tracking on only for the comment types you choose, via a per-comment-type checkbox.
- Expose `comment_stats.new`, `.read`, `.total` to `node.html.twig`.
- Expose `is_new_comment` to `comment.html.twig`.
- Mark a comment read automatically once it has been ~50% visible for 5 seconds.
- Remove the "new" badge and node counter in the browser as soon as a comment is marked read.
- Keep anonymous users out of tracking (no rows recorded, counts return zero).
- Avoid duplicate read records for the same user + comment.
- Invalidate per-user and per-entity caches when comments are added or read.
- Let themes fully control indicator markup with two documented CSS class hooks.
- Build on core comments without altering how commenting itself works.
- Provide a Views-queryable read-tracking entity for custom reporting.
- Gauge which discussions a returning user still has unread.
- Drive "jump to first unread" style theming from the exposed flags.
- Support Drupal 10 and 11 with no third-party libraries.
