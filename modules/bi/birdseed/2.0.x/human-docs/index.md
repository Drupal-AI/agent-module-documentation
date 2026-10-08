# BirdSeed — manual setup guide

**BirdSeed** (`birdseed`) provides integration with the BirdSeed service, connecting
your Drupal site to that external platform so its features can be used on the site.
It acts as the connectivity layer between Drupal and BirdSeed.

The published documentation for this module is thin: it describes BirdSeed as a
feedback/engagement or analytics service and this module as the bridge to it, but it
does not spell out specific screens or behaviors. Treat the notes below as the
essentials, and check the project page and the module's own README for anything more
detailed.

Because it connects to an external service, it needs BirdSeed API credentials. Those
should be stored securely (backed by an environment variable), not in plain committed
configuration. Administration is gated by the `administer birdseed` permission. See
[Configuration](configuration/index.md) for credential handling.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — store the BirdSeed credentials
   securely and set the administration permission.

## Where it lives in the admin menu

The module defines an `administer birdseed` permission for its administration (set it
under **People → Permissions**, `/admin/people/permissions`) and needs BirdSeed
credentials to reach the service.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Obtain your BirdSeed credentials, store them securely, and connect the module
   (see [Configuration](configuration/index.md)).
3. Grant the `administer birdseed` permission to the roles that should manage the
   integration.
