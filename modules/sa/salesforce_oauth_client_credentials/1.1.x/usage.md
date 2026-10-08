<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Salesforce Client credentials Auth Provider provides an OAuth client credentials flow authorization plugin for Salesforce.

---

Salesforce Client credentials Auth Provider adds an OAuth **client-credentials** flow authorization
plugin to the Salesforce Suite — letting Drupal authenticate to the Salesforce API using the client-
credentials grant (a server-to-server flow, no user context), for integrations that sync data with
Salesforce. It is configured at `salesforce.auth_config`, in the Salesforce package.

Use it for server-to-server Salesforce API auth. Security notes: the client-credentials flow uses a
**consumer key/secret** — **store those as secrets** (not in exported config), operate over HTTPS, and grant
the connected app the **minimum** Salesforce permissions needed. It has no access-control role. Configure the
Salesforce OAuth connection.

---

- Provide a Salesforce client-credentials auth plugin.
- Authenticate server-to-server to Salesforce.
- Use the OAuth client-credentials grant.
- Configure at salesforce.auth_config.
- Support Salesforce Suite integrations.
- Store the consumer key/secret as secrets.
- Operate over HTTPS.
- Grant the connected app minimum permissions.
- Have no access-control role.
- Configure the Salesforce connection.
- Handle Salesforce OAuth.
- Sync with Salesforce.
- Authenticate to Salesforce.
- Configure credentials.
- Handle credentials securely.
- Provide the auth plugin.
- Connect to Salesforce.
- Configure OAuth.
- Handle client credentials.
- Authenticate the API.
