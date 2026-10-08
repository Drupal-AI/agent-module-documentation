<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Layout: Tabs (vlsuite_layout_tabs) — agent index

Nested submodule of **vlsuite_layout**. **Tabbed section layout**.
Version **2.3.3**. Core `^10.3 || ^11`. Pulled in by both `vlsuite_shuttle` and `vlsuite_demo` —
part of the baseline.

**The trade to state:** tabs hide content. Anything past the first tab is unseen by most visitors
and historically weighted less by search engines. Important content on tab three is content
nowhere.

**Accessibility requirements are specific and often missed:** arrow keys move between tabs, Tab
moves into the panel, `aria-selected` marks the active tab, each panel is associated with its tab.
A click-only implementation is not accessible — verify rather than assume; this pattern is
frequently shipped as styled divs.