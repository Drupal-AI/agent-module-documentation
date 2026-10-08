<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate API Key adds a migration plugin that appends an API key to URL-sourced migration requests.

---

Migrate API Key **appends an API key to migration source URLs** — a `migrate_api_key_url_plugin` data-fetcher
plugin that adds an API key to the GET requests Migrate makes to URL sources, so migrations can pull from
key-protected APIs. It depends on the Migrate and Migrate Plus modules.

Use it to migrate from API-key-protected sources. It is an import/migration feature. Security/data handling: the
**API key is appended to the request URL (query string)** — URLs (with the key) can be recorded in **server/proxy
logs, browser history or referrers**, so treat the key as sensitive, prefer sources that accept the key in a header
where possible, store the key as a secret (not committed), and use HTTPS so the query string is encrypted in
transit. It has no access-control role. Configure the API key in the migration.

---

- Append an API key to migration URLs.
- Fetch from key-protected APIs.
- Provide a URL-fetcher plugin.
- Depend on Migrate + Migrate Plus.
- Serve import/migration.
- Add the key to GET requests.
- PUT the key in the URL query string (logs/history/referrer risk).
- Prefer header-based keys + store the key as a secret (not committed).
- Use HTTPS so the query string is encrypted in transit.
- Have no access-control role.
- Configure the API key in the migration.
- Handle keyed migration.
- Append the key.
- Configure the plugin.
- Fetch sources.
- Handle the migration.
- Pull data.
- Authenticate requests.
- Secure the key.
- Provide keyed migration fetching.
