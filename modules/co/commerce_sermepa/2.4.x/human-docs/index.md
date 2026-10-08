# Commerce Sermepa / Redsýs — manual setup guide

**Commerce Sermepa/Redsýs Payment Method** (`commerce_sermepa`) is a Drupal
Commerce payment gateway for **Redsýs** (formerly Sermepa), the payment platform
behind most Spanish banks. For a Spanish shop this is usually *the* checkout
gateway rather than one option among several. When a customer pays, they are sent
to the bank's Redsýs page and returned afterwards, and the bank also posts an
asynchronous notification back to confirm the result.

The actual Redsýs protocol — request signing, response verification, and the
parameter encoding the platform requires — is implemented by the
`commerceredsys/sermepa` library (`^1.0.9`), which Composer pulls in for you.
The module itself provides the Commerce gateway plugin and payment forms. It
depends on Commerce's **Payment** module (`commerce_payment`), and Composer
accepts Commerce `^2.0 || ^3.0`.

A useful design detail: the module has **no routing file of its own**. The
gateway's endpoints — including the notification callback the bank posts to —
come from Commerce's own payment routing, which is the correct arrangement
because Commerce already defines and protects those paths. That callback is the
security-critical surface of any redirect gateway (it must be reachable without a
login, since the bank has no session), and it is authenticated by **HMAC
signature**, which the underlying library performs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Redsýs
   protocol library with Composer, then enable it.
2. [Configuration](configuration/index.md) — add the Redsýs gateway and enter
   your bank-provided credentials, field by field.

## Where it lives in the admin menu

There is no separate settings page. You configure it by adding a payment gateway
under **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) and choosing the Sermepa/Redsýs
plugin. See [Configuration](configuration/index.md).
