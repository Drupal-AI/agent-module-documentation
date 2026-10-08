# SynOrders — manual setup guide

**SynOrders** (`synorders`) is a vendor-specific custom orders module in the
**SynapseF** package — one piece of a supplier's e-commerce suite, paired with
modules such as syncart and syncabinet. It handles order processing within that
vendor's context. Its public description is minimal ("Custom synorders"), so it is
not a general-purpose Commerce add-on but part of a larger, purpose-built stack.

Because it is vendor-specific and lightly documented in public, and because it
touches **orders** — that is, money and fulfilment — you should review its actual
behaviour in the context of the Synapse suite before relying on it. Pay particular
attention to how it handles order ownership, order status transitions, and any
price or total calculations. It layers on the access control provided by the rest
of the suite rather than defining its own general-purpose access contract, and it
is not covered by the security advisory policy. There are no submodules and no
listed module dependencies here.

This guide is written for a **human**. If you are an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

SynOrders registers no admin settings page (its `configure` route is null); it is
meant to work as part of the Synapse/SynapseF e-commerce suite rather than as a
standalone, configurable module. Install it alongside the rest of that suite and
consult the vendor's own documentation for how orders are configured and managed.
Because it deals with orders and totals, verify its behaviour in your own
environment before putting it into production.
