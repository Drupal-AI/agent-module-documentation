# INEGI MGEM Integration — manual setup guide

**INEGI MGEM Integration** (`inegi_mgem`) connects Drupal to Mexico's **INEGI**
(Instituto Nacional de Estadística y Geografía) geo-statistical web service — the
*Servicio Web del Catálogo Único de Claves Geoestadísticas* — and displays
official state, municipality, and locality records inside Drupal blocks. It is
aimed at Mexican sites that want to surface authoritative geographic and
statistical data without building the integration by hand.

The module ships two block types:

- a **State (MGEM) lookup block**, which shows records for a Mexican state
  identified by its two-digit state key (`cve_ent`); and
- a **Municipal/Locality lookup block**, which shows records for an entire
  municipality — or narrows to a single locality — using the municipality key
  (`cve_mun`) and an optional locality key (`cve_loc`), forming a compound
  geographic key (`cvegeo`).

Behind each block, a small client service calls INEGI's public HTTPS endpoints,
zero-pads your keys to the widths INEGI expects, and decodes the response. The
service is public, so **no API key or account is needed** and there are no secrets
to store. Requests use a five-second timeout, and if INEGI is unreachable the
error is logged and the block simply renders empty rather than breaking the page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings page** for this module. All configuration
happens when you place a block and enter the geographic keys — see "How to use
it" below.

## Where it lives in the admin menu

The module adds no configuration page of its own. You work with it entirely from
**Structure → Block layout** (`/admin/structure/block`), where you place its two
blocks into regions and enter the codes each block should display.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout** and click **Place block** in the region
   where you want the data to appear.
3. Choose either the **State lookup** block or the **Municipal/Locality lookup**
   block.
4. In the block's configuration, enter the relevant INEGI keys:
   - For a state: the **two-digit state code** (`cve_ent`).
   - For a municipality: the state code plus the **three-digit municipality code**
     (`cve_mun`), and optionally a **locality code** (`cve_loc`) to filter down to
     a single locality.
5. Save the block. It will fetch the matching records live from INEGI and display
   them to visitors.

> **Tip:** A Spanish translation (`es`) ships with the module in its
> `translations/` folder — import it under **Configuration → Regional and
> language → User interface translation** if your site runs in Spanish.
