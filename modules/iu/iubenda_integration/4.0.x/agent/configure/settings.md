<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, forms, block, and permission

## Routes (all require `administer iubenda_integration`)

| Route | Path | Form |
|---|---|---|
| `iubenda_integration.settings` | `/admin/config/services/iubenda-integration` | General / Privacy (`IubendaSettingsForm`) |
| `iubenda_integration.settings.cookie` | `.../iubenda-integration/cookie-policy` | Cookie Solution (`IubendaSettingsCookieForm`) |
| `iubenda_integration.settings.consent` | `.../iubenda-integration/consent-solution` | Consent Solution (`IubendaSettingsConsentForm`) |

**All three forms write into the single config object `iubenda_integration.settings`.** (Despite
their `getEditableConfigNames()` naming `.settings.cookie` / `.settings.consent`, the submit
handlers call `configFactory->getEditable('iubenda_integration.settings')`.) Read everything with
`drush cget iubenda_integration.settings`.

## Key config keys (`iubenda_integration.settings`)

General / Privacy:
- `iubenda_integration_policy_code` — the Iubenda privacy policy code (the number in your
  `iubenda.com/privacy-policy/XXXXXXX` URL). **Required** for JS to attach.
- `iubenda_integration_style` — `iubenda-nostyle` | `iubenda-white` | `iubenda-black`.
- `iubenda_integration_legal_only` (bool), `iubenda_integration_show_brand` (bool).
- `iubenda_integration_form_element_type` — `checkbox` | `radio`.
- `iubenda_integration_forms` — newline-separated Drupal **form ids** that should get the privacy
  consent element.
- `iubenda_integration_form_element_label`, `iubenda_integration_pretext`,
  `iubenda_integration_text`, `iubenda_integration_posttext` — the consent link text pieces.

Cookie Solution:
- `cookie_solution_enable` (bool) — turn the cookie banner on.
- `siteId` — your Iubenda site id (also enables the autoblocking JS via
  `hook_library_info_alter()`).
- `enableGdpr`, `enableLgpd`, `enableFadp`, `enableUspr` (bool) — which legal frameworks apply.
- `position` — `full-top` | `bottom` | `float-center` | `float-top-left` | … (banner position).
- `backgroundOverlay` (bool), `applyStyles` (bool).
- Buttons: `acceptButtonDisplay`, `customizeButtonDisplay`, `rejectButtonDisplay`,
  `closeButtonDisplay`, `closeButtonRejects` (bools).

Consent Solution:
- `api_key` — Iubenda consent-solution API key (attaches the consent JS when set).

## Set with drush

```bash
drush cget iubenda_integration.settings iubenda_integration_policy_code
drush cset iubenda_integration.settings iubenda_integration_policy_code 1234567 -y
drush cset iubenda_integration.settings cookie_solution_enable true -y
drush cset iubenda_integration.settings siteId 987654 -y
drush cset iubenda_integration.settings position bottom -y
```

## Block

The module provides a block plugin **`iubenda_integration_privacy_policy`** ("Iubenda
Integration: Privacy policy"). Place it in a region (Block layout) to output the privacy-policy
link; its block config has `iubenda_integration_block.text_prefix` / `text` / `text_suffix`.

## Permission

`administer iubenda_integration` — the only permission; gates all three settings forms.

## Config translation

`iubenda_integration.settings` is exposed to config translation
(`iubenda_integration.config_translation.yml`).
