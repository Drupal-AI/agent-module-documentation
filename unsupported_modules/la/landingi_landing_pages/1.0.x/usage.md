<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Create landing pages in Landingi and import them into Drupal.

---

Landingi Landing Pages lets you create landing pages without programming skills and import them into your Drupal site — connecting to the Landingi builder via its API so marketing landing pages built in Landingi are pulled in and served on the Drupal site.

**Security warning (as shipped, 1.0.3):** `LandingiApiClient` makes its Landingi API requests with **`'verify' => FALSE`** (TLS certificate verification disabled) while sending the Landingi `apiKey` — so a network MITM can steal the API key and tamper with the pages. **Remove `'verify' => FALSE`** so certificates are validated. Store the API key securely (env-backed). It's shipped by the `landingi` project. Supports Drupal 10 and 11.

---

- Import Landingi landing pages.
- Build pages without code.
- Connect via the Landingi API.
- Serve marketing pages.
- WARNING: API client uses `verify => FALSE`.
- Expose the API key to network MITM.
- Require removing `verify => FALSE`.
- Store the API key securely.
- Ship in the `landingi` project.
- Support Drupal 10 and 11.
- Harden the TLS config.
- Handle landing pages.
- Support Drupal.
- Support Drupal.
- Support Drupal.
