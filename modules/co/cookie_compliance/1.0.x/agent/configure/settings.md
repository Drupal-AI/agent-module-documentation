<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Cookie Compliance

Route `cookie_compliance.cookie_compliance_settings` → `/admin/config/system/cookie-compliance-settings`
(permission: `administer site configuration`). Form: `CookieComplianceSettingsForm` (extends `ConfigFormBase`).

## Fields (config `cookie_compliance.settings`)
- `enabled` (bool) — master on/off for the banner.
- `app_id` (string) — hu-manity.co App ID; obtained by registering a domain at cookie-compliance.co. Validated `^[a-z0-9-]+$`.
- `app_secret_key` (string) — App Secret Key; same validation. Stored but not used in page injection.

## Drush / config
```
drush config:set cookie_compliance.settings enabled 1 -y
drush config:set cookie_compliance.settings app_id YOUR-APP-ID -y
```
When `enabled` is true and `app_id` non-empty, every page gets:
```html
<script>var huOptions = {'appID':'YOUR-APP-ID','currentLanguage':'en'}</script>
<script src="https://cdn.hu-manity.co/hu-banner.min.js"></script>
```
All consent logic lives in the remote script; the module stores no consent records locally.
