<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views User Term Filter (views_user_term_filter) — agent index

**Non-exposed Views filter that shows only content whose term-reference field matches a term referenced on the current user's profile.**

- **Version:** 1.0.x
- **Core:** ^8.8 || ^9 || ^10 || ^11
- **Dependencies:** views, user_ref_field_cache_context
- **Filter plugin:** `current_user_tid` → `CurrentUserTid` (`src/Plugin/views/filter/CurrentUserTid.php`); registered via `hook_views_data`
- **Behaviour:** `canExpose()` = FALSE; skips anonymous; `empty` option = show-all-vs-none when user has no value
- **Cache:** context `user.ref_field:<field>` (from user_ref_field_cache_context)
- **Routes/permissions:** none.

**Security:** Query-layer plugin only — no routes/permissions/endpoints. Field names come from admin Views config (select lists of real reference fields) and pass `Xss::filterAdmin()`; the term id is read from the loaded user entity and bound via `addWhere()` (parameterized, no SQL concatenation). No request-facing attack surface.

See [configure/filter.md](configure/filter.md)
