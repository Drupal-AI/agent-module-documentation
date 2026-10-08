# Configure Open ReadSpeaker (global settings)

Route `open_readspeaker.settings` → **Configuration » Services » Open ReadSpeaker**
(`admin/config/services/open-readspeaker`). Permission: `administer open readspeaker`. Everything
persists in the fully-validatable `open_readspeaker.settings` config object
(`OpenReadSpeakerSettingsForm`). Needs a real ReadSpeaker customer account.

## Top-level keys

| Key | Form field | Notes |
|---|---|---|
| `customerid` | Customer ID | Your ReadSpeaker account id. Required; the block warns if empty. |
| `cdn_region` | CDN | One of `eu, me, af, as, oc, eas, na, sa`. Feeds the `:cdn` token. |
| `lang` | Language | ReadSpeaker reading language (validated against `validLanguageChoices`). |
| `voice` | Voice | Optional named voice (nullable). |
| `webreader_url` | URL | Remote ReadSpeaker JS URL, **tokenized** (default `//cdn-[open-readspeaker:cdn].readspeaker.com/script/[open-readspeaker:customer-id]/webReader/webReader.js?pids=wr`). |

## Tokens (defined by the module)

`hook_token_info()` registers the `open-readspeaker` token type:
- `[open-readspeaker:customer-id]` → `customerid`
- `[open-readspeaker:cdn]` → `cdn_region`

`hook_library_info_build()` runs `webreader_url` through `token.replace()` and registers it as the
external script of the `open_readspeaker/basic` library (depends on `open_readspeaker/conf`). If
`webreader_url` is empty, no library is built (a notice is logged). Install the `token` module to get
the token-browser link on the form.

## `rsConf` structure

`rsConf` is ReadSpeaker's own configuration object, mirrored 1:1 into config (see
`config/schema/open_readspeaker.schema.yml` and `config/install/open_readspeaker.settings.yml` for
every key/default). Three groups:

- **`rsConf.general`** — site-wide behaviour: `confirmPolicy`, `cookieName`/`cookieLifetime`,
  `customTransLangs` (translation target languages, checkboxes), `defaultSpeedValue`, `domain`,
  `subdomain`, `nativeLanguages`, `popupCloseTime`, `shadowDomSelector`, `syncContainer`,
  `saveLangVoice`, `translatedDisclaimer`, `skipHiddenContent`, `labels.ignoreSelector`
  (comma-separated HTML attributes to skip, stored as `[attr]`), `usePost` (POST mode — lets
  ReadSpeaker read password-protected pages; required when `skipHiddenContent` is on).
- **`rsConf.settings`** — per-user browser defaults: `hl` (word/sent/wordsent), `hlicon`, `hlscroll`,
  `hlsent`/`hltext`/`hlword` (hex colours), `hlspeed`, `hltoggle`, and the full `kb` keyboard-shortcut
  map (clicklisten, controlpanel, dictionary, download, enlarge, font size ±, formreading, help, menu,
  pagemask, pause, play, playerfocus, settings, stop, textmode, translation, readingvoice, detachfocus).
- **`rsConf.ui`** — `mobileVertPos` (`top|bottom=<px>`, split into two form fields), `controlpanel`
  `vertical`/`horizontal` alignment, and `tools` (checkboxes toggling each toolbar tool: settings,
  voicesettings, clicklisten, enlarge, formreading, textmode, pagemask, download, help, dictionary,
  translation, skipbuttons, speedbutton, controlpanel).

Validation: `ignoreSelector` attributes must match `^[\w-]+$`; `confirmPolicy` forbids control
characters; colours use `color_hex`; several fields are `Choice`-constrained. `rsConf` is published to
`drupalSettings.open_readspeaker.rsConf` by the block and copied to `window.rsConf` by `js/conf.js`.

## Set config with Drush (example)

```bash
drush config-set open_readspeaker.settings customerid '1234' -y
drush config-set open_readspeaker.settings cdn_region 'eu' -y
drush config-set open_readspeaker.settings lang 'en_us' -y
```

## CSP integration

If the [csp](https://www.drupal.org/project/csp) module is enabled, `CspSubscriber` parses the host
from the token-replaced `webreader_url` and appends it to the `style-src` and `style-src-elem`
directives, so ReadSpeaker's styles are allowed under a strict Content-Security-Policy. (You may also
need to allowlist the script host and the `app-*.readspeaker.com` endpoint for the block button.)

## Config translation

`open_readspeaker.config_translation.yml` exposes the settings for translation via the
config_translation module.
