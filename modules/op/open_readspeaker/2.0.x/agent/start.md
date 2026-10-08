# Open ReadSpeaker — agent index

Integrates the commercial ReadSpeaker webReader / Enterprise Highlighting text-to-speech service:
loads ReadSpeaker's remote JS, exposes the full `rsConf` config, and provides a "Listen" block that
reads a page region aloud. Requires a ReadSpeaker account. No dependencies; suggests `token` (token
browser) and `csp` (CSP support). One permission: `administer open readspeaker`. Provides a config
schema. No Drush, no submodules, no plugin types.

- **Global settings: customer id, CDN, language/voice, tokenized remote JS URL, the whole `rsConf` tree, tokens, CSP** →
  [configure/settings.md](configure/settings.md)
- **The "Listen" webReader block: button URL, reading area id/classes, `drupalSettings`, placement** →
  [configure/block.md](configure/block.md)

Key facts:
- Configure route `open_readspeaker.settings` → `admin/config/services/open-readspeaker`
  (permission `administer open readspeaker`).
- Config object `open_readspeaker.settings`: `customerid`, `cdn_region`, `lang`, `voice`,
  `webreader_url` (tokenized), `rsConf.{general,settings,ui}`.
- `hook_library_info_build()` builds `open_readspeaker/basic` loading `webreader_url` (token-replaced) as
  an external script; tokens `open-readspeaker:customer-id` and `open-readspeaker:cdn` are defined by the module.
- Block `open_readspeaker_webreader` (`OpenReadspeakerWebreader`) renders the Listen button and publishes
  `rsConf` to `drupalSettings` (→ `window.rsConf` via `js/conf.js`).
- `CspSubscriber` adds the ReadSpeaker host to `style-src`/`style-src-elem` when the `csp` module is enabled.
- The remote script/endpoint URLs are admin-entered — trusted admin input that injects a third-party
  script on every page carrying the block.
