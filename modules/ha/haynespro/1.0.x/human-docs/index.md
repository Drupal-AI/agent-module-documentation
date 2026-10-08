# HaynesPro — manual setup guide

**HaynesPro** (`haynespro`) integrates the
[HaynesPro](https://www.drupal.org/project/haynespro) vehicle technical-data API
with Drupal. HaynesPro is an automotive data service — a VRM (vehicle
registration mark) lookup returns detailed technical data about a vehicle
(engine code, tyres, MOT information, and up to around 150 fields), sourced from
a live feed. With this module a site — typically a garage, workshop, or car-parts
site — can look those details up through HaynesPro's WebAPI and display them.

The module talks to HaynesPro's service using credentials that HaynesPro issues
to you. Those credentials are handled through a **Key** entity (the module
depends on the [Key](https://www.drupal.org/project/key) module) so the actual
secret lives in the environment rather than in committed configuration. The
[Configuration](configuration/index.md) page covers this and the egress the
integration needs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside the Key module.
2. [Configuration](configuration/index.md) — storing the HaynesPro API
   credentials securely and connecting Drupal to the service.

## Where it lives in the admin menu

This is a `1.0.0-alpha3` release and it is minimally maintained, so expect a
lean admin surface. You configure the HaynesPro connection through Drupal's
configuration together with a Key entity that holds the credentials — see
[Configuration](configuration/index.md) for the workflow.
