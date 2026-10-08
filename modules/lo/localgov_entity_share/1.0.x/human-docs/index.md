# LocalGov Entity Share — manual setup guide

**LocalGov Entity Share** (`localgov_entity_share`) provides
[Entity Share](https://www.drupal.org/project/entity_share) functionality tailored
to the **LocalGov Drupal** distribution (the shared Drupal platform used by UK
councils). Entity Share is a content‑syndication system: it lets one Drupal site
**pull** content from another over JSON:API. This module configures and extends
Entity Share so LocalGov councils can pull and share content (such as pages and
services) between sites in the LocalGov ecosystem.

It builds on the Entity Share **client** (`entity_share_client`) — the side that
does the pulling. Content is fetched from remote Drupal sites via JSON:API, which
has two practical implications: configure the remote credentials securely, and only
point it at **source sites you trust**, since the imported content and the way its
access is handled follow Entity Share's own model.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Entity Share Client comes with it).

This module has **no settings form of its own** — it layers LocalGov‑specific
configuration onto Entity Share, which is where you set up remotes and pull
content (see "How to use it").

## Where it lives in the admin menu

The pulling side is configured through the **Entity Share** module's own
administration — where you define remote sites, their credentials, and the channels
of content to import. This module provides the LocalGov‑specific pieces on top of
that; it does not add a separate settings page.

## How to use it

1. On the site that will receive content (the client), configure a **remote** in
   Entity Share pointing at the source Drupal site, with credentials kept secure.
2. Choose the content channel(s) to pull. Only connect to source sites you trust,
   since imported content and its access follow Entity Share's model.
3. Run a pull to import the content. The LocalGov‑specific configuration this module
   ships helps the shared content (pages, services) come across in a way suited to
   LocalGov sites.
