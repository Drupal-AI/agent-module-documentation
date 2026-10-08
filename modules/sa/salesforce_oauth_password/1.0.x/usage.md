<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Salesforce OAuth Password Provider provides password-based Salesforce OAuth authentication.

---

Salesforce OAuth Password Provider adds a **password-based** (OAuth username-password grant)
authentication provider to the Salesforce Suite — authenticating Drupal to Salesforce using a Salesforce
**username + password + security token** (plus the connected app's consumer key/secret). It is in the
Salesforce package.

Use it where the Salesforce username-password OAuth flow is required. **Security caveat: this flow stores and
uses a Salesforce user's password** (with the security token appended) — so store the **username, password,
security token, and consumer key/secret all as secrets** (never in exported config or code), operate over
HTTPS, and use a dedicated integration user with least-privilege Salesforce permissions. Note that the
username-password OAuth flow is **less secure and is being deprecated/restricted by Salesforce** in favour of
the JWT bearer or client-credentials flows — prefer those where possible. It has no access-control role.
Configure the Salesforce credentials.

---

- Provide password-based Salesforce OAuth.
- Use the username-password grant.
- Authenticate with username+password+security token.
- CAVEAT: stores a Salesforce password.
- Store all credentials as secrets.
- Operate over HTTPS.
- Use a dedicated least-privilege integration user.
- Know the password flow is less secure/deprecated.
- Prefer JWT bearer or client-credentials flows.
- Have no access-control role.
- Configure the Salesforce credentials.
- Handle credentials securely.
- Authenticate to Salesforce.
- Configure the connection.
- Handle the password flow.
- Store the security token securely.
- Provide the auth provider.
- Configure OAuth.
- Handle Salesforce auth.
- Authenticate the API.
