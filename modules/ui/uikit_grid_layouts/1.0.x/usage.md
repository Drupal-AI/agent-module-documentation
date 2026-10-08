<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UIkit Grid Layouts adds one- to four-column UIkit 3 grid layout plugins usable in Layout Builder and other Layout API consumers.

---

UIkit Grid Layouts supplies Layout plugins backed by a single `UikitGridLayoutsClass` (extending core `LayoutDefault` and implementing `PluginFormInterface`). Each layout exposes a configuration form for UIkit section background (default/muted/primary/secondary), an optional uploaded background image (saved as a permanent managed file with a generated absolute URL), section padding, container width, grid gutter size, optional divider, card wrapping, column position/alignment and per-template column-size ratios (e.g. 25/75, 33/66, 50/50 for two columns). It targets sites themed with UIkit 3 and integrates with Layout Builder / Display Suite via the Layout API.

---

- Add UIkit 3 grid layouts to Layout Builder.
- Choose a one, two, three or four column layout.
- Pick column-size ratios like 25/75 or 33/66.
- Set a UIkit section background style.
- Upload a section background image.
- Control section padding (xsmall to xlarge).
- Set the container width.
- Choose the grid gutter size.
- Add a divider between grid cells.
- Wrap layout content in UIkit cards.
- Align columns left, center or right.
- Reuse one layout class for all grid variants.
- Integrate with Display Suite / Layout API.
- Style content sections without hand-written CSS.
- Store background image as a permanent file with usage.
