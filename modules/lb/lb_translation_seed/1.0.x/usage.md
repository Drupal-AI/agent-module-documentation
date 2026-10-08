<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LB Translation Seed initializes a new translation's layout from a source translation.

---

Layout Builder Translation Seed seeds the Layout Builder layout of a newly created translation from a configured source translation — so when an editor creates a translation, it starts pre-populated with the source language's layout (via layout_builder_at) rather than blank. It complements per-translation layouts.

Permissions cover administration (`administer lb translation seed`) and reseeding (`reseed layout from source translation`). Depends on core `layout_builder`, `content_translation`, `language`, and `layout_builder_at`; requires Drupal 11.1+.

---

- Seed a translation's layout from a source.
- Pre-populate new translations.
- Avoid blank translation layouts.
- Use layout_builder_at.
- Complement per-translation layouts.
- Gate admin with `administer lb translation seed`.
- Gate reseeding with `reseed layout from source translation`.
- Depend on core `layout_builder` and `content_translation`.
- Depend on core `language` and `layout_builder_at`.
- Require Drupal 11.1+.
- Initialize translation layouts.
- Speed up layout translation.
- Support multilingual Layout Builder
- Reseed on demand.
- Configure the source.
- Aid translators.
- Start from the source layout.
- Handle translated layouts
