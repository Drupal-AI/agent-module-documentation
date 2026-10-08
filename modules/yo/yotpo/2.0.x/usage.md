<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Yotpo provides a client to connect with the Yotpo API.

---

Yotpo provides a **client** for the Yotpo API — Yotpo is a reviews / user-generated-content / marketing
platform — so Drupal (typically a Commerce store) can talk to Yotpo (fetch/push reviews and related data). It
is configured at `yotpo.settings` (API key), in the Development package.

Use it as the integration layer for a Yotpo-backed reviews/marketing setup. It is an integration feature. It
calls the Yotpo API over **HTTPS** (`https://api.yotpo.com`, via Guzzle with TLS verification on by default) —
good. Handle the **API key** as a secret (store it via the Key module / environment, not committed config).
It has no access-control role. Configure the API credentials.

---

- Connect Drupal to the Yotpo API.
- Fetch/push reviews and data.
- Integrate a reviews/marketing platform.
- Configure at yotpo.settings.
- Call the API over HTTPS.
- Use Guzzle (TLS verification on).
- Store the API key as a secret.
- Serve a Commerce store typically.
- Have no access-control role.
- Configure the credentials.
- Handle the Yotpo client.
- Call the API.
- Integrate Yotpo.
- Handle the integration.
- Connect to Yotpo.
- Configure API access.
- Handle reviews sync.
- Push reviews.
- Configure Yotpo.
- Provide the client.
