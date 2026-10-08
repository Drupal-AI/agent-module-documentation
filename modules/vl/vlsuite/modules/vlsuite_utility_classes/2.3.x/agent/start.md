<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Utility Classes (vlsuite_utility_classes) — agent index

Submodule of **vlsuite**. Per-instance **utility classes** for blocks, sections and layouts.
Version **2.3.3**. Core `^10.3 || ^11`. Depends on `vlsuite`, `vlsuite_icon_font`.

**Nearly every other VLSuite submodule depends on this** — that is how central per-instance
adjustment is to the suite.

The compromise it embodies: editors need some control over appearance, arbitrary CSS kills a design
system. A fixed vocabulary defined by the theme, offered as options, applied per instance.

**Governance point:** a short list is a design system, a long one is inline styles with extra
steps. The list only grows unless someone prunes it.