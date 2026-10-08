<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Filter Select (views_filter_select) — agent index

Exposes Views fields as a **select-list** exposed filter instead of a text input.
Version **dev-1.0.x**. Core `^9 || ^10 || ^11`. Depends on core `views`.
No routes/permissions — a filter option inside Views config.

Right control when the value set is small and known (status, category, orientation) — a dropdown of
valid values instead of a typo-prone text box. Dependency behind `media_orientation`'s filter.
Confirm the offered value set is the expected one.