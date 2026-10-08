<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Manager, Twig extension, tokens, tab plugin type & hooks

This module ships several API surfaces. Some are functional, several are **declared but not
wired** — flagged below so agents don't assume they work on a stock install.

## BusinessIdentityManager (value-object service, NOT registered)

`src/BusinessIdentityManager.php` (interface `BusinessIdentityManagerInterface`) aggregates
identity data into a `BusinessInformation` value object (`src/BusinessInformation.php`). Methods:
`getBusinessInfo()`, `getPrimaryContact()`, `getLocations()` / `getLocation()`, `getSocialLinks()`,
`getLegalInfo()`, `getFormattedAddress($type,$format)` (html/inline/plain), `getOperatingHours()`,
`isOpen()`, `getContactMethods()`, `validateBusinessInfo()` (returns errors/warnings +
`completeness_score`), plus `getBusinessName()`, `getBusinessSlogan()`, `getBusinessLogo()`,
`getBusinessCurrency()` (reads Commerce Store when present). It fires `hook_*_alter`s:
`business_identity_locations`, `business_identity_social_links`, `business_identity_operating_hours`.

Important: the manager is **not defined in `business_identity.services.yml`**, so
`\Drupal::service('business_identity.manager')` does not resolve on a stock install even though the
project's own examples reference it. `formatAddressHtml()` builds an HTML string from admin config;
it is only reachable via the (also-unregistered) Twig extension, and its input is admin-only config.

## Twig extension (NOT registered)

`src/Twig/BusinessIdentityTwigExtension.php` declares functions `business_info()`, `business_name()`,
`business_contact()`, `business_address($type,$format)`, `business_social_links()`,
`business_is_open()`, delegating to the manager. It is **not tagged `twig.extension`** in
services.yml, so these functions are not available in templates unless wired up.

## Tokens

- `business_identity.tokens.yml` declares a `business` token type and tokens (`legal_name`,
  `commercial_name`, `vat_number`, `address`, `phone`, `email`, `opening_hours`). There is **no
  `module.tokens.yml` convention** in Drupal, so this file does nothing on its own.
- `src/Token/BusinessIdentityToken.php` implements `getTokenInfo()` / `getTokens()` and is
  registered by `BusinessIdentityServiceProvider` with the tag `token_info`. Core token hooks are
  procedural (`hook_token_info` / `hook_tokens`); a tagged service alone does not make them fire,
  and the base module has no `.module` file, so **base-module `[business:*]` tokens do not resolve**.
- The DE/IT submodules **do** implement real `hook_tokens()` / `hook_token_info()` for
  `[business:local_laws_de_*]` / `[business:local_laws_it_*]` (see their docs).

## Tab plugin type (`business_identity_tab`)

Declared plugin type: manager `plugin.manager.business_identity_tab` (services.yml), annotation
`src/Annotation/BusinessIdentityTab.php`, interface `src/Plugin/BusinessIdentityTabInterface.php`,
base `src/Plugin/BusinessIdentityTabBase.php`, one plugin `src/Plugin/BusinessIdentityTab/BasicInfoTab.php`
(id `basic_info`). This is scaffolding for pluggable admin tabs — but `BusinessIdentityForm` builds
its tabs inline and never calls the manager, and the alternate builder
`src/Service/TabManager.php` (`business_identity.tab_manager`) is likewise not invoked by the shipped
form. Treat both as legacy/unused.

## Local-law extension hooks (used by the form)

`BusinessIdentityForm` discovers submodules named `business_identity_local_*` and invokes, per
module:

- `hook_business_identity_local_laws()` → region metadata (`name`, `code`, `description`, `icon`, …).
- `hook_business_identity_local_laws_fields()` → a Form-API fields array rendered under the
  Local Laws tab.
- `hook_business_identity_local_laws_tokens()` → token labels for the Tokens tab.
- `hook_business_identity_local_laws_validate($values, $form_state)` → array of field→error.

Region values are saved under `business_identity.settings:local_laws.<module>`. See
`business_identity_local_de` and `business_identity_local_it` for concrete implementations.
