<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IDNA Convert (idna) — agent index

Exposes the `algo26-matthias/idna-convert` PHP library as a Drupal service for converting
domain names between Unicode and Punycode (IDNA / "xn--…"). The whole module is one service
class registered under two names (`idna` and `idna.service`), plus a permission-gated demo
page at `/idna`. Primary entry point is `\Drupal::service('idna')->encode($input)` (Unicode
→ Punycode) and `->decode($input)` (Punycode → Unicode); each method sniffs whether the
input looks like a URL, an email, or a bare domain and routes to the library's
`convertUrl` / `convert` / `convertEmailAddress` accordingly.

There is no configuration: no settings form, no config schema/install, no hooks, no drush,
no plugin types, no field widgets/formatters. The only surface beyond the service is the
`/idna` demo page (a controller rendering an Encode form and a Decode form, both AJAX). It
is a thin developer/API utility.

- Depends on: no Drupal modules. Requires composer library `algo26-matthias/idna-convert` (`>3.0`).
- Core: `^8 || ^9 || ^10 || ^11`. Package: `Other`.
- No settings page / `configure` route. Provides one permission (`access idna`), **no** config
  schema, no drush, no plugin types.

## What you'd do → where

- **Call the conversion service from code, understand `encode`/`decode` and the URL/email/domain
  heuristics, or work with the demo route/forms/permission** → [api/services.md](api/services.md)

## Key facts (real machine names)

- Service: `idna` (and duplicate alias `idna.service`) → class `Drupal\idna\Service\IdnaConvert`,
  methods `encode($input)` / `decode($input)`. Empty interface `IdnaConvertInterface`.
- Route: `idna` → `/idna`, controller `Drupal\idna\Controller\Page::demo`, requirement
  `_permission: 'access idna'`.
- Forms: `Drupal\idna\Form\Encode` (form id `idna_encode`), `Drupal\idna\Form\Decode`
  (form id `idna_decode`); AJAX callback `::ajaxSubmit`, targets `#idna-encode-wrap` /
  `#idna-decode-wrap`.
- Permission: `access idna` (title "IDNA Convert.", not granted to anonymous by default).
- Underlying library classes: `Algo26\IdnaConvert\ToIdn`, `Algo26\IdnaConvert\ToUnicode`.
