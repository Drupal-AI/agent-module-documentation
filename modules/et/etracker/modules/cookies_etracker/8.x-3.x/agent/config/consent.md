<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cookies_etracker — consent gating

## Install & enable

```bash
drush en cookies_etracker -y
```

Depends on **`cookies`** and **`etracker`** (`cookies_etracker.info.yml`). `hook_install()`
(`cookies_etracker.install`) sets the module weight to 11 and, if etracker's
`etracker.settings:etracker_script_settings.data_block_cookies` is empty, enables it — so etracker cookies are
blocked until you finish configuring consent. It also shows a message linking to the etracker settings form.

## Config

- **`cookies_etracker.settings`** — one key `knockout_mode` (string). Schema:
  `config/schema/etracker_config.schema.yml`. Install default: `block_cookies_true_without_consent`.
- **`cookies.cookies_service.etracker`** (`config/install/`) — a COOKiES service definition (id `etracker`,
  group `tracking`, `consentRequired: true`) with a full-HTML cookie table and processor/privacy metadata;
  `dependencies.enforced.module` lists `cookies_etracker`.
- No route, no permission, no own form. Update hook `cookies_etracker_update_8001()` appends `cookies_etracker`
  to the enforced module dependencies of `cookies.cookies_service.analytics` (if present);
  `cookies_etracker_update_8002()` seeds `knockout_mode` = `block_cookies_true_without_consent` if empty.

## The "Blocking mode" form addition

`cookies_etracker_form_etracker_admin_settings_alter()` adds, under the etracker form's *Privacy* tab, a
details group *Advanced "Disable cookies" handling* with a `knockout_mode` radios element (visible only when
*Disable cookies* is checked). If *Disable cookies* is unchecked it instead shows a warning item and, on load,
`\Drupal::messenger()->addWarning()` ("COOKiES eTracker will not block anything this way"). A submit callback
`_cookies_etracker_form_etracker_admin_settings_save()` saves `knockout_mode` to `cookies_etracker.settings`.

## The four modes

Radio options (machine value → label):

| `knockout_mode` | Label | Before consent | After consent |
|---|---|---|---|
| `block_cookies_true_without_consent` | Most accuracy | tracks, `data-block-cookies=true` | tracks, `data-block-cookies=false` |
| `knockout_without_consent_block_cookies_true` | Most privacy | knocked out (no tracking) | tracks, `data-block-cookies=true` |
| `knockout_without_consent_block_cookies_false` | Mixed | knocked out (no tracking) | tracks, `data-block-cookies=false` |
| `block_cookies_true` | Ignore consent | tracks, `data-block-cookies=true` | unchanged (same as without this submodule) |

## Runtime mechanism (`cookies_etracker.module`)

Both `hook_library_info_alter()` and `hook_page_attachments()` first no-op unless etracker's `data_block_cookies`
is enabled **and** `\Drupal::service('cookies.knock_out')->doKnockOut()` is TRUE (consent not yet given).
`hook_page_attachments()` additionally reuses etracker's `_etracker_path_should_be_tracked()` /
`_etracker_user_should_be_tracked()` so it only acts where etracker itself would track.

- **Knockout modes** (`knockout_without_consent_block_cookies_true|false`): `hook_library_info_alter()` sets
  `preprocess = FALSE` on `js/etracker.js` and rewrites both the inline `etracker_script` and the `_etLoader`
  external tag `type` to `application/json` — so neither executes. `hook_page_attachments()` passes
  `drupalSettings.cookies_etracker.knockout_mode` and attaches `cookies_etracker/knockout_without_consent`.
  In `js/cookies_etracker-knockout_without_consent.js` the `cookiesjsrUserConsent` handler, when the `etracker`
  service is consented, "heals" each script (`_etLoader`, `etracker_script`) by cloning it into a real
  `text/javascript` `<script>` (setting `data-block-cookies=false` for the `..._false` mode); on revoke it
  calls `_etracker.disableTrackingForSession()`.
- **Most-accuracy mode** (`block_cookies_true_without_consent`): no library alteration; `hook_page_attachments()`
  attaches `cookies_etracker/block_cookies_true_without_consent`. Its JS, on the consent event, calls
  `_etracker.enableCookies()` and sets `data-block-cookies=false` when consent is given, and
  `_etracker.disableCookies()` / `data-block-cookies=true` when denied/revoked.
- **Ignore-consent mode** (`block_cookies_true`): no action (etracker already blocks cookies permanently).
- An unmatched mode logs a warning to the `cookies_etracker` channel.

## Notes

- All consent reactions run client-side on the COOKiES `cookiesjsrUserConsent` DOM event; the module makes no
  server-side HTTP calls and stores no credentials.
- The `etracker` service id used in the JS (`Drupal.behaviors.*.id = 'etracker'`) matches
  `cookies.cookies_service.etracker`'s id.
