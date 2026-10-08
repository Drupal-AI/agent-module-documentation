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
block‑based **filters** — map, calendar, cities, keywords, favorites, relative
date, text search, and an additional‑field filter — plus sort, submit, total,
and active‑filter blocks, an event map, and an event timetable. You place these
as blocks to let visitors narrow the event list. It depends on core's Node,
Field, and Serialization modules, and includes interface‑translation support.

Version **4.0.x** targets **Drupal 10.4+ or 11** and adds a required Composer
library, `openagenda/sdk-php` — the module talks to the OpenAgenda API entirely
through that SDK. Configuration includes your OpenAgenda account **public key**
and the agenda identifier (see [Configuration](configuration/index.md)). Because
the event data comes from the external OpenAgenda service, what your site can
display depends on that service and its API being available.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   `openagenda/sdk-php` library) and enable the module.
2. [Configuration](configuration/index.md) — enter your OpenAgenda public key and
   agenda details, and place the filter blocks.

## Where it lives in the admin menu

The module's settings form is at **Configuration → Web services → OpenAgenda**
(`/admin/config/services/openagenda`, route `openagenda.form`), where you enter
your public key and connection defaults. Access to that form is controlled by the
**Administer OpenAgenda** permission. See
[Configuration](configuration/index.md).

## How to use it

Once connected, either use the default **OpenAgenda** content type or add an
**OpenAgenda field** to an existing content type and enter the agenda's UID. The
formatter renders the agenda's events (listing and single‑event pages), and you
place any of the **filter blocks** (map, calendar, cities, keywords, favorites,
relative date, text search, additional field) at **Structure → Block layout** to
let visitors filter the events. You must be a member of the OpenAgenda agenda you
want to display.
