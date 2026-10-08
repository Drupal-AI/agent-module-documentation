<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Beta Site - agent index

**Beta Site** adds beta-testing plumbing: a beta alias namespace + toggle block/endpoint. Version **1.0.4** (`1.0.x`). Core `^9 || ^10`.

## Key files
- `src/Routing/BetaSiteRouteSubscriber.php` - dynamic routes.
- `modules/betasite_toggle_block/src/Controller/BetaToggleLinkController.php` - `/beta-link` (access TRUE) JSON alias lookup.
- Submodules: switches, layout_builder, menu_breadcrumb, menu_trail_by_path.

## Notes
- `/beta-link` is anonymous but only reads path aliases; DB query is parameterized (no SQLi). Low sensitivity.