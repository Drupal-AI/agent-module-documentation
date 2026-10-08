# Configure TacJS

All configuration lives in the `tacjs.settings` config object and is edited through three admin
forms under `/admin/config/system/tacjs` (all require permission `administer tacjs`):

| Route | Path | Form | Purpose |
|---|---|---|---|
| `tacjs.manage_dialog` (default configure) | `/admin/config/system/tacjs/manage-dialog` | `ManageDialog` | Banner appearance & behaviour (`dialog.*`, `enabled`) |
| `tacjs.add_services` | `/admin/config/system/tacjs/add-services` | `AddServices` | Which tarteaucitron services are enabled (`services`) |
| `tacjs.edit_texts` | `/admin/config/system/tacjs/edit-texts` | `EditTexts` | Override every banner string (`texts`) |

## Prerequisite: install the tarteaucitron library

The JS library is **not** shipped with the module. Install it into
`web/libraries/tarteaucitronjs`, e.g. `composer require npm-asset/tarteaucitronjs:~1.21.0`, or
download a release from the tarteaucitron.js repo. `hook_requirements()` (runtime) reports an
error at `/admin/reports/status` until `libraries/tarteaucitronjs` exists. Language files under
`libraries/tarteaucitronjs/lang/` are auto-registered as libraries by `hook_library_info_build()`.

## `tacjs.settings` structure

```yaml
enabled: true                 # master on/off; if false, tacjs_page_attachments() bails
expire: <int>                 # consent cookie lifetime
dialog:                       # tarteaucitron dialog options (subset)
  privacyUrl: ''              # link to your privacy policy
  hashtag: '#tarteaucitron'   # URL hashtag that opens the panel
  cookieName: tarteaucitron
  orientation: middle         # middle | top | bottom …
  bodyPosition: bottom        # top | bottom
  showAlertSmall: false
  cookieslist: false
  showIcon: true              # persistent re-open icon
  iconPosition: BottomRight
  adblocker: false
  DenyAllCta: true            # show "Deny all" button
  AcceptAllCta: true          # show "Accept all" button
  highPrivacy: true           # nothing loads before explicit consent
  handleBrowserDNTRequest: false
  removeCredit: false
  moreInfoLink: true
  useExternalCss: true        # enforced TRUE by update 8002
  useExternalJs: true         # enforced TRUE by update 8002
  groupServices: false
  serviceDefaultState: wait   # wait | true | false
active:
  generate: false             # generate a trimmed active-services JS file
  suffix: default             # filename suffix (per-domain support)
services:                     # sequence keyed by tarteaucitron service name
  gtag:
    status: true              # only services with status:true are sent to the browser
  youtube:
    status: false
texts: { … }                  # per-string overrides, run through token replacement
user: { … }                   # tarteaucitron.user.* values
```

## Read / write with drush

```bash
drush cget tacjs.settings                       # whole config
drush cget tacjs.settings dialog                 # just the dialog options
drush cget tacjs.settings services               # enabled services

drush cset tacjs.settings enabled false -y       # disable the banner site-wide
drush cset tacjs.settings dialog.privacyUrl "/privacy" -y
```

In PHP, to enable a service (each service is a mapping with a `status` boolean):

```php
$config = \Drupal::configFactory()->getEditable('tacjs.settings');
$services = $config->get('services') ?? [];
$services['gtag'] = ['status' => TRUE];
$config->set('services', $services)->save();
```

## Runtime behaviour (`tacjs_page_attachments`)

- Skips admin routes entirely; returns early if `enabled` is falsey.
- Sends only services whose `status` is truthy to `drupalSettings.tacjs.services`.
- Attaches `tacjs/tacjs`, the current-language `tarteaucitron.<lang>.js` (falling back to
  `tarteaucitron.en.js`), and either the generated `tarteaucitron.active.services.<suffix>.js`
  (when `active.generate` is TRUE) or `tacjs/tarteaucitron.services.js`.
- Text values are passed through the token service before being sent to the browser.

**Security:** service definitions accept unfiltered text/JS, so only grant `administer tacjs`
to trusted users (the permission is `restrict access: TRUE`).
