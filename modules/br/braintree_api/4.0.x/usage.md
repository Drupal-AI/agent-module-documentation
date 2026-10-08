<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Braintree API enables use of the Braintree API library and webhooks.

---

Braintree API is the **low-level integration layer for Braintree** — it configures the official Braintree
PHP SDK (environment sandbox/production, merchant/public/private keys) and provides a **webhook endpoint** that
dispatches Braintree webhook notifications to other modules as events (payment modules build on it). It depends
on the Key module, ships a `braintree_api_test` test submodule, provides its own permissions, in the Braintree
package.

Use it as the base for Braintree integrations. Security posture is sound: the public webhook route
(`/braintree/webhooks`) passes the `bt_signature` + `bt_payload` to the **SDK's `webhookNotification()->parse()`**,
which **verifies Braintree's signature** and throws on mismatch (caught/logged) — so a forged webhook is
rejected and only genuine, signed notifications become events (verified). Handle the **private key** as a
secret — it integrates with the **Key module**, so store it as a Key, not plain config. It has no
access-control role beyond its permission. Configure the Braintree credentials.

---

- Bootstrap the Braintree SDK.
- Configure environment + merchant keys.
- Dispatch Braintree webhooks as events.
- Verify webhook signatures via the SDK.
- Reject forged webhooks (signature parse).
- Integrate with the Key module.
- Store the private key as a secret.
- Provide a braintree_api_test submodule.
- Provide its own permissions.
- Serve as a base for payment modules.
- Have no access-control role beyond permission.
- Configure Braintree credentials.
- Handle the Braintree API.
- Connect to Braintree.
- Handle webhooks.
- Configure the SDK.
- Verify webhooks.
- Provide the API layer.
- Secure the private key.
- Provide Braintree integration.
