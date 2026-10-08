<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views User Term Filter adds a non-exposed Views filter (`current_user_tid`) that matches content to the current user: it shows only rows whose configured taxonomy-term reference field equals a term referenced from a chosen field on the logged-in user's account.
---
The filter (`CurrentUserTid`) lets the site builder pick a user profile term-reference field and a content term-reference field. At query time it loads the current user, reads the target term id from the user field, and adds a `WHERE <entity>__<content_field>.<field>_target_id = <user_term_id>` condition (joining the field table via `ensureTable`). It cannot be exposed to visitors (`canExpose()` returns FALSE) and short-circuits for anonymous users; an "empty" option controls whether an empty user value shows all results or none. Correct per-user caching is handled by depending on the `user_ref_field_cache_context` module (cache context `user.ref_field:<field>`).

Security posture: this is a query-layer Views plugin with no routes, permissions, controllers or endpoints. Field machine names come from admin-configured Views options (select lists limited to real entity-reference fields) and are additionally passed through `Xss::filterAdmin()`; the term id used in the condition is fetched from the loaded user entity and bound as a query argument via `addWhere()` (parameterized, not string-concatenated SQL). Typical setup: add a taxonomy term-reference field to users and to the content type, then add this filter to a View and map the two fields.
---
- Show only content tagged with the current user's preferred category.
- Personalize a view of articles by the user's interest term.
- Filter a listing to the department the logged-in user belongs to.
- Restrict a view to content matching a user's region term.
- Map a user profile term field to a content term field in a View.
- Hide all results when the user has no term set (configurable).
- Show all results when the user has no term set (configurable).
- Exclude anonymous users from personalized results automatically.
- Add per-user "my topics" content feeds.
- Drive a dashboard block from the user's assigned taxonomy term.
- Build role-independent, term-based content targeting.
- Combine with other Views filters for narrowed personalization.
- Keep the filter non-exposed so visitors can't change it.
- Rely on user.ref_field cache context for correct per-user caching.
- Match a user's "team" term to team-tagged nodes.
- Surface location-specific content by a user's location term.
- Populate a "recommended for you" view without custom code.
- Filter media or any entity view by a user term field.
- Use admin-selected fields validated via Xss::filterAdmin.
