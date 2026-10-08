<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Zefix provides access to the Zefix API.

---

Zefix provides **access to the Zefix API** — the Swiss central business names register — so a site can look
up official Swiss company data (company name, UID, registry details) from Zefix. It is in the Development
package.

Use it to query Swiss company registry data. It is an integration feature. Security/data handling: it calls the
**Zefix API** (external egress) and, where the API requires authentication, store any **API credentials** as a
**secret** (env/Key) over HTTPS. Returned company data is public-registry data. It has no access-control role.
Configure the Zefix API connection.

---

- Query the Zefix API.
- Look up Swiss company data.
- Fetch registry details (UID/name).
- Serve integration.
- Use the Swiss business register.
- Return public-registry data.
- Call the Zefix API (egress).
- Store any API credentials as a secret.
- Use HTTPS.
- Have no access-control role.
- Configure the API connection.
- Handle Zefix.
- Look up companies.
- Configure the client.
- Query companies.
- Handle the integration.
- Fetch registry data.
- Search companies.
- Secure the credentials.
- Provide Zefix access.
