# OpenAgenda — manual setup guide

**OpenAgenda** (`openagenda`) connects your Drupal site to the
[OpenAgenda](https://openagenda.com) platform — a shared event‑publishing and
aggregation service — and surfaces its events on your site. Rather than
maintaining events as local Drupal content, you point the module at an OpenAgenda
agenda (by its UID) and it displays that agenda's events: listings, single‑event
pages, and filtered views. It's a common fit for cultural and municipal sites
that already curate their events in OpenAgenda.

The module ships an **OpenAgenda field**, a matching field widget and formatter
so you can attach an agenda to any content type, and a default **OpenAgenda
content type** so you can get started out of the box. On top of that it provides
eight block‑based **filter types** — map, calendar, per‑tag, relative date, text
search, favorites, keywords, and an additional‑field filter — that you place as
blocks to let visitors narrow the event list. It depends on core's Node, Field,
and Serialization modules, and includes interface‑translation support.

Because the event data comes from the external OpenAgenda service, what your site
can display depends on that service and its API being available. Configuration
includes an OpenAgenda API key and the agenda identifier — treat the API key as a
secret (see [Configuration](configuration/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its core dependencies.
2. [Configuration](configuration/index.md) — enter your OpenAgenda API key and
   agenda details, and place the filter blocks.

## Where it lives in the admin menu

The module's settings form is at route `openagenda.form` — its **OpenAgenda
settings** page — where you enter your API key and connection details. See
[Configuration](configuration/index.md).

## How to use it

Once connected, either use the default **OpenAgenda** content type or add an
**OpenAgenda field** to an existing content type and enter the agenda's UID. The
formatter renders the agenda's events (listing and single‑event pages), and you
place any of the eight **filter blocks** (map, calendar, tags, dates, text
search, favorites, keywords, additional field) at **Structure → Block layout** to
let visitors filter the events.
