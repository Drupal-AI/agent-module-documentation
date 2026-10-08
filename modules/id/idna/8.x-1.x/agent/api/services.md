<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IDNA Convert — service API + demo page

The module's whole point is one service that wraps the `algo26-matthias/idna-convert`
composer library and exposes it as a Drupal service. There is no config, no plugin type,
no drush; just the service, one demo route, and one permission.

## The service

Registered twice (same class, no constructor args) in `idna.services.yml`:

- `idna` → `Drupal\idna\Service\IdnaConvert`
- `idna.service` → `Drupal\idna\Service\IdnaConvert` (alias/duplicate; both resolve to the same class)

Call from code:

```php
\Drupal::service('idna')->encode($input);   // Unicode → Punycode (ASCII / "xn--…")
\Drupal::service('idna')->decode($input);   // Punycode → Unicode
```

The class implements `Drupal\idna\Service\IdnaConvertInterface`, but that interface is
**empty** (declares no methods) — do not rely on it for typing the `encode`/`decode`
contract. The constructor builds `Algo26\IdnaConvert\ToIdn` (for encode) and assigns
`Algo26\IdnaConvert\ToUnicode` to an *undeclared* `$this->unicode` property (a dynamic
property; works but is deprecated on PHP 8.2+). Both methods take a single string and
return a string.

### `encode($input)` — `src/Service/IdnaConvert.php:31`

Heuristic on the input, in order:

1. If `$input` already contains `xn--` → returned unchanged (assumed already encoded).
2. Else if it looks like a URL — contains `/` (not at position 0), or `:`, or starts with
   `*.` → `ToIdn::convertUrl($input)`.
3. Else if it contains `@` → treated as an email: the local part before `@` is kept
   verbatim and only the host after `@` is encoded → `"$name@" . ToIdn::convert($host)`.
4. Else → `ToIdn::convert($input)` (bare domain/label).

Examples (runtime-verified, Drupal 11.x): `münchen.de` → `xn--mnchen-3ya.de`;
`xn--mnchen-3ya.de` → returned unchanged (already contains `xn--`).

### `decode($input)` — `src/Service/IdnaConvert.php:51`

Trims, then:

1. Contains `/` (not at position 0) or `:` → `ToUnicode::convertUrl($input)`.
2. Else contains `@` → `ToUnicode::convertEmailAddress($input)`.
3. Else → `ToUnicode::convert($input)`.

Example: `xn--mnchen-3ya.de` → `münchen.de`.

> Note the `strpos($input, '/')` / `strpos($input, ':')` checks are truthy tests, so a `/`
> or `:` at string position 0 is treated as "not present" (a PHP `strpos` quirk carried by
> this code). Callers wanting deterministic behavior should pass a clean domain/URL/email.

## Demo page

- Route `idna` → path `/idna`, controller `Drupal\idna\Controller\Page::demo`, title
  "IDNA Convert Service" (`idna.routing.yml`).
- Requirement: `_permission: 'access idna'` (defined in `idna.permissions.yml`, title
  "IDNA Convert.", not granted to anonymous by default — runtime-verified).
- `Page::demo()` returns a render array embedding two forms:
  - `Drupal\idna\Form\Encode` — form id `idna_encode`.
  - `Drupal\idna\Form\Decode` — form id `idna_decode`.
- Each form has a `Domains` textarea and an AJAX submit (`::ajaxSubmit`). On submit each
  input line is `trim()`-ed and run through `\Drupal::service('idna')->encode()` /
  `->decode()`, and the joined result is written back into `#idna-encode-wrap` /
  `#idna-decode-wrap` via an `HtmlCommand`. Forms set `$form_state->setCached(FALSE)` and
  `submitForm()` just calls `setRebuild(TRUE)`; nothing is stored.

## Not present (do not look for these)

No settings/config form or `configure` route, no `config/schema` or `config/install`
(no config schema), no hooks (`.module`/`.install` absent), no drush commands, no plugin
types, no field widgets/formatters, no libraries, no submodules. Only dependency is the
composer library `algo26-matthias/idna-convert` (`>3.0`); no Drupal module dependencies.
