Open ReadSpeaker integrates the commercial [ReadSpeaker](https://www.readspeaker.com/) webReader / Enterprise Highlighting text-to-speech service into Drupal: it loads ReadSpeaker's remote JavaScript, exposes an admin form for the full ReadSpeaker `rsConf` configuration, and provides a "Listen" block that reads a chosen page region aloud. A valid ReadSpeaker customer account is required.

---

The module is configured at `admin/config/services/open-readspeaker` (permission `administer open readspeaker`). The settings form maps a large `open_readspeaker.settings` config object: `customerid`, `cdn_region`, `lang`, `voice`, the tokenized remote `webreader_url`, and the nested `rsConf` structure (general options, per-user default settings, keyboard shortcuts, and UI/tool toggles) — all fully validated via config schema (`FullyValidatable`). `hook_library_info_build()` builds an `open_readspeaker/basic` library that loads the ReadSpeaker script from `webreader_url` after running it through Drupal's token system; the module defines `open-readspeaker:customer-id` and `open-readspeaker:cdn` tokens so the URL/CDN can be templated. The provided `OpenReadspeakerWebreader` block renders a "Listen" button linking to ReadSpeaker's `rsent` endpoint with query parameters (customer id, language, voice, and the configured reading-area id/classes plus the current page URL), attaches the ReadSpeaker library, and publishes `rsConf` to `drupalSettings` (picked up by `js/conf.js` as `window.rsConf`). An optional `CspSubscriber` appends the ReadSpeaker host to the `style-src`/`style-src-elem` directives when the [CSP](https://www.drupal.org/project/csp) module is present. The button markup lives in `open-readspeaker-webreader.html.twig`. Because the loaded script and endpoints are the third-party ReadSpeaker service configured by an admin, treat the `webreader_url`/button URL as trusted admin input (they place a remote script on every page that shows the block).

---

- Add a "Listen" text-to-speech button to pages using the ReadSpeaker webReader block.
- Read a specific page region aloud by setting the reading-area HTML id (e.g. main content).
- Restrict reading to elements matching given CSS classes via the reading-area classes field.
- Configure your ReadSpeaker customer/account id centrally for the whole site.
- Select the ReadSpeaker CDN region closest to your users (EU, NA, Asia, etc.).
- Choose the ReadSpeaker reading language and a specific voice.
- Template the remote script URL with the `open-readspeaker:customer-id` / `:cdn` tokens.
- Enable word/sentence highlighting styles and set highlight colours.
- Set the default reading speed and toggle auto-scroll while reading.
- Customise the highlight-on-selection popup and its close timing.
- Rebind all ReadSpeaker keyboard shortcuts (play, pause, stop, settings, translation, etc.).
- Show or hide individual toolbar tools (settings, enlarge, page mask, download, dictionary, translation…).
- Position the floating control panel (top/bottom, left/right) and set the mobile menu offset.
- Offer on-page translation of content into ReadSpeaker's supported target languages.
- Skip hidden content and switch to POST mode so ReadSpeaker can read password-protected pages.
- Exclude specific HTML attribute values from being read via the ignore-selector list.
- Persist a user's voice/settings in a configurable cookie (name and lifetime).
- Automatically extend a strict Content-Security-Policy to allow ReadSpeaker's host (with the CSP module).
- Provide an accessibility "read aloud" feature to meet WCAG/inclusive-design goals.
- Place the Listen block only on selected content types/pages using standard block visibility.
- Translate the admin-facing configuration via config_translation.
