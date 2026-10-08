<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Limit sets a minimum and/or maximum number of components (blocks) that a Layout Builder section, or a region within a section, may contain.

---

Layout Builder lets editors add any number of blocks to a section or region, which can leave pages sparse (an empty hero region) or overloaded (twenty blocks in a sidebar). Layout Builder Limit adds a "Limit settings" area to the section-configuration form where an administrator picks a scope — None, Region, or Section — and, for that scope, enables a minimum and/or maximum count. The choices are saved as a third-party setting on the layout section. During editing the module shows warning/error messages in the affected section or region, and once a maximum is reached it removes the "Add block" link and drops those blocks from the plugin chooser. Because it also validates the layout on save, an editor cannot persist a layout that violates the configured minimum or maximum. Two permissions gate who may set these limits — one for the default (template) display and one for per-entity overrides. It pairs naturally with Layout Builder Restrictions (which block/layout types are allowed) and Layout Builder Lock (which sections are editable).

---

- Require at least one block in a hero or content region so it is never empty.
- Cap a sidebar region at a fixed number of promo blocks.
- Limit an entire section to a maximum number of components.
- Force a section to always contain a minimum number of components.
- Apply different min/max counts to each region of a multi-column layout.
- Keep a call-to-action region to exactly one block by setting min and max to 1.
- Prevent editors from overloading a landing-page section with too many blocks.
- Stop empty regions from shipping to production by enforcing a minimum.
- Show editors an inline warning when a region is below its required minimum.
- Show editors an inline error when a section exceeds its maximum.
- Automatically hide the "Add block" link once a region hits its cap.
- Remove maxed-out regions/sections from the block chooser so editors can't add more.
- Block saving a layout that is under the minimum or over the maximum.
- Delegate limit configuration on default displays to one editor role.
- Delegate limit configuration on layout overrides to a different role.
- Standardize how many components appear across all instances of a content type.
- Combine with Layout Builder Restrictions to control both which and how many blocks.
- Combine with Layout Builder Lock to control which sections editors may touch.
- Enforce editorial guardrails without writing custom validation code.
- Configure limits per section directly in the Layout Builder UI, no separate admin page.
- Set limits on default templates that flow down to entity overrides.
- Turn limiting off for a section by choosing the "None" scope.
- Govern page-building consistency for large editorial teams.
