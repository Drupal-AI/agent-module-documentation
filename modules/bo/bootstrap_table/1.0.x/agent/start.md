<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Bootstrap table — agent index

A single Views **style plugin** (`bootstraptable`, class `BootstrapTable` extending core Views
`Table`) that renders fields as a bootstrap-table grid. No config UI route (`configure` null) —
you configure it inside a view display's *Format* options. No permissions, services or Drush.
Depends on core `views`. Provides a config schema (`views.view.bootstraptable`).

- **Selecting the style, every option group and what each maps to as a `data-*` attribute,
  library/CDN details, VBO integration, footer sums** →
  [configure/views-style.md](configure/views-style.md)

Key facts:
- Plugin id `bootstraptable`; theme hook `views_view_bootstraptable`
  (`bootstrap_table.theme.inc` → `template_preprocess_views_view_bootstraptable`).
- Options live in the view config, not in a global settings object; schema key
  `views.view.bootstraptable`.
- bootstrap-table 1.27.0 JS/CSS load as **external CDN assets** from `cdn.jsdelivr.net`
  (see `bootstrap_table.libraries.yml`); each extension is its own sub-library attached
  on demand.
