<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Batch runs migrations in batches with offset tracking for large datasets.

---

Migrate Batch provides batch migration processing with offset tracking — so large migrations can be run in manageable batches (via the Batch API) that resume from where they left off, avoiding timeouts on big source datasets. It's a developer/migration tool.

Administration is gated by `administer migrate batch`. Depends on core `migrate`; requires Drupal 10+.

---

- Run migrations in batches.
- Track processing offset.
- Resume from where it left off.
- Avoid timeouts on large datasets.
- Use the Batch API.
- Gate admin with `administer migrate batch`.
- Depend on core `migrate`.
- Require Drupal 10+.
- Process big migrations.
- Support developer migrations.
- Handle large sources.
- Batch source rows.
- Support resumable migrations
- Manage migration batches
- Aid migration workflows.
- Process incrementally.
- Track progress.
- Run safely at scale
