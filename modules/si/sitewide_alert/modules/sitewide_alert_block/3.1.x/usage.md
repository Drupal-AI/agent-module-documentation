<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of Sitewide Alert. Provides a "Sitewide Alert" block (plugin id `sitewide_alert_block`) so alerts render inside a themed region or Layout Builder section instead of being force-injected at the very top of every page.

---

`sitewide_alert_block` ships a single Block plugin, `SitewideAlertBlock` (id `sitewide_alert_block`, admin label "Sitewide Alert"). Enabling the submodule lets a site builder place that block in any theme region via Block layout (`/admin/structure/block`) or drop it into a Layout Builder layout, giving control over exactly where alerts appear rather than the module's default top-of-page injection. It depends on the parent `sitewide_alert` module and reuses the same alert entities, styles, dismissal, and scheduling — only the placement changes. Useful when the default fixed banner conflicts with a theme's header or when alerts should live within page content.

---

- Place site alerts in a specific theme region (e.g. a header or sidebar) instead of pinned to the page top.
- Add alerts to a Layout Builder layout as a block.
- Control alert position per theme via Block layout configuration.
- Apply block visibility conditions (pages, roles, content types) to where alerts appear.
- Integrate alert banners into a custom header component.
- Keep the alert within the normal page flow rather than a fixed overlay.
- Use core block caching/placement for the alert region.
- Show alerts only on pages where the block region is rendered.
- Combine with theme templates to fully restyle the alert container.
- Provide a builder-friendly alternative to the default automatic top-of-page banner.
- Move alerts below a site's cookie banner or navigation bar.
- Reuse all parent alert entities (styles, scheduling, dismissible) unchanged, only relocating them.
- Support multiple placements by embedding the block in different layouts.
- Let editors preview alert placement inside Layout Builder.
- Disable the default injection behavior in favor of explicit block placement.
