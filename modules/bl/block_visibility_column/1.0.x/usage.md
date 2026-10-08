<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Block Visibility Column adds a "Visibility" column to the Block Layout page so each block's visibility conditions are readable inline.

---

Block Visibility Column adds a "Visibility" column to the Block Layout administration page
(`/admin/structure/block`), so administrators can see each placed block's visibility conditions —
pages, roles, languages, content/term bundles, and Token Conditions' token matcher — directly in the
block list instead of opening every block's configuration form. It works by swapping core Block's list
builder for a subclass that renders one extra column; it adds no routes, permissions, or settings and
depends only on core Block. It is a read-only administration convenience that surfaces existing
configuration and never changes block visibility or access. No configuration is needed beyond enabling
the module (clear caches afterward).

---

- See every block's visibility conditions at a glance on the Block Layout page.
- Audit block placement on sites with many blocks and complex visibility rules.
- Avoid opening each block's configuration form just to check where it shows.
- View "restrict to specific pages" (`request_path`) path lists per block.
- View role-based visibility (`user_role`) conditions inline.
- View language visibility (`language`) conditions inline.
- View content-type and taxonomy-term bundle conditions (`entity_bundle:node`, `entity_bundle:taxonomy_term`).
- Read Token Conditions' `token_matcher` settings (token, value, regex, empty-check) in the list.
- Distinguish "match" vs. "negated" conditions (shown as `=` versus `<>`).
- Spot blocks that use an unsupported/custom condition plugin (shown as "is not supported").
- Review block visibility during content or theme audits.
- Verify visibility changes quickly after editing many blocks.
- Onboard new admins by making block targeting visible without deep clicking.
- Catch blocks accidentally shown site-wide (no conditions listed).
- Catch conflicting or redundant visibility rules across regions.
- Document a site's block layout by screenshotting the annotated list.
- Compare visibility settings across similar blocks side by side.
- Support Drupal 9, 10, and 11 with the same module.
- Keep block behavior unchanged — the column only displays existing settings.
- Use with no configuration: enable, clear caches, done.
