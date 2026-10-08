<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookie Consent Notice (cookie_consent_notice) — agent index

Client-side UX helper for cookie-consent workflows. When a consent tool (built for **Cookiebot**) hides an
embed because the visitor has not opted in, this module drops a small notice `<div>` into that slot showing an
admin-set message, a link that reopens the consent dialog (`CookieConsent.renew()`), and the list of required
cookie categories. It sets/reads **no** tracking cookies itself and stores no consent state — pure presentation.

- **Version dir:** 1.0.x (info.yml `version: 1.0.2`). Core `^8 || ^9 || ^10 || ^11`. Package `Custom`, license GPL-2.0-or-later.
- **Dependencies:** none declared in info.yml. Runtime-assumes **jQuery** and an underlying consent manager (Cookiebot). No `composer.json`.
- **Config:** single object `cookie_consent_notice.settings` with 5 string keys — `message_text`, `message_link_text`, `preference_label`, `statistics_label`, `marketing_label`. **No config schema** (`config/schema/` absent) and **no `config/install/` defaults**.
- **Route:** `cookie_consent_notice.form` → `admin/config/cookie_consent_notice/adminsettings`, form `\Drupal\cookie_consent_notice\Form\CookieConsentNoticeForm` (`ConfigFormBase`). Requires permission `access cookie consent notice`. Toolbar menu link via `*.links.menu.yml`.
- **Permission quirk:** the route names `access cookie consent notice` but the module ships **no `*.permissions.yml`**, so the permission is undefined (fail-closed — no role can be granted it out of the box).
- **Hooks (`.module`):** `cookie_consent_notice_preprocess_page()` attaches library `cookie_consent_notice/cookie_consent_notice`; `cookie_consent_notice_page_attachments_alter()` attaches `cookie_consent_notice/cookie_consent_notice_form` and pushes the 5 config strings into `drupalSettings.cookieConsentNotice`.
- **Library quirk:** `libraries.yml` defines only `cookie_consent_notice` (one JS file, no declared deps). The `cookie_consent_notice_form` library referenced by info.yml/.module is **not defined**.
- **JS (`js/cookie_consent_notice.js`):** detects `.cookieconsent-optin-{preferences,statistics,marketing}`, appends `<div class="cookie-consent-div …">`, auto-hides once the real element renders. No AJAX, no endpoints.
- **Provides:** no entities, no plugins, no services, no Drush, no submodules.

## Solution docs

- [config/settings.md](config/settings.md) — install/enable, the settings form & config keys, routes/permission, hooks, and how the client script renders the notice.
