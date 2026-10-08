# International Personal Documentation Validator — manual setup guide

**International Personal Documentation Validator** (`ipd_validator`, "IPD
Validator") provides an extensible, plugin‑based PHP API for **validating national
personal identity documents** — Argentina's DNI/CUIT/CUIL, Brazil's CPF/CNPJ,
Chile's RUT, India's PAN, Nigeria's NIN, Mexico's CURP, and around forty more
countries. Each country's rules (format and checksum logic) live in their own
validator plugin, and a plugin manager service ties them together.

This is a **developer tool with no user interface** — no blocks, no forms, no
settings page, no permissions. You call it from your own code: a Form API
validation callback during registration, a check before syncing data to an
external CRM, a guard on a Commerce checkout, or backend sanitization of an ID
field. It performs purely local string and checksum validation — there are no
external API calls and nothing is persisted — so there is no security‑sensitive
surface to configure.

The core service, `plugin.manager.ipd_validator`, exposes three methods:
`validate($document, $countryCode)`, `format($document, $countryCode)`, and
`getSupportedCountries()`. A useful thing to know: if no validator exists for a
given country code, the document is considered **valid by default**, so handle
unsupported countries explicitly if that matters to you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

IPD Validator has **no configuration page** — it is a backend API used entirely
from code, described in "How to use it" below.

## How to use it

Load the plugin manager service and validate a document by ISO country code:

```php
// Using the validator service.
$validator = \Drupal::service('plugin.manager.ipd_validator');

// Validate a CUIT (Argentina).
$is_valid = $validator->validate('20304050607', 'AR');
```

You can also normalize a raw document string with `format()`, and list the
supported countries with `getSupportedCountries()`.

### Adding a country of your own

Because each country is a plugin, you can support a new one from your **own**
module without patching this one — create a class annotated with `@Validator`
(supplying `id`, `title`, `description`, `country_code`, and `active`) that extends
`ValidatorPluginBase` and implements `isValid()` and `format()`. The plugin
manager discovers it automatically. The `agent/extend/validators.md` reference
shows a full skeleton.
