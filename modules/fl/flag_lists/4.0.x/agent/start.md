<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flag Lists (flag_lists) — agent index

User-created **named collections** of flagged content, on top of **Flag**. Version — **pin `4.0.3`**.
Core `^9 || ^10 || ^11`. Depends on `flag`, core `views`. Submodule `flag_lists_actions`.
Settings at `/admin/config/flag_lists`; templates at `/admin/structure/flag_lists/flag_for_list`.

A flag type is a **template**; users make many lists (flagging collections) from it and flag content
into any. Collections are revisioned entities — full permission set (create / view own / view all /
edit / revision view-revert-delete).

**Install note:** release **4.0.4** has a malformed require manifest (name concatenated with
constraint) that breaks Composer with a "Malformed input to a URL" curl error. **4.0.3 installs
cleanly — pin it.** See workflow.md "curl error can be a permanent packaging bug".

**Good:** action routes carry `_csrf_token: 'TRUE'` and `_flag_access`/`_unflag_access` — CSRF on
state-changing links done right.