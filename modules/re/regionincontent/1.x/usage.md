<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Region in Content lets you render theme block regions inside a node's content template rather than only in the page template.

---

The module implements `hook_preprocess_node()`: for allowed view modes (currently `full`) it reads a newline-separated list of region machine names from `regionincontent.settings` (`region`), intersects them with the active theme's declared regions, renders those regions (the blocks placed in them) and exposes them as variables on the node so a node template can print them in-body. A settings form at `/admin/config/user-interface/regionincontent` (permission `administer site configuration`) manages the region list.

This is a theming/site-structure helper with a single admin-gated configuration route and no public or mutating endpoints. Because regions are rendered within node content, block visibility and access still apply per block; the module only decides which theme regions become available inside the node render array. Typical setup is placing blocks in a custom region, listing that region's machine name in the settings form, and printing the new variable in your node template (for the `full` view mode).

---

- Render a theme region inside a node's content
- Place blocks that appear within the node body
- List allowed regions in the settings form
- Limit region-in-content to the `full` view mode
- Print region variables in a custom node template
- Reuse existing block placement inside content
- Build in-content sidebars or call-to-action zones
- Keep block access/visibility rules while embedding
- Configure regions at `/admin/config/user-interface/regionincontent`
- Intersect requested regions with the active theme's regions
- Expose rendered regions as node template variables
- Avoid hardcoding block markup in node templates
- Add promotional regions between content and footer
- Support multiple regions via a newline-separated list
- Restrict configuration to site administrators
- Combine with Layout Builder-free theming approaches
- Drive in-content regions from the active theme definition
- Provide editors a consistent in-body block area
- Toggle regions on or off by editing the settings list
- Integrate contributed blocks into node display
