Christmas Snow adds a decorative animated snowfall (Scott Schiller's Snowstorm library) to the front end of a Drupal site, configurable from a single admin settings form.

---

Enabling the module and turning on "Enable snow" at `/admin/config/christmas_snow/cs_settings` makes snowflakes fall on every non-admin page. The `christmas_snow_page_attachments()` hook (in `Hook\ChristmasSnowHooks`) attaches the `christmas_snow/snow` glue library plus the Snowstorm library (`snowstorm` or `snowstorm-min`) and passes the configured options to the browser as `drupalSettings.christmas_snow.*`. All behaviour is driven by the `christmas_snow.settings` config object: an on/off flag, max flake count, hex snow colour (with a Farbtastic colour picker on the form), floor height, and toggles for follow-mouse, melt, stick, twinkle, flake character and animation performance, plus a "use minified library" switch. Snow is suppressed on admin routes (checked via `router.admin_context`) and the output carries a `config:christmas_snow.settings` cache tag. Configuration is gated behind core's `administer site configuration` permission (the module defines no permissions of its own). The optional `christmas_snow_schedule` submodule adds date-range scheduling so snow auto-enables/disables via cron. Note: the Snowstorm library is declared as an **external asset loaded from a CDN** (`cdn.rawgit.com`, now a defunct host) rather than bundled, so on many sites the effect will not load until you point the library at a working/self-hosted Snowstorm copy.

---

- Add a festive snowfall effect to a site's public pages for the holiday season.
- Turn the snow effect on or off from one admin toggle without code.
- Choose snowfall density from "a flurry" up to a "nor'easter" (max flakes 16–512).
- Set the snow colour with a hex value and an interactive colour picker.
- Limit how deep snow piles at the bottom of the viewport (shallow/medium/thick).
- Make flakes drift with the mouse position for a wind effect.
- Enable a melt/fade-out effect on recycled flakes.
- Let snow stick to the bottom of the window, or never settle.
- Add a twinkle/flicker effect to falling flakes.
- Switch the flake glyph between bullet (•) and middot (·).
- Tune animation frame interval to trade smoothness against CPU use.
- Serve the minified Snowstorm library for slightly lighter payload.
- Keep the effect off admin pages automatically (only front-end routes get snow).
- Add seasonal flair to a marketing or campaign landing page.
- Give an intranet or club site a holiday theme without touching the theme layer.
- Schedule snow to appear only within a date range using the `christmas_snow_schedule` submodule.
- Auto-disable the effect after the holidays via the scheduler and cron.
- Cache-tag the snow output so config changes clear cached pages correctly.
- Point the Snowstorm asset library at a self-hosted copy to work around the dead CDN host.
- Demonstrate `hook_page_attachments` + `drupalSettings` wiring as a small code example.
