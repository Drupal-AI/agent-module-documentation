<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme Selector — agent index

Change the **page theme via a query-string parameter** (`?theme=…`) from a **configured** list of
selectable themes (theme previews / A/B / user choice). Config at the `theme_selector` collection; provides
permissions. Version **2.0.0**. Core `^10||^11`.

**Security:** switching is bounded to admin-configured selectable themes (a query param can't force an
arbitrary theme) — verify only intended themes are selectable. Theming/negotiation; changes presentation,
not content/access.
