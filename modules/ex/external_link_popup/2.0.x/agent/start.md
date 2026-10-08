<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# External Link Pop-up — agent index

Shows a confirmation dialog when a visitor clicks a link leaving the site. Pop-ups are
`external_link_popup` **config entities**; global options live in `external_link_popup.settings`.

- **Pop-up entity fields, global settings, routes, permission, domain matching** →
  [configure/popups.md](configure/popups.md)
- **Front-end behavior: drupalSettings, exclude/force a link, JS events, theming classes** →
  [api/behavior-theming.md](api/behavior-theming.md)

Key facts:
- `configure` route: `external_link_popup.settings` (`/admin/config/content/external_link_popup/settings`).
  Pop-up list/CRUD at `/admin/config/content/external_link_popup`.
- Config entity `external_link_popup` fields: `id`, `name`, `status`, `weight`, `close`,
  `title`, `body` (text_format), `labelyes`, `labelno`, `domains`, `new_tab`.
- Global `external_link_popup.settings`: `whitelist` (newline domains), `show_admin` (bool),
  `width` (`{value, units}`).
- Domain matching: newline-separated; `domain.com` matches `*.domain.com`; `*` = all;
  **weight order, first match wins**.
- Exclude a link: CSS class `external-link-popup-disabled`. Force a pop-up:
  `data-external-link-popup-id="<machine name>"` (works for local links too).
- Permission: `administer external link popup`. No Drush. Depends on core `filter`.
