<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# All in One Accessibility — agent index

Embeds the hosted **Skynet Technologies** "All in One Accessibility" JavaScript widget
(accessibility toolbar) on every page. The accessibility features come from the **remote**
widget; this module just configures and injects it. No config schema, plugins, or Drush.

- **Settings config object + the form (token, colour, position, size…)** →
  [configure/settings.md](configure/settings.md)
- **How the external widget script is injected on every page** →
  [api/embedding.md](api/embedding.md)

Key facts:
- Config object **`all_in_one_accessibility.userid.settings`** (created on first save; no
  `config/install` default). Key fields: `userid` (licence token), `colorcode`, `position`
  (default `bottom_right`), `widget_size` (`regularsize`), `aioa_icon_type` (`aioa-icon-type-1`),
  `aioa_icon_size` (`aioa-default-icon`), `statement_link`, custom size/position flags,
  `nofreeversion`.
- Settings UI `/admin/config/development/all-in-one-accessibility/ada_compliance`
  (route `all_in_one_accessibility.admin.allinoneaccessiblity`, permission
  **`all_in_one_accessibility_settings`**).
- The widget is a `<script>` (DOM id `aioa-adawidget`) loaded from
  `skynettechnologies.com`, with `userid`/`colorcode`/`position` in the query string.
