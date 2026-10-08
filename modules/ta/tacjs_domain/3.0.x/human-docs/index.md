# TacJS Domain — manual setup guide

**TacJS Domain** (`tacjs_domain`) adds **per-domain configuration** to TacJS on
multi-domain Drupal sites. TacJS is the Drupal integration of *tarteaucitron.js*, a
cookie-consent manager that gates third-party scripts (analytics, video embeds,
social widgets and so on) behind visitor consent. On a site that serves several
domains through the **Domain** module, you often want each domain to manage a
different set of consent services — and that is exactly what this module lets you
do.

It sits between two modules it depends on: **Domain** provides the multi-domain
framework, and **TacJS** does the actual consent gating. TacJS Domain simply scopes
TacJS's service configuration per domain, so each domain can enable its own set of
consent-managed services. It lives in the GDPR package and has no access-control
role of its own — as with any consent setup, whether scripts are truly gated
depends on TacJS being configured correctly.

In the 3.x line specifically, this module is only required if you want the feature
that **aggregates JavaScript from the active tarteaucitron services**, reducing
unnecessary script loading. (The 3.x branch requires TacJS 7+ and Domain 3+; the
older 2.x branch pairs with TacJS 6.x and Domain 2.x.)

This guide is written for a **human**. If you are an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Domain and TacJS.

## How to use it

TacJS Domain does not add its own top-level settings page — it extends TacJS's
configuration so that services can be chosen per domain. Configure your consent
services through TacJS as usual; with this module and the Domain module enabled,
you can vary which services are active for each configured domain. The consent
gating itself continues to be handled by TacJS.
