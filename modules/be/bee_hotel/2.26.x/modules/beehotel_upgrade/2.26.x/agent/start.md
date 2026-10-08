<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bee Hotel Upgrade (beehotel_upgrade) — agent index

**Cross-release upgrade fixes/helpers** for Bee Hotel. Dependency: `bee_hotel`.
Core `^9.4 || ^10 || ^11`.

## What it provides

- `src/Util/Dates.php` — date helper(s) used by upgrade/update routines.
- Packages release-to-release fixes so they don't clutter the core module.

No public routes, permissions or config schema. Enable when an upgrade path calls for it.
No solution subpages.
