Rocketship-flavoured configuration and theming layer that adapts the EU Cookie Compliance consent popup (and Cookie Content Blocker) to the Rocketship distribution's markup, buttons, CSS and accessibility.

---

`eu_cookie_compliance_rocketship` is a glue/theming module for the Rocketship Drupal distribution. It depends on `eu_cookie_compliance`, `cookie_content_blocker` and `eu_cookie_compliance_gtm`, and re-shapes the consent experience without providing its own consent engine. On install it ships opinionated defaults into `eu_cookie_compliance.settings` and four cookie categories (necessary / functional / analytics / marketing, with German, French and Dutch translations). It overrides the `eu_cookie_compliance_popup_info` theme with its own Twig template, injects Rocketship-styled "Accept all / Manage cookies / Save preferences / Accept necessary only" buttons plus an optional in-popup language switcher, attaches its own CSS/JS libraries, wires keyboard-accessibility and a "reopen popup" link, and swaps in three Cookie-Content-Blocker-aware field formatters (iframe, iframe-only, video_embed_field) and two text-format filters that auto-wrap external iframes/embeds. A single admin settings form at `/admin/config/system/eu-cookie-compliance/rocketship` (permission `administer rocketship eucc settings`) controls the button labels, the language switcher and whether the module's structural/extra CSS loads.

---

- Give a Rocketship site a consistent, on-brand cookie-consent popup without hand-editing EU Cookie Compliance's markup.
- Ship a working GDPR consent baseline (four cookie categories + translations) as installable default config.
- Rename the consent buttons per site via the settings form (Accept all cookies / Manage cookies / Save preferences / Accept necessary only).
- Add an "Accept necessary only" (minimal) button that unchecks every non-required category and saves preferences.
- Show an in-popup language switcher so visitors can read the consent text in their language.
- Toggle the module's basic structural CSS on or off (`css_structural`) when the theme already styles the popup.
- Toggle the extra design CSS on or off (`css_extra`) for sites that want only minimal styling.
- Provide keyboard and screen-reader accessibility for the consent modal (focus trapping, aria-hidden background, space-to-toggle categories).
- Let editors place a "reopen cookie settings" trigger anywhere using `a.eucc-open`, `a[href$="#eucc-open"]` or `button[data-eucc-open]`.
- Re-open the consent popup when Cookie Content Blocker fires its `cookieContentBlockerChangeConsent` event on a blocked embed.
- Block third-party iframes rendered by the `iframe` module's field formatters until consent is given (CookieBlockedIframe / CookieBlockedIframeOnly).
- Whitelist specific hostnames on the iframe-only formatter so trusted embeds are never blocked.
- Block Video Embed Field videos (YouTube/Vimeo/etc.) behind consent (CookieBlockedVideo).
- Auto-wrap `<iframe>` tags inside rich-text fields in `<cookiecontentblocker>` via the "autowrap iframes" text filter.
- Auto-wrap an entire rich-text field when it contains any external `src` via the "autowrap entire field if external src found" text filter.
- Vary the consent cookie id per route/parameters through `hook_eu_cookie_compliance_cid_alter`.
- Integrate consent state with Google Tag Manager via the `eu_cookie_compliance_gtm` dependency (category `gtm_data` third-party settings).
- Deploy the whole consent configuration as code so staging and production stay in sync.
- Localise the popup and category descriptions out of the box in EN/DE/FR/NL.
- Uninstall cleanly, removing the cookie-category config it created.
