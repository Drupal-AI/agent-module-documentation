<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hanging Conjunctions Filter (hanging_conjunctions_filter) — agent index

**Text-format filter that inserts non-breaking spaces after one-letter conjunctions/prepositions to prevent line-end orphans (Polish typography).**

- **Version:** 8.x-1.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Dependencies:** drupal:filter
- **Filter plugin:** `hanging_conjunctions_filter` (TYPE_TRANSFORM_IRREVERSIBLE, weight 50)
- **Extension point:** `hook_hanging_conjunction_filter_terms_alter(&$terms)` — add terms keyed by langcode
- **Config:** none; enabled per text format at `/admin/config/content/formats`
- **Security:** No routes, permissions, services, or network I/O. Pure string transform that splits on tags (never edits tags/attributes) and skips a/script/style/code/pre. No user-facing attack surface.

See [hooks/terms-alter.md](hooks/terms-alter.md)