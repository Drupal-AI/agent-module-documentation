<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SIBS API provides base integration with the SIBS payment API.

---

SIBS API **provides base integration with the SIBS API** — the client/service layer for talking to SIBS (a
Portuguese/Iberian payment provider) API, used by higher-level modules (e.g. SIBS API Commerce) to create and query
payments. It provides its own permissions, in the SIBS package.

Use it as the SIBS API foundation. It is a payment/integration base library. Security/data handling: it **calls the
SIBS payment API** (egress) with **merchant credentials/API keys** — store those as **secrets** (env/Key) and serve
over HTTPS, since they authorize payment operations. Payment status should always be taken from SIBS's authoritative
API (which this layer provides). It has its own permissions. Configure the SIBS credentials.

---

- Provide base SIBS API integration.
- Talk to the SIBS payment API.
- Underpin SIBS Commerce.
- Provide its own permissions.
- Serve payment/integration.
- Create/query payments.
- Call the SIBS payment API (egress) with merchant credentials.
- Store the credentials/API keys as secrets (env/Key, HTTPS).
- Take payment status from SIBS's authoritative API.
- Have its own permissions.
- Configure the SIBS credentials.
- Handle SIBS API.
- Call SIBS.
- Configure the client.
- Query payments.
- Handle the integration.
- Authenticate to SIBS.
- Fetch status.
- Secure the credentials.
- Provide SIBS API integration.
