<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Mirador Block places a Mirador IIIF viewer as a block, so it can go wherever block layout allows.

---

Where `wisski_mirador` provides the integration, this makes it placeable. A block can go in a region, on selected pages, restricted by role — so a viewer can appear on record pages, on a dedicated comparison page, or in a sidebar, without templating.

The module directory is `wisski_mirador_block` but the module it ships is named **`blockmirador`**, which is worth knowing because `drush en wisski_mirador_block` will not work. That kind of mismatch between directory and machine name is a recurring source of confusion in this project's family.

The placement decision worth thinking about is context. A IIIF viewer is a heavy component — it loads a substantial JavaScript application — so placing it site-wide costs every page. Restricting it to the pages where images are actually examined is both a performance and a usability decision.

---

- Place a Mirador viewer as a block.
- Show a viewer on record pages only.
- Put a viewer on a dedicated comparison page.
- Restrict the viewer by role.
- Place a viewer in a sidebar region.
- Avoid templating to position a viewer.
- Enable the module by its real name.
- Avoid loading the viewer site-wide.
- Limit a heavy component to relevant pages.
- Improve page performance by scoping the viewer.
- Configure viewer options per placement.
- Combine with block visibility conditions.
- Audit where the viewer is loaded.
- Understand the directory and module name mismatch.
- Document this module's role for the project.
- Review its status during an audit.
