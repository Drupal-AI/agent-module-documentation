# Gotenberg — manual setup guide

**Gotenberg** (`gotenberg`) integrates the [Gotenberg](https://gotenberg.dev)
document-conversion service with Drupal: it sends HTML (or a URL) to a Gotenberg
instance and gets back a **PDF**, giving you high-fidelity, Chromium-based PDF
rendering. It wraps the `gotenberg/gotenberg-php` package with a little Drupal
configuration and a wrapper class you can use from code.

The module also registers an [Entity Print](https://www.drupal.org/project/entity_print)
plugin, so if you already use Entity Print to produce PDFs of nodes and other
entities, you can switch its rendering back-end to Gotenberg.

Gotenberg itself is a separate service that runs a headless browser — you point
this module at its endpoint URL. That endpoint is admin-configured, and there is an
important security consideration around it (see below and
[Configuration](configuration/index.md)). The module has no access-control role of
its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — point the module at your Gotenberg
   endpoint.

## Where it lives in the admin menu

The settings form is gated by the **Administer Gotenberg settings**
(`administer gotenberg settings`) permission; you can reach it from the
**Configure** link next to the module on the *Extend* page (`/admin/modules`).

## How to use it

Once the endpoint is configured, generate PDFs through the module's wrapper class
from your own code, or — if you use Entity Print — select Gotenberg as the print
engine and produce PDFs of your entities as usual.
