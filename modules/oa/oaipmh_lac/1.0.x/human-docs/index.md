# OAI-PMH LAC — manual setup guide

**OAI-PMH LAC** (`oaipmh_lac`) provides an **OAI-PMH** XML feed of Dublin Core
metadata formatted for harvesting by **Library and Archives Canada (LAC)**. It
defines an `oai_lac` metadata mapping and the metatags that populate it — which you
fill using tokens — so that LAC (or any OAI-PMH harvester) can collect your site's
metadata in the shape LAC expects.

The problem it solves is interoperability with a specific national harvesting
program: it packages the field mapping and metadata format so you do not have to
assemble the LAC Dublin Core profile by hand. It assumes you are running an
**Islandora** repository, and it builds on two other modules — **Metatag DC**
(Dublin Core metatags) and **REST OAI-PMH** (which actually serves the OAI-PMH
endpoint).

Importantly, this module **has no configuration form of its own**. It contributes
the LAC metadata mapping; the actual setup happens in the UIs of the modules it
depends on — REST OAI-PMH for the endpoint and set mappings, and Metatag for the
Dublin Core field values. It is a metadata/interoperability feature with no
access‑control role.

> **Data‑handling note.** OAI-PMH endpoints are designed to be **publicly
> harvestable**, so any metadata you expose is effectively public. Make sure only
> **published/public** content's metadata is included, and review the Dublin Core
> fields for anything sensitive before exposing the feed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — how the feed is configured through the
   REST OAI-PMH and Metatag UIs.

## Where it lives in the admin menu

OAI-PMH LAC adds no settings page of its own. You configure the feed through the
**REST OAI-PMH** module's UI (the OAI-PMH endpoint and set mappings) and the
**Metatag** module's UI (the Dublin Core field values). See
[Configuration](configuration/index.md).
