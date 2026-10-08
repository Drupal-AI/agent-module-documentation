<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TAPIS Auth implements TAPIS authentication for Drupal.

---

TAPIS Auth **implements TAPIS authentication** — handling how Drupal authenticates to the TAPIS
science-gateway platform (obtaining/holding TAPIS OAuth/JWT tokens per tenant) so other TAPIS modules can make
authenticated API calls. It depends on the TAPIS Tenant module and provides its own permissions, in the Tapis
package.

Use it as the auth layer for a TAPIS gateway. It is an authentication/integration foundation. Security/data
handling: it obtains and holds **TAPIS access tokens/credentials** — treat these as **sensitive secrets** (store via
the Key module/env, never commit, protect stored tokens), authenticate over HTTPS, and scope token lifetimes.
It has its own permissions. Configure the TAPIS authentication.

---

- Implement TAPIS authentication.
- Obtain/hold TAPIS OAuth/JWT tokens.
- Enable authenticated TAPIS calls.
- Depend on the TAPIS Tenant module.
- Provide its own permissions.
- Serve authentication/integration.
- Hold TAPIS access tokens/credentials (sensitive secrets).
- Store credentials/tokens securely (Key/env, never commit).
- Authenticate over HTTPS + scope token lifetimes.
- Configure the TAPIS authentication.
- Handle TAPIS auth.
- Authenticate to TAPIS.
- Configure the auth.
- Get tokens.
- Handle the tokens.
- Manage credentials.
- Configure TAPIS.
- Handle the integration.
- Secure the tokens.
- Provide TAPIS authentication.
