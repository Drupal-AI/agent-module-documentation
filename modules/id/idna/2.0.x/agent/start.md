<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IDNA Convert (idna) — agent index

Exposes the `algo26-matthias/idna-convert` PHP library (`^4.2`) as a Drupal service for
converting domain names, URLs and email hosts between Unicode and Punycode (IDNA /
"xn--…"). The whole module is one service class registered under two names (`idna` and
`idna.service`), plus a permission-gated demo page at `/idna`. Primary entry points are
`\Drupal::service('idna')->encode($input)` (Unicode → Punycode) and `->decode($input)`
(Punycode → Unicode); each method sniffs whether the input looks like a URL, an email, or a
bare domain and routes to the library's `convertUrl` / `convert` / `convertEmailAddress`.

There is no configuration: no settings form, no config schema/install, no hooks, no drush,
no plugin types, no field widgets/formatters. The only surface beyond the service is the
`/idna` demo page (a controller rendering an Encode form and a Decode form, both AJAX). It
is a thin developer/API utility.

- Depends on: no Drupal modules. Requires composer library `algo26-matthias/idna-convert` (`^4.2`).
- Core: `^11 || ^12`. Package: `Other`. Branch 2.x (installed 2.0.4).
- No settings page / `configure` route. Provides one permission (`access idna`), **no** config
  schema, no drush, no plugin types.

## What you'd do → where

- **Call the conversion service from code, understand `encode`/`decode` and the URL/email/domain
  heuristics, or work with the demo route/forms/permission** → [api/services.md](api/services.md)

## Key facts (real machine names)

- Service: `idna` (and duplicate alias `idna.service`) → class `Drupal\idna\Service\IdnaConvert`,
  methods `encode(string $input): string` / `decode(string $input): string`. Interface
  `Drupal\idna\Service\IdnaConvertInterface` declares both methods (a usable contract in 2.x).
- Route: `idna` → `/idna`, controller `Drupal\idna\Controller\Page::demo` (injects `form_builder`),
  requirement `_permission: 'access idna'`.
- Forms: `Drupal\idna\Form\Encode` (form id `idna_encode`), `Drupal\idna\Form\Decode`
  (form id `idna_decode`); AJAX callback `::ajaxSubmit`, targets `#idna-encode-wrap` /
  `#idna-decode-wrap`, output escaped with `Html::escape`.
- Permission: `access idna` (title "IDNA Convert.", not granted to anonymous by default).
- Underlying library classes: `Algo26\IdnaConvert\ToIdn`, `Algo26\IdnaConvert\ToUnicode`.

## Changes from 8.x-1.x

- Core requirement narrowed to `^11 || ^12`; library requirement bumped to `^4.2`.
- `IdnaConvertInterface` now declares `encode`/`decode` (was empty in 1.x).
- Service properties are typed and declared (`ToIdn $idna`, `ToUnicode $unicode`) — no dynamic property.
- Heuristics use `str_contains` / `str_starts_with` (PHP 8) instead of `strpos`.
