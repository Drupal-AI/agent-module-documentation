# Braintree API — manual setup guide

**Braintree API** (`braintree_api`) is the low-level integration layer for
Braintree, the PayPal-owned payment gateway. It is not a checkout or a payment
form on its own — it is the plumbing that other payment modules build on. It does
two jobs: it bootstraps the official Braintree PHP SDK with your credentials
(sandbox or production environment, plus your merchant, public, and private
keys), and it exposes a webhook endpoint that receives Braintree's notifications
and re-dispatches them to other modules as Drupal events.

The webhook side is built carefully. The public route `/braintree/webhooks`
passes the incoming signature and payload straight to the SDK's
`webhookNotification()->parse()`, which **verifies Braintree's signature** and
throws if it does not match. That means a forged webhook is rejected, and only
genuine, signed notifications from Braintree ever become events on your site.

Because this module holds payment credentials, credential handling matters. It
depends on the **Key** module, and the private key in particular is a secret that
must never be committed to config or code — store it as a Key entity backed by an
environment variable. See [Configuration](configuration/index.md) for the honest
credential workflow.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements (including the Key
   module), installing with Composer, and enabling the module.
2. [Configuration](configuration/index.md) — entering the Braintree environment
   and keys, and handling the private key as a secret.

## Where it lives in the admin menu

Braintree API provides a settings form (under **Configuration**) where you choose
the environment and enter your Braintree credentials, plus its own permissions to
control who can reach it. The webhook endpoint sits at `/braintree/webhooks` and
is meant to be called by Braintree, not by people.

## How to use it

On its own this module does not take payments — it is a base layer. You install
it, enter your Braintree credentials, and then install a payment module that
depends on it to actually run transactions. Those modules listen for the events
this module dispatches when a verified webhook arrives (for example a completed
or disputed payment). Point your Braintree account's webhook URL at
`/braintree/webhooks` so notifications flow in.
