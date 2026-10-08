<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cloudflare API is a dependency-free client for the Cloudflare v4 API with a neutral credentials contract.

---

Cloudflare API is a standalone client for the Cloudflare v4 management API — PSR HTTP plus a neutral credentials contract (account id + API token) — depending on nothing else in the Cloudflare suite. It's the low-level connectivity layer other Cloudflare modules build on to call Cloudflare's API.

Cloudflare credentials (account id + token) should be stored securely (env/settings.php), never committed. It's a developer/connectivity library with no content or access role of its own. Supports Drupal 10.5+, 11, and 12.

---

- Provide a Cloudflare v4 API client.
- Use PSR HTTP.
- Offer a neutral credentials contract.
- Take account id + token.
- Depend on nothing else in the suite.
- Serve as the connectivity layer.
- Store credentials securely (env/settings.php).
- Never commit credentials.
- Carry no content/access role.
- Support Drupal 10.5+, 11, and 12.
- Underpin the Cloudflare suite.
- Call Cloudflare's API.
- Aid developers
- Handle authentication
- Provide a base client.
- Integrate Cloudflare.
- Manage API access.
- Keep secrets secure
