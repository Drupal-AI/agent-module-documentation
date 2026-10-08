<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Link Area — agent index

Adds one Views **area** handler (`linkarea`) that renders a configurable internal/external
link in a display's Header, Footer, or No Results region. No global config page
(`configure` null), no permissions, no Drush. Config schema covers all handler options.
Depends on `views`.

- **Adding the Link area, every option, tokens, access handling, and the XSS
  responsibility of the HTML-accepting options** → [configure/link-area.md](configure/link-area.md)

Key facts:
- Plugin `Drupal\views_linkarea\Plugin\views\area\Link` extends `TokenizeAreaPluginBase`;
  registered via `hook_views_data()` as `views.linkarea` (Global category, "Link").
- Routed URLs are access-checked (`access_manager->checkNamedRoute`); denied → optional
  `access_denied_text` (filtered `xss_admin`).
- `rewrite_output` / `prefix` / `suffix` accept admin HTML — this is by-design admin markup,
  not a vulnerability, but the configurer owns output safety.
