<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Improved Multi Select — agent index

A front-end enhancement that turns `<select multiple>` boxes into a searchable **two-panel
dual list box** (available / selected panels, add/remove/reorder buttons, filter box). No
field type or widget of its own; all behaviour is driven by one config object and attached
JavaScript. The base module has **no permissions of its own** (the settings form is gated by
core's "administer site configuration"), **no Drush**, and **no plugin types**.

- **All settings keys, the config route, how a page is targeted (isall / url / selectors),
  filter modes, button labels** → [configure/settings.md](configure/settings.md)
- **The two alter hooks (`_activated_alter`, `_attached_alter`) for per-page control** →
  [hooks/alter-hooks.md](hooks/alter-hooks.md)
- **Persisting selected order on an entity field** → use the submodule
  `modules/ims_options_widget/` (nested docs), which adds a real field widget.

Key facts: config object `improved_multi_select.settings`; settings form route `ims.settings`
at `/admin/config/user-interface/ims`; library `improved_multi_select/ims` attached in
`hook_page_attachments()`; default targeted selector is `select[multiple]`.
