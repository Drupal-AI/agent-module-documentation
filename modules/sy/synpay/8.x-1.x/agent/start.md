<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# synpay — agent index

A **payment framework (Synapse)** integrating several gateways via pluggable providers (PayKeeper/Robokassa/
CloudPayments/YooKassa/Sberbank/Alfa/…). Config at `synpay.settings`; provides permissions. Version
**8.x-1.54**. Core `^8||^9||^10||^11`.

**Security:** each provider handles the public callback route and verifies it with the gateway's signature
(typically **keyed MD5** `md5(….secret)`). Store each gateway's merchant secret as a **secret**; HTTPS;
**confirm the callback signature is verified server-side before marking an order paid** (review the specific
provider). Confirm test/live.
