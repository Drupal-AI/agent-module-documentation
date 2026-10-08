<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Obfuscate: service, Twig, and method classes

## Service `obfuscate_mail`

Class `Drupal\obfuscate\ObfuscateMail` (implements `ObfuscateMailInterface`), constructed with the
config factory. Its constructor reads `obfuscate.settings:obfuscate.method` and instantiates the
matching method via `ObfuscateMailFactory::get($method)`, then delegates to it.

```php
$obfuscateMail = \Drupal::service('obfuscate_mail');   // prefer DI
$build = ['#markup' => \Drupal::service('renderer')->render(
  $obfuscateMail->getObfuscatedLink('terry.jones@spam.com')
)];
```

### Interface methods

| Method | Returns | Notes |
|---|---|---|
| `getObfuscatedLink($email, array $params = [], $text = '')` | render array (`#theme` `email_link` or `email_rot13_link`) | `$params` = extra `<a>` attributes (default `rel="nofollow"` for html_entity); `$text` = optional link inner text. |
| `obfuscateEmail($email)` | string | The obfuscated address (entities or ROT13), without the surrounding `<a>`. |

## Twig extension

`TwigExtension` (service `obfuscate_mail.twig_extension`) wraps the service:

| Twig | Maps to |
|---|---|
| `{{ 'a@b.com'\|obfuscateMail }}` | `getObfuscatedLink($mail)` |
| `{{ obfuscate('a@b.com', 'Email us') }}` | `getObfuscatedLink($mail, [], $text)` |

## Method classes (behind the factory)

`ObfuscateMailFactory` (`html_entity` → `ObfuscateMailHtmlEntity`, `rot_13` → `ObfuscateMailROT13`;
unknown method throws `InvalidArgumentException`).

- **`ObfuscateMailHtmlEntity`** — `obfuscateEmail()` randomly encodes ~25% of characters (always
  `.`/`@`/`:`) as decimal or hex HTML entities; `getObfuscatedLink()` additionally URL-encodes the
  `mailto:` href and `htmlspecialchars()`-escapes attribute values, themed as `email_link`.
- **`ObfuscateMailROT13`** — `obfuscateEmail()` runs `Xss::filter()` on the input, then for each
  matched address emits `<span class="js-enabled">` (ROT13 via `str_rot13`, `Html::escape`d) plus
  `<span class="js-disabled">` (reversed text fallback), themed as `email_rot13_link` which
  attaches library `obfuscate/rot13`. `js/rot13.js` (`Drupal.behaviors.obfuscateRot13`) rotates it
  back client-side and rebuilds a real `mailto:` link (using `DOMParser`, not `innerHTML`, to avoid
  executing script).

## Theme hooks

`obfuscate_theme()` registers `email_link` and `email_rot13_link` (variable `link`), templates in
`templates/email-link.html.twig` / `templates/email-rot13-link.html.twig`.
