<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragon Gin bundles UX refinements for the Gin admin theme and Layout Builder on Paragon-based sites, aimed at making the authoring experience cleaner.

---


It adds a Gin theme setting to toggle between icon and list views of Layout Builder blocks, restyles section edit links, shows a tooltip with the block type on hover, refines the navigation top bar with "View / Edit Layout Builder / Version History" shortcuts, and updates inline block titles from a `field_heading` value when present. It also removes the (non-functional) block search bar. The module is theme/CSS/JS and hook driven — no routes, permissions, or services — and depends on Paragon Core, Gin LB, Layout Builder Browser, and the core Navigation/top-bar modules.

Setup: enable alongside Gin, Gin LB, Paragon Core and Layout Builder Browser; adjust the added Gin theme setting as desired.
---
- Improve the Layout Builder authoring UI on Gin.
- Toggle Layout Builder blocks between icon and list view.
- Restyle Layout Builder section edit links.
- Show a tooltip with the block type on hover.
- Add Layout Builder / version-history shortcuts to the top bar.
- Update inline block titles from `field_heading`.
- Remove the broken block search bar.
- Apply consistent admin styling for Paragon sites.
- Configure the view-mode toggle via Gin theme settings.
- Streamline the navigation top bar for editors.
- Pair with Layout Builder Browser Block Library.
- Reduce clutter in the Layout Builder add-block flow.
- Keep block choices scannable as a list.
- Provide quicker access to layout editing.
- Standardize the editing experience across content types.
- Ship purely as theming/JS with no config entities.
