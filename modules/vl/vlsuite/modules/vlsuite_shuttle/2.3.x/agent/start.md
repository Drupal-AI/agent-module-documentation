<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Shuttle (vlsuite_shuttle) — agent index

Submodule of **vlsuite**. **Setup helper** — installs and configures the suite's base for a custom
build. Version **2.3.3**. Core `^10.3 || ^11`.
Enables `vlsuite_media`, `_block`, `_layout`, `_layout_builder`, `_utility_classes`, `_icon_font`,
`_layout_tabs`, `_block_headings_menu`.

The project's own description recommends it "to optimize initial setup time" — i.e. **do not
assemble a 16-submodule suite by hand**; enabled in the wrong order or with a piece missing, the
symptoms do not point at the cause.

**Counterpart to `vlsuite_demo`:** shuttle installs *configuration* to start building; demo
installs example *content* to evaluate. A project usually wants shuttle, and demo only briefly.

**Check what it configured afterwards** — layout restrictions, enabled utility classes, text
formats become the site's assumptions.