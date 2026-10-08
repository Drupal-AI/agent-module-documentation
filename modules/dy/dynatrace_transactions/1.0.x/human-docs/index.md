# Dynatrace Transactions — manual setup guide

**Dynatrace Transactions** (`dynatrace_transactions`) gives the requests Drupal
serves **meaningful names inside Dynatrace**, so your APM dashboards show something
readable instead of a wall of generic PHP entry points. It builds each transaction
name from three parts of the request: the **route**, the **entity bundle**, and the
**user's highest‑weight role** — so you can tell an anonymous article view apart
from an editor saving a page, for example, when you're looking at performance data.

It's a port of the well‑liked **New Relic Transactions** module, adapted for
Dynatrace. Dynatrace has no PHP extension of the same kind, so the module works by
computing a transaction name and exposing it as a value Dynatrace can capture as a
**request attribute** — which you then tell Dynatrace to use as the transaction
name. It works across Drupal 8 through 11 and depends only on core.

Because of how that capture works, **most of the setup is on the Dynatrace side,
not in Drupal.** Once the module is installed and producing names, you configure
your Dynatrace environment to capture the name as a request attribute and to name
transactions from it. There is **no Drupal settings form** to fill in.

One privacy note worth flagging: the transaction names include the **user's role**,
which is operational metadata sent to Dynatrace. That's low‑sensitivity, but it does
mean role information leaves your infrastructure — so keep the Dynatrace destination
a trusted one, and confirm that outbound flow fits your data‑handling policy. The
module has no access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** in Drupal for this module — it has no settings
form. The remaining setup happens in your Dynatrace environment, described below.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)). Once
   enabled, it begins computing transaction names from route, bundle, and role.
2. In your **Dynatrace** environment, configure a **request attribute** that
   captures the transaction name the module exposes (by capturing the value returned
   from the relevant PHP method call).
3. Still in Dynatrace, configure **transaction (service request) naming** to use
   that request attribute, so your services and dashboards display the readable
   names.

After that, new requests appear in Dynatrace under names built from their route,
bundle, and the acting user's highest‑weight role.
