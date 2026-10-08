# Pylot Bridge — manual setup guide

**Pylot Bridge** (`pylot_bridge`) connects Drupal to the **Pylot / Bridge CMS**
tourism backend. It imports tourism content — products, listings, GPS traces, and
points of interest — into Drupal, and it exposes a set of front-end endpoints
(product JSON feeds, an image-resizing endpoint, and a contact-email endpoint) that
a site theme uses to render that content. It depends on core **Node** and the
**Components** module, and supports Drupal 9, 10, and 11.

Pylot Bridge is primarily a developer/integration module — there is no settings
form in the admin UI. The Pylot backend credentials are supplied by an
administrator and should be stored securely through the environment rather than
committed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependencies, and store credentials safely.

There is **no configuration page** in the admin UI for this module. Setup is
covered in the installation guide.

## How to use it

Once installed, Pylot Bridge imports tourism data from
the Pylot/Bridge CMS into Drupal nodes and exposes JSON feeds and helper endpoints
that your theme's front-end code consumes to render products, listings, GPS traces,
and points of interest.
