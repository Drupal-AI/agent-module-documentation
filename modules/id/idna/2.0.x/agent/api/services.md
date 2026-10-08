<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IDNA Convert — service API + demo page

The module's whole point is one service that wraps the `algo26-matthias/idna-convert`
composer library (`^4.2`) and exposes it as a Drupal service. There is no config, no plugin
type, no drush; just the service, one demo route, and one permission.

## The service

Registered twice (same class, no constructor args) in `idna.services.yml`:

- `idna` → `Drupal\idna\Service\IdnaConvert`
- `idna.service` → `Drupal\idna\Service\IdnaConvert` (alias/duplicate; both resolve to the same class)

Call from code:

```php
\Drupal::service('idna')->encode($input);   // Unicode → Punycode (ASCII / "xn--…")
\Drupal::service('idna')->decode($input);   // Punycode → Unicode
```

The class implements `Drupal\idna\Service\IdnaConvertInterface`. In 2.x that interface
**declares both `encode(string $input): string` and `decode(string $input): string`**, so it
is a usable contract for type-hinting (the two demo forms inject the service by this
interface). The constructor builds `Algo26\IdnaConvert\ToIdn` (encode) and
`Algo26\IdnaConvert\ToUnicode` (decode) into typed, declared properties (`protected ToIdn
$idna` / `protected ToUnicode $unicode` — no dynamic-property deprecation). Both methods take
a single string and return a string.

### `encode($input)` — `src/Service/IdnaConvert.php`

Heuristic on the input, in order (using PHP 8 `str_contains` / `str_starts_with`):

1. If `$input` already contains `xn--` → returned unchanged (assumed already encoded).
2. Else if it looks like a URL — contains `/`, or `:`, or starts with `*.` → `ToIdn::convertUrl($input)`.
3. Else if it contains `@` → treated as an email: `explode('@', $input, 2)` keeps the local
   part verbatim and only the host is encoded → `"$name@" . ToIdn::convert($host)`.
4. Else → `ToIdn::convert($input)` (bare domain/label).

Example (runtime-verified equivalent, Drupal 11.x): `münchen.de` → `xn--mnchen-3ya.de`;
`xn--mnchen-3ya.de` → returned unchanged (already contains `xn--`).

### `decode($input)` — `src/Service/IdnaConvert.php`

`trim()`s the input, then:

1. Contains `/` or `:` → `ToUnicode::convertUrl($input)`.
2. Else contains `@` → `ToUnicode::convertEmailAddress($input)`.
3. Else → `ToUnicode::convert($input)`.

Example: `xn--mnchen-3ya.de` → `münchen.de`.

> The 2.x branch uses `str_contains` for the `/` and `:` tests, so — unlike the old 1.x
> `strpos` code — a delimiter at string position 0 is detected normally. Pass a clean
> domain/URL/email for deterministic behavior. The library returns non-IDN / malformed input
> largely verbatim (it does not validate that a value is a real domain), so callers should not
> treat the output as a trust/validation decision — it is a format conversion only.

## Demo page

- Route `idna` → path `/idna`, controller `Drupal\idna\Controller\Page::demo`, title
  "IDNA Convert Service" (`idna.routing.yml`). The controller injects `form_builder` via
  `create()` and returns a render array embedding the two forms.
- Requirement: `_permission: 'access idna'` (defined in `idna.permissions.yml`, title
  "IDNA Convert.", description "Encode/Decode strings." — not granted to anonymous by default).
- Embedded forms:
  - `Drupal\idna\Form\Encode` — form id `idna_encode`.
  - `Drupal\idna\Form\Decode` — form id `idna_decode`.
- Each form has a `Domains` textarea (`input`) inside an open `details` element and an AJAX
  submit (`::ajaxSubmit`). On submit each input line is `trim()`-ed and run through the injected
  service's `encode()` / `decode()`; the joined result is escaped with
  `Drupal\Component\Utility\Html::escape()`, wrapped in `<pre>…</pre>`, and written back into
  `#idna-encode-wrap` / `#idna-decode-wrap` via an `HtmlCommand`. Forms set
  `$form_state->setCached(FALSE)`; `submitForm()` just calls `setRebuild(TRUE)` — nothing is stored.

## Not present (do not look for these)

No settings/config form or `configure` route, no `config/schema` or `config/install`
(no config schema), no hooks (`.module`/`.install` absent), no drush commands, no plugin
types, no field widgets/formatters, no libraries, no submodules. Only dependency is the
composer library `algo26-matthias/idna-convert` (`^4.2`); no Drupal module dependencies.
