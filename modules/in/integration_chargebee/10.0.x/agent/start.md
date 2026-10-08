<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Integration Chargebee — agent index

**Chargebee subscription-billing integration**. Version **10.0.2**. Core `^9||^10||^11`.

`/payment-success` re-fetches the subscription server-side (good) but records it against the current uid WITHOUT an owner check → a user can claim any valid `sub_id` (entitlement/IDOR, D2). Verify ownership; API key env-backed.