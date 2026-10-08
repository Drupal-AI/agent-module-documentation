<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookie Consent Notice — configuration & operation

Everything this module does is: (1) a settings form storing five display strings, (2) two page hooks that
attach a JS behaviour and expose those strings to the browser, and (3) a client script that renders a notice
next to consent-blocked embeds. There are no entities, plugins, services, or server endpoints beyond the
config form.

## Install / enable

```
drush en cookie_consent_notice -y
```

No `composer.json` ships with the module, and info.yml declares no module dependencies. In practice it needs
**jQuery** and an underlying consent manager that adds Cookiebot-style opt-in classes (`.cookieconsent-optin-*`)
to blocked embeds — see `https://www.drupal.org/project/cookiebot/`. There is no `config/install/`, so after
enable the five settings are unset (the JS falls back to hard-coded English defaults).

## Configuration

- **Route:** `cookie_consent_notice.form` → `admin/config/cookie_consent_notice/adminsettings`
  (`cookie_consent_notice.routing.yml`).
- **Form:** `\Drupal\cookie_consent_notice\Form\CookieConsentNoticeForm` extends `ConfigFormBase`;
  form id `cookie_consent_notice_form`; editable config `cookie_consent_notice.settings`.
- **Toolbar link:** `cookie_consent_notice.links.menu.yml` places "Cookie Consent Notice" under
  `system.admin_config_system` in the `toolbar` menu (weight 99).

Config object `cookie_consent_notice.settings` keys (all plain textfields, `#maxlength` 255):

| Key | Form title | JS default | drupalSettings key |
|-----|------------|------------|--------------------|
| `message_text` | Message Text | `To view this content, you need to` | `messageText` |
| `message_link_text` | Message Link Text | `accept the following cookies:` | `messageLinkText` |
| `preference_label` | Preferences Custom Label | `Preferences` | `preferenceLabel` |
| `statistics_label` | Statistics Custom Label | `Statistics` | `statisticsLabel` |
| `marketing_label` | Marketing Custom Label | `Marketing` | `marketingLabel` |

`buildForm()` reads each key from config; `submitForm()` writes all five back via
`->set(...)->save()`. Setting these by CLI:

```
drush cset cookie_consent_notice.settings message_text 'To view this content, you must' -y
```

There is **no `config/schema/`** in the module, so these keys are schema-less (config export/typed-data will
warn; translation of the config values via the interface-translation UI is not wired up).

### Permission caveat

The route requires `_permission: 'access cookie consent notice'`, but the module ships **no `*.permissions.yml`**
defining that string. The permission is therefore undefined and cannot be granted to any role, so the settings
page is effectively unreachable out of the box (fail-closed). To administer the form you must define the
permission yourself (e.g. in a small custom module or by patching in a `cookie_consent_notice.permissions.yml`)
or adjust the route. This is a functional gap, not an exposure.

## Hooks (`cookie_consent_notice.module`)

- `cookie_consent_notice_preprocess_page(array &$variables)` — appends library
  `cookie_consent_notice/cookie_consent_notice` to `$variables['#attached']['library']`.
- `cookie_consent_notice_page_attachments_alter(array &$attachments)` — reads the five config values,
  attaches library `cookie_consent_notice/cookie_consent_notice_form`, and copies each value into
  `$attachments['#attached']['drupalSettings']['cookieConsentNotice'][…]`.

Both run on every page, so the notice strings are exposed to all visitors via `drupalSettings` — expected,
since the notice is meant to render for anonymous users. Note `cookie_consent_notice_form` is referenced here
and in info.yml but is **not** actually defined in `cookie_consent_notice.libraries.yml` (which declares only
`cookie_consent_notice`, a single JS file, no dependencies).

## Client behaviour (`js/cookie_consent_notice.js`)

Wrapped in `(function ($, Drupal) { … })(jQuery, Drupal)` and delayed by `setTimeout(…, 1000)`.
`Drupal.behaviors.cookieConsentNotice.attach` runs once (guarded by `scriptHasRunOnce`) and:

1. Reads the five strings from `drupalSettings.cookieConsentNotice`, falling back to English defaults.
2. Detects blocked slots by class — `.cookieconsent-optin-preferences`, `.cookieconsent-optin-statistics`,
   `.cookieconsent-optin-marketing` — building a `<ul>` of the required category labels (each wrapped in
   `Drupal.t()`).
3. Appends `<div class="cookie-consent-div …">` to the blocked element's parent, containing the message plus a
   link `<a href="#" onclick="CookieConsent.renew()">…</a>` that reopens the consent dialog.
4. Runs a `setInterval` (500 ms) that hides the notice (`display: none`) and clears itself once the real
   consented element becomes visible.

The markup for the notice is assembled from the admin-configured strings and injected via `innerHTML`; those
strings are trusted administrator content (the settings form is the only writer). The module performs no
network requests, defines no AJAX callbacks, and reads/writes no cookies of its own — it delegates all actual
consent storage and script-gating to the underlying consent manager.
