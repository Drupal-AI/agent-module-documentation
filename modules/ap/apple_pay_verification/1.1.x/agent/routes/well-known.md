<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Well-known serving routes & controller

## Routes — `apple_pay_verification.routing.yml`

| Route id | Path | Controller | Permission |
| --- | --- | --- | --- |
| `apple_pay_verification.verification` | `/.well-known/apple-developer-merchantid-domain-association` | `ApplePayVerificationController` (invokable) | `access content` |
| `apple_pay_verification.verification_txt` | `/.well-known/apple-developer-merchantid-domain-association.txt` | `ApplePayVerificationController` (invokable) | `access content` |

Both paths are **fixed** — there is no path/query parameter. `access content` is granted to
anonymous by default, which is required here: Apple's verification crawler fetches the file
anonymously. The `.txt` variant exists so tooling that appends the extension also resolves.

## Controller — `src/Controller/ApplePayVerificationController.php`

`final class ApplePayVerificationController extends ControllerBase` with an `__invoke()` method.
Constructor-injects `config.factory` and `entity_type.manager` (via `create()`).

`__invoke()` does exactly:

1. `$fileId = config('apple_pay_verification.settings')->get('verification_file')` — the stored
   managed-file value (array of fids).
2. `$fileId = reset($fileId)` — take the first fid.
3. `$file = entityTypeManager->getStorage('file')->load($fileId)` — load the `file` entity.
4. Return `new CacheableResponse(file_get_contents($file->getFileUri()))` with header
   `Content-Type: text/plain`.

Key points for agents:

- The served file is chosen **only from admin config**, not from the request — no traversal /
  arbitrary-file surface on these routes.
- The response body is always emitted as `text/plain`, so the file contents are not interpreted as
  HTML by the browser.
- Robustness caveat: if `verification_file` is unset (fresh install, form never saved),
  `reset([])` is `false`, `load(false)` returns `null`, and `$file->getFileUri()` raises an error
  (a 500, not a security issue). Upload a file first, then clear cache.
- The response is cacheable; after changing the file, run `drush cr` to avoid serving stale bytes.
