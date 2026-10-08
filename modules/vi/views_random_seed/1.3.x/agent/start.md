<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views random seed — agent index

Adds a **"Random seed"** Views sort that orders rows randomly with a **persisted seed**, so a
paged random listing stays consistent across pages (fixes core's Global: Random breaking the
pager). Requires the core **Views** module. **No configure route** (`configure: null`), no
settings form, no permissions, no Drush. Configured inside the Views UI.

- **Add the sort to a view and tune its options (reset interval, per-user, reuse)** →
  [configure/sort.md](configure/sort.md)
- **The `SeedCalculator` service and how the seed is stored/reset** →
  [api/seed-calculator.md](api/seed-calculator.md)

Key facts:

- Sort plugin id **`views_random_seed_random`** (`@ViewsSort`), exposed as the **`random_seed`**
  field on the `views` table ("Random seed").
- Query: `RAND(<seed>)` on MySQL/MariaDB; `setseed()` + `RANDOM()` on PostgreSQL.
- Options: `user_seed_type` (`same_per_user`|`diff_per_user`), `anonymous_session` (bool),
  `reset_seed_int` (`-1` never, `0` custom, `3600`, `28800`, `86400`), `reset_seed_custom`
  (seconds), `reuse_seed` (`<viewid>-<displayid>`).
- Seed stored by service **`views_random_seed.seed_calculator`** in key-value collection
  `views_random_seed` (or the session for `diff_per_user`).
