<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Vipps MobilePay provides integration with Vipps MobilePay.

---

Vipps MobilePay provides the **base integration with the Vipps MobilePay platform** — the Nordic mobile
payment/identity service — offering the API client/services other modules (e.g. the Commerce integration) build
on. It depends on core Telephone, provides its own permissions, in the Contrib package.

Use it as the foundation for Vipps MobilePay features. It is a payment/integration base. Security/data handling:
it authenticates to Vipps MobilePay with **merchant API credentials** (client id/secret, subscription key) —
store them as **secrets** (env/Key) over HTTPS. On its own it is a client library; payment flows/verification
live in the consuming module (e.g. Commerce). It has no access-control role beyond its permission. Configure the
Vipps MobilePay credentials.

---

- Integrate the Vipps MobilePay platform.
- Provide the API client/services.
- Support Nordic mobile payments.
- Depend on core Telephone.
- Provide its own permissions.
- Serve as a base for Vipps features.
- Authenticate with merchant API credentials.
- Store the credentials as secrets over HTTPS.
- Let consuming modules handle payment flows.
- Have no access-control role beyond permission.
- Configure the Vipps credentials.
- Handle Vipps integration.
- Provide the client.
- Configure the credentials.
- Connect to Vipps.
- Handle the integration.
- Serve payments.
- Base Vipps features.
- Secure the credentials.
- Provide Vipps MobilePay integration.
