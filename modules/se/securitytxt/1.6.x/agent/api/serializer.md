<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# securitytxt — serving & serializer

## Routes (`securitytxt.routing.yml`)

| Route | Path | Controller / form | Permission |
|---|---|---|---|
| `securitytxt.configure` | `/admin/config/system/securitytxt` | `SecuritytxtConfigureForm` | `administer securitytxt` |
| `securitytxt.sign` | `/admin/config/system/securitytxt/sign` | `SecuritytxtSignForm` | `administer securitytxt` |
| `securitytxt.securitytxt_file` | `/.well-known/security.txt` | `SecuritytxtController::securitytxtFile` | `view securitytxt` |
| `securitytxt.securitytxt_signature` | `/.well-known/security.txt.sig` | `SecuritytxtController::securitytxtSignature` | `view securitytxt` |

The two `/.well-known/*` routes set `_disable_route_normalizer: 'TRUE'` so the dotted path is
preserved, and respond with `Content-Type: text/plain`.

## Serializer service

`securitytxt.serializer` → `Drupal\securitytxt\SecuritytxtSerializer` (constructor arg
`@date.formatter`). It reads a `securitytxt.settings` config instance and builds the file body.

```php
$content = \Drupal::service('securitytxt.serializer')
  ->getSecuritytxtFile(\Drupal::config('securitytxt.settings'));
```

Behaviour of `getSecuritytxtFile()`:
- If `enabled` is falsy → throws `NotFoundHttpException` (this is why disabled = HTTP 404).
- Otherwise appends one line per non-empty field, in this order:
  `Contact: mailto:` (email), `Contact: tel:` (phone), `Contact:` (page url), `Encryption:`,
  `Expires:` (timestamp formatted as `\DateTime::ATOM`), `Policy:`, `Acknowledgments:`,
  `Hiring:`, then — if `enabled_signature` — the whole body so far is wrapped between
  `-----BEGIN PGP SIGNED MESSAGE-----` and a `-----BEGIN/END PGP SIGNATURE-----` block built
  from `signature_text`; then `Preferred-Languages:` and finally one `Canonical:` line per
  input line that starts with `https://` (others are silently skipped).

`getSecuritytxtSignature()` returns `signature_text` when `enabled`, else throws
`NotFoundHttpException`.

## Quick live check

```bash
curl -s https://<site>/.well-known/security.txt        # 200 text/plain when enabled
curl -s -o /dev/null -w '%{http_code}\n' https://<site>/.well-known/security.txt  # 404 when disabled
```

No plugins, hooks-for-others, or Drush commands are provided; `hook_help()` is the only
module-file hook. The only other form (`SecuritytxtSignForm`) just captures `signature_text`.
