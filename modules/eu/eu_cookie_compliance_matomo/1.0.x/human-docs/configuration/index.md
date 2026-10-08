# Configuration

This module has just one setting of its own. It lives on a form at **Configuration →
System → EU Cookie Compliance → Matomo**
(`/admin/config/system/eu-cookie-compliance/matomo`), reached with the **Administer
EU Cookie Compliance popup** permission (which belongs to the EU Cookie Compliance
module, not this one).

## The one setting: consent categories

**Categories** — the cookie categories that a visitor must agree to before Matomo
is granted consent. The form shows a checkbox for each cookie category you have
defined in EU Cookie Compliance; tick the ones that should govern Matomo (typically
your statistics/analytics category, and marketing if relevant).

This setting only matters when EU Cookie Compliance is running in **opt-in with
categories** mode. In plain **opt-in** mode, consent is all-or-nothing — the module
simply grants Matomo consent when the visitor accepts the banner, and this setting
is not used. If you have not defined any cookie categories in EU Cookie Compliance,
the form has no options and the setting stays empty.

## How the two modes behave

- **Opt-in mode** — before the visitor agrees, Matomo is told to require consent
  (and, unless Matomo is already set to disable cookies, to disable them). When the
  visitor clicks **Agree**, Matomo is told consent is given and tracking starts.
- **Opt-in with categories mode** — Matomo is held back until **all** of the
  categories you selected above have been agreed. When the visitor saves their
  preferences including those categories (or accepts all), Matomo consent is given.

## Configuration this module reads from the other modules

This bridge reads a few settings that belong to the other two modules — you don't
set them here, but they affect its behaviour:

- From **EU Cookie Compliance**: the consent **method** (opt-in vs categories) and
  the consent **cookie name**.
- From **Matomo**: whether Matomo is already configured to disable cookies (if so,
  this module won't add a second disable-cookies instruction).

Configure those in the EU Cookie Compliance and Matomo settings, not here.

## Setting the value by script

The setting is an array of category machine names, so set it with `php:eval`:

```php
\Drupal::configFactory()->getEditable('eu_cookie_compliance_matomo.settings')
  ->set('categories', ['analytics', 'marketing'])
  ->save();
```
