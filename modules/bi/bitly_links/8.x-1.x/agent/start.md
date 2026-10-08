<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bitly Links - agent index

**Bitly Links** generates Bitly short URLs for nodes via the Bitly v4 API. Version **8.x-1.2** (`8.x-1.x`). Core `^9.4 || ^10`.

## Key files
- `src/Service/BitlyLinksManager.php` - `getAccessToken()`, `shorten()`; base `https://api-ssl.bitly.com`.
- `src/Controller/BitlyLinksController.php` - OAuth/admin pages; `src/Form/BitlyLinksAuthorizationForm.php`.

## Security
- All routes require `access administration pages`. HTTPS + default TLS verify. Credentials/token in State. No anon exposure - sound.