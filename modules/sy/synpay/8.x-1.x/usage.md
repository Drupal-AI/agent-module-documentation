<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
synpay is the Synapse payment module, integrating several payment gateways.

---

synpay (Synapse payment) is a payment framework that integrates several payment gateways through
pluggable providers — including RU/UA gateways (PayKeeper, Robokassa, CloudPayments, YooKassa, Sberbank/
SberQR, Alfa, etc.) — each provider handling the redirect/callback flow for its gateway. It is configured at
`synpay.settings`, provides its own permissions, in the Synapse package.

Use it to accept payments through one of the supported gateways. Security-relevant points for payment
callbacks: each gateway provider handles the payment **callback** (`/…/{plugin_name}`, a public robots
callback route) and verifies it using the gateway's signature scheme — these gateways typically use a
**keyed MD5 signature** (e.g. `md5(… . secret)`), which the provider computes/compares. When adopting: store
each gateway's **merchant secret/key as a secret**, operate over HTTPS, and — as with any payment integration
— **confirm the callback signature is verified server-side before the order is marked paid/fulfilled** (don't
trust an unverified callback), reviewing the specific provider you use. Confirm test vs live. It is an
e-commerce/payment feature. Configure the gateway credentials.

---

- Integrate several payment gateways.
- Support PayKeeper/Robokassa/CloudPayments/YooKassa/etc.
- Handle redirect/callback per gateway.
- Configure at synpay.settings.
- Provide its own permissions.
- Verify callbacks with the gateway's signature (keyed MD5).
- Store each gateway's merchant secret as a secret.
- Operate over HTTPS.
- Confirm the callback signature is verified before fulfilling.
- Not trust an unverified callback.
- Confirm test vs live mode.
- Review the specific provider you use.
- Handle payments.
- Configure gateway credentials.
- Accept payments.
- Handle credentials securely.
- Process the callback safely.
- Configure the gateways.
- Handle payment callbacks.
- Integrate gateways.
