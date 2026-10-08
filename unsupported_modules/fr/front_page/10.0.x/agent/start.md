# Front Page (front_page) — agent index

Project `front`, module machine name **`front_page`**. Redirects visitors from the site
front page to a **per-role** path (lowest weight wins), and rewrites `<front>` links to a
configured Home path. Pure config + a request subscriber; no fields, plugins, or Drush.

- **All settings, the config object/keys, the two admin forms, and how the redirect &
  Home-link rewrite work** → [configure/settings.md](configure/settings.md)

Key facts: everything is in the `front_page.settings` config object — `enabled` (master
switch), `disable_for_administrators`, `home_link_path`, and `roles.<role_id>` =
`{enabled, weight, path}`. Settings form: route `front_page.settings`
(`/admin/config/system/front/settings`); Home links form: route `front_page.home_links`
(`/admin/config/system/front/home-links`). Permission: `administer front page`. The redirect
is a runtime `RedirectResponse` from `FrontPageSubscriber` (front page only); `<front>`
rewriting is done by the `FrontPagePathProcessor` outbound path processor.
