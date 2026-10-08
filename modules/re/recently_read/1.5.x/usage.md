<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Recently Read records, per user, the entities each visitor has viewed (full view mode) and exposes that per-user history as Views-driven blocks, so you can show a "recently viewed" list — e.g. recently viewed products or articles — tailored to the current user.

---

The module works automatically: `hook_entity_view()` fires on every full-view render of an entity whose entity type is enabled in a `recently_read_type` config entity, calling `RecentlyReadService::insertEntity()` to record (or bump the timestamp of) a row in the `recently_read` content entity. History is per authenticated user (`user_id`) or per session (`session_id`) for anonymous visitors. You choose which entity types are tracked, and optionally restrict tracking to specific bundles, from the `recently_read_type` collection at `/admin/structure/recently-read` (route `entity.recently_read_type.collection`). A separate settings form at `/admin/config/system/recently-read/config` controls pruning: keep records forever, delete by age (`delete_config: time`, cleaned on cron), or cap the number of records per user (`delete_config: count`, trimmed on insert). On install it ships a config entity for `node` plus a ready-made view (`recently_read_content`) that uses the module's Views **relationship** (`recently_read_relationship`) and a boolean **filter** (`recently_read_user_filter`) to join content to the current user's history. To surface a history list you place that view's block, or build your own view adding the "Recently read" relationship (check "Require this relationship") scoped to the current user. Requires only the core Views module; no permissions of its own.

---

- Show a "Recently viewed products" block on a Drupal Commerce store per shopper.
- Display "Recently read articles" to each logged-in reader on a news or blog site.
- Track which nodes a user has opened and list the most recent first.
- Keep a per-session recently-viewed list for anonymous visitors (no login required).
- Cap each user's history to the last N records to bound table growth.
- Automatically prune history older than a configured age on cron.
- Enable tracking for a custom entity type (e.g. a "recipe" or "course" entity).
- Restrict tracking to specific content-type bundles (e.g. only "product" nodes).
- Build a custom view of recently read content with the "Recently read" relationship.
- Filter a view to only the current user's recently read items via the boolean filter.
- Offer users a "continue where you left off" navigation aid.
- Feed a personalized sidebar of last-viewed content on any page.
- Drive "recently viewed" recommendations without a full recommender engine.
- Record reading history for entities across taxonomy terms, users, or media types.
- Reset a user's history programmatically by deleting their `recently_read` records.
- Remove a single entity from history when it is deleted or unpublished.
- Reuse the shipped `recently_read_content` view as a starting template.
- Expose recently read counts or lists to other Views displays and formats.
- Provide editors a per-user audit of what content an account has viewed.
- Personalize a dashboard with each user's most recently opened items.
- Support e-commerce "you looked at these" merchandising blocks.
