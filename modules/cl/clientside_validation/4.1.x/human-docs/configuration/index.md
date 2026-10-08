# Configuration

The base **Clientside Validation** module has **no settings form of its own** — it
works automatically, decorating form elements with validation attributes. The real
configuration lives in the **jQuery engine** submodule
(`clientside_validation_jquery`), which must be enabled (see
[Installation](../installation/index.md)).

## Open the jQuery settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → User interface → Clientside Validation jQuery settings**
   (`/admin/config/user-interface/clientside-validation-jquery-settings`).

## The settings, field by field

- **Use CDN** (`use_cdn`, default off) — load the jQuery Validate library from a
  CDN instead of a local copy. Turn this off (the default) to serve the library
  from your own `/libraries/` folder for privacy or offline use.
- **CDN base URL** (`cdn_base_url`) — the CDN location used when *Use CDN* is on.
  It defaults to a jsDelivr URL for a specific jQuery Validate version; include the
  version and the trailing slash if you change it.
- **Validate all AJAX forms** (`validate_all_ajax_forms`) — controls whether AJAX
  forms are validated before they submit. With the default value, forms carrying
  the `cv-validate-before-ajax` class are validated.
- **Force validate on blur** (`force_validate_on_blur`, default off) — validate a
  field as soon as the user leaves it (on blur / focus‑out), rather than only on
  submit.
- **Force HTML5 validation** (`force_html5_validation`, default off) — run the
  browser's native HTML5 validation first, before the jQuery layer runs.

Settings are stored in the `clientside_validation_jquery.settings` config object,
so they export and deploy with `drush config:export`. You can also set them from
the CLI, for example:

```bash
drush cset clientside_validation_jquery.settings use_cdn 1
```

## Installing the library locally

If you keep *Use CDN* off, the engine looks for jQuery Validate at
`/libraries/jquery-validation/dist/jquery.validate.min.js`. Place the library
there manually, or use the submodule's Drush commands to download it. If no local
copy is found and *Use CDN* is off, it falls back to the CDN.

## Per‑element customization (for developers)

Most validation needs no configuration — it derives from standard Drupal form
properties. To customize the message shown for a specific element, set
render‑array keys such as `#required_error` or `#pattern_error`. To stop an
element being validated at all, implement
`hook_clientside_validation_should_validate()`. Buttons with an empty
`#limit_validation_errors` (Cancel / Preview style) automatically bypass
validation. See the [`agent/`](../agent/start.md) docs for the plugin and hook
APIs.
