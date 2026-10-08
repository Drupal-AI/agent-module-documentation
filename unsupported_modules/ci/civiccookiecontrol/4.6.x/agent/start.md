<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Civic Cookie Control (civiccookiecontrol) — agent index

Drupal integration for the **CivicUK Cookie Control** hosted consent widget. The module supplies
configuration + asset loading; the consent engine is Civic's JS loaded from
`cc.cdn.civiccomputing.com`. PHP **8.0**, core `^9.3 || ^10 || ^11`. Package `Civic`.

> **Naming:** drupal.org project **`civicccookiecontrol`** (three c's, composer
> `drupal/civicccookiecontrol`), module machine name **`civiccookiecontrol`** (two c's). The
> `libraries:` list in `civiccookiecontrol.info.yml` references a **`civiccokiecontrol/…`**
> extension name (missing an "o") — check exact strings in the info/libraries files before
> referencing them; nothing else in the module uses that spelling.

Dependencies: none required (core only). Optional integrations detected at runtime: `ckeditor` /
`ckeditor5` (installs a "Cookie Control HTML" format), `language` (Drupal-locale mode), `csp`
(adds `unsafe-eval` script-src directive). Ships one submodule: `civic_govuk_cookiecontrol`.

What it provides:
- **Config objects** (`src/CCCConfigNames.php`): `civiccookiecontrol.settings` (main),
  `civiccookiecontrol.iab` (TCF v1, legacy), `civiccookiecontrol.iab2` (TCF v2). Schema in
  `config/schema/`. Install defaults in `config/install/`.
- **Config entity types** (`src/Entity/`, all `admin_permission = "administer civiccookiecontrol"`):
  `cookiecategory` (optional-cookie categories + onAccept/onRevoke JS), `necessarycookie`,
  `excludedcountry`, `altlanguage` (per-language consent text). Each has a ListBuilder in
  `src/Controller/` and add/edit/delete forms in `src/Form/`.
- **Settings form** `CivicCookieControlSettings` (`src/Form/`, route `cookiecontrol.admin_overview`,
  `configure` target) — a multi-step wizard (`src/Form/Steps/`: `CCCLicenseInfo`, `CCCSettings`,
  managed by `CCCStepsManager`). Extra IAB forms: `IAB1Settings`, `IAB2Settings`.
- **Widget config builders** (`src/CCCConfig/`): `AbstractCCCConfig` → `CCC8Config` / `CCC9Config`,
  selected by `CCCConfigFactory::getCccConfig($version)`. `getCccConfigJson()` returns the JSON
  attached to pages. `CCC9Vendors` handles TCF vendor lists.
- **Access checks** (`src/Access/`): `CookieControlAccess::checkAccess` / `::checkApiKey`,
  plus route access services `_iab1_access_check`, `_iab2_access_check`,
  `_iab2_enabled_access_check` (`civiccookiecontrol.services.yml`).
- **Permission**: `administer civiccookiecontrol` (`civiccookiecontrol.permissions.yml`).
- **Hooks** (`civiccookiecontrol.module`): `hook_page_attachments` (builds + attaches the widget
  config and libraries on non-admin pages), `hook_js_alter`, `hook_link_alter`, `hook_theme`,
  `hook_theme_suggestions_page_alter`, modules-installed/uninstalled (WYSIWYG format install).
- **API-key validation** (`src/Form/CCCFormHelper::validateApiKey`): server-side check against
  `https://apikeys.civiccomputing.com` (Guzzle `\Drupal::httpClient()`).

Solution docs:
- [config/settings.md](config/settings.md) — install/enable, the three config objects, keys,
  routes, permissions, the settings wizard.
- [config/entities.md](config/entities.md) — the four config entity types and how they map into
  the widget config.
- [api/widget-config.md](api/widget-config.md) — how the JSON config object is built and attached,
  the `CCCConfig` classes, caching, and the client-side loader.

Submodule docs: [../modules/civic_govuk_cookiecontrol/4.6.x/agent/start.md](../modules/civic_govuk_cookiecontrol/4.6.x/agent/start.md)

```bash
drush en civiccookiecontrol -y
drush cget civiccookiecontrol.settings
# Config UI: /admin/config/system/cookiecontrol  (needs 'administer civiccookiecontrol' + valid API key)
```
