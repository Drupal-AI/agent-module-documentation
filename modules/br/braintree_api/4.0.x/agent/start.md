<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Braintree API — agent index

Bootstraps the **Braintree PHP SDK** (env + merchant keys) and dispatches **signature-verified webhooks**.
Depends on `key`. `braintree_api_test` submodule. Provides permissions. Version **4.0.x** (dev). Core
`^9||^10||^11`.

E-commerce/API layer — public `/braintree/webhooks` passes to the SDK's `webhookNotification()->parse()` which
**verifies Braintree's signature** (forged webhooks rejected — verified). **Private key** is a credential
(store via the Key module). No access role beyond permission.
