<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `visitors.permissions.yml`:

- **`access visitors`** — view the analytics reports under `/visitors` (hits, top pages, hosts,
  referrers, devices, geo reports, …). This is the main "see the stats" permission.
- **`opt-out of visitors tracking`** — lets a user decide whether their own actions are tracked
  (tracking opt-in/out).
- **`view visitors counter`** — see the per-content hit counter (the "N views" display produced
  by `visitors.counter` when `counter.enabled` is on).

Report/rebuild admin routes additionally use core's `administer site configuration`.
