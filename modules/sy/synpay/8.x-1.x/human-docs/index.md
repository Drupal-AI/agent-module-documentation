# synpay — manual setup guide

**synpay** (`synpay`) is the Synapse payment framework. It integrates several
payment gateways through pluggable providers, each handling the redirect and
callback flow for its own gateway. The bundled providers lean toward the Russian and
Ukrainian market — Alfa, CloudPayments, PayKeeper, Robokassa, Sber (and SberCredit /
SberInstallment), Sgb, Tinkoff (and TinkoffCredit / TinkoffDolyame) and YooKassa —
so if you sell through one of those gateways, synpay gives you the payment forms and
callback handling to accept payments through it.

The module needs configuration to be useful: you choose and configure the gateway(s)
you use on its settings form at the `synpay.settings` route, entering each gateway's
merchant credentials. It provides its own permissions and belongs to the Synapse
package. It has no other module dependencies and ships no submodules. Note that
issues on drupal.org are expected to be filed in Russian, and the module is not
covered by the security advisory policy.

Because this is a payment integration, a few security points matter more than usual,
and they are covered in detail on the [Configuration](configuration/index.md) page:
store every gateway's merchant secret as a real secret, run everything over HTTPS,
and make sure the incoming payment **callback** is signature-verified server-side
before you treat an order as paid. Each provider exposes a public callback route
(`/…/{plugin_name}`) that the gateway calls, and verifies it with the gateway's
signature scheme — typically a keyed MD5 such as `md5(… . secret)`. Confirm that
verification is actually happening for the provider you use, and never fulfil an
order on the strength of an unverified callback.

This guide is written for a **human** setting the module up through the admin UI. If
you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — configure gateways and credentials on
   the settings form, and the security points to check for payment callbacks.

## Where it lives in the admin menu

Once enabled, synpay's settings form is at the `synpay.settings` route. That is where
you enable the gateways you use and enter their credentials. Each gateway also
exposes a public callback route that the payment provider calls back into after a
transaction.
