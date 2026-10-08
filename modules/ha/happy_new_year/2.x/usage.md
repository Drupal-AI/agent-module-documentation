<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Happy New Year! adds site-wide festive decoration — an animated top garland and/or falling snow — attached to every non-admin page, optionally only during a configurable December–January date window.

---

The module ships no entities, blocks, services or permissions: it is a single admin settings form (`HnySettingsForm`, route `happy_new_year.happy_new_year_admin_settings` at `/admin/config/media/happy_new_year`, gated by the core `administer site configuration` permission) plus a `hook_page_attachments()` implementation in `happy_new_year.module`. On every page render that is **not** an admin route, the hook reads the `happy_new_year.settings` config object and, when the garland and/or snow feature is enabled, attaches the matching asset libraries and passes the relevant options through `drupalSettings`. The garland is a CSS-sprite strip (`css/garland.css` + `js/garland.js`) that jQuery prepends as a `#garland` div and animates by stepping its background position; it can be positioned `fixed`/`absolute` and auto-offset below the Drupal core toolbar, a Bootstrap `navbar-fixed-top`, or a custom top margin. The snow is the third-party **Snowstorm** library (`js/snow.js` sets `snowStorm.snowColor` from the configured color); Snowstorm can be loaded minified or not, and from the jsDelivr CDN or a local `/libraries/snowstorm/` path (four library variants: `snowstorm`, `snowstorm-min`, `snowstorm-cdn`, `snowstorm-min-cdn`). An optional "working period" restricts the effect to between a chosen December start day and a chosen January end day (`_happy_new_year_isholidaytime()` compares the current `date('m')`/`date('d')`); with the period disabled the decoration runs year-round. Configuration is a flat set of keys in `happy_new_year.settings` (defaults in `config/install/happy_new_year.settings.yml`), edited through the color-picker-equipped settings form; `hook_update_8102` sets CDN loading on by default.

---

- Sprinkle animated falling snow across the whole front end during the holidays.
- Hang an animated garland strip along the top of every page.
- Enable garland and snow together for a full New Year / Christmas atmosphere.
- Restrict the decoration to a date window (e.g. Dec 20 – Jan 7) via the "working period".
- Run the decoration year-round by leaving the working period disabled.
- Pick a custom snow color with the built-in Farbtastic color wheel (useful on white/light themes where white snow is invisible).
- Enter a snow color directly as a hex code (`#RRGGBB`) instead of using the wheel.
- Keep the garland pinned to the viewport with the "Top-Fixed garland" option.
- Auto-drop the garland below the Drupal core admin toolbar so it does not hide behind it.
- Auto-drop the garland below a Bootstrap `navbar-fixed-top` so it does not overlap the menu.
- Set a custom top margin (in px) for the garland to fine-tune its vertical position.
- Load the Snowstorm snow library from the jsDelivr CDN to avoid hosting it locally.
- Serve Snowstorm from a local `/libraries/snowstorm/` directory for CDN-free / offline sites.
- Use minified Snowstorm assets in production for a smaller payload.
- Leave the effect off on admin routes automatically (the back office is never decorated).
- Enable seasonal branding without writing any theme code or custom JS.
- Toggle the whole effect on or off from one settings page at `/admin/config/media/happy_new_year`.
- Reset the module's configuration cleanly (the `happy_new_year_update_8100` update deletes stale settings).
- Provide a lightweight, dependency-free holiday theme for a marketing or campaign period.
- Combine with a scheduled config deployment to switch decoration on/off around New Year automatically.
