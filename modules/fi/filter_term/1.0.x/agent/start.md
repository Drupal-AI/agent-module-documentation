<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter Term (filter_term) — agent index

**Adds an admin page (`/allcontent`) and a filter form to find and list nodes by vocabulary, term, content type, title and author.**

- **Version:** 1.0.x
- **Core:** `^9.4 || ^10`
- **Dependencies:** node, taxonomy
- **Routes:** `filter_term.allcontent` → `/allcontent` (perm: `access content`); `filter_term.vocab` → `/admin/config/filter_term/vocab` (role: `authenticated`)
- **Permission:** `Filter vocabulary and terms`
- **Key classes:** `Controller\DefaultController::content` (builds the listing), `Form\VocabForm` (filter form).

**Security:** `/allcontent` is gated only by `access content` and queries the node tables directly with NO node-access check, so it lists unpublished node titles/status to any content-viewing user. Queries themselves use parameterised DB-API conditions (no SQL concatenation). See [configure/filter-term.md](configure/filter-term.md).
