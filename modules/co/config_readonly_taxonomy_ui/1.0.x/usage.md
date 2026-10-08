<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Read-only Taxonomy UI re-enables term reordering under config_readonly's read-only mode.

---

Configuration Read-only Taxonomy UI complements the Configuration Read-only module: when the site is in read-only config mode (which normally blocks config forms), this module still allows reordering taxonomy terms on the term-overview page — a content-adjacent operation that should remain available even when config editing is locked.

It narrowly re-enables one operation under read-only mode; ensure that matches your governance policy. Depends on `config_readonly` and core `taxonomy`; requires Drupal 11.1+.

---

- Reorder taxonomy terms in read-only mode.
- Complement Configuration Read-only.
- Keep term ordering available.
- Allow a content-adjacent operation.
- Respect read-only config locking otherwise.
- Match governance policy.
- Depend on `config_readonly`.
- Depend on core `taxonomy`.
- Require Drupal 11.1+.
- Narrowly scope the exception.
- Support locked-config sites.
- Reorder terms on the overview page.
- Preserve editorial term ordering.
- Avoid unlocking broader config.
- Integrate with read-only mode.
- Support taxonomy management.
- Keep config locked elsewhere.
- Enable safe term reordering.
