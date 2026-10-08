# EU Cookie Compliance Matomo — agent index

Glue between **EU Cookie Compliance** and **Matomo**: injects a JS snippet that gates Matomo
tracking on the cookie-consent banner, using Matomo's `_paq` consent API (`requireConsent`,
`disableCookies`, `setConsentGiven`). Depends on `eu_cookie_compliance` and `matomo`. Configure
route `eu_cookie_compliance_matomo.settings` → `/admin/config/system/eu-cookie-compliance/matomo`
(permission `administer eu cookie compliance popup`, from EU Cookie Compliance).

- **The single setting (`categories`), the route/permission, drush/config** →
  [configure/settings.md](configure/settings.md)
- **How consent is wired (the injected `_paq` snippet, opt-in vs categories logic, the JS behavior)** →
  [api/mechanism.md](api/mechanism.md)

Key facts: the only config is `eu_cookie_compliance_matomo.settings.categories` (an array of cookie
category machine names required for Matomo consent; shipped default `[]`). Behaviour also depends on
EU Cookie Compliance's `method` (opt_in vs categories) and Matomo's `privacy.disablecookies`. No
plugins, no Drush, no permissions of its own. The consent UI/tracking live in the other two modules.
