# LocalGov Waste Collection — manual setup guide

**LocalGov Waste Collection** (`localgov_waste_collection`) gives a council
website a ready-made way for residents to look up their **bin/waste-collection
schedule**. It provides a postcode-based property search form, an address
selector, and a schedule viewer — so a visitor types their postcode, picks their
property, and sees when their bins are collected. Schedules can be downloaded as
an ICS (iCal) calendar, printed with a print-styled layout, and optionally offered
as an uploaded PDF calendar. It was built for the LocalGov Drupal distribution but
has no hard LocalGov dependency.

The module itself is only the interface and the framework. **The actual schedule
data comes from a "data provider" plugin**, and no provider is installed by
default — you must enable and configure one of the provider submodules before the
lookup can do anything. The module ships three: a **CSV** provider (import
property and collection data from CSV files), a **Whitespace** provider (integrate
with the Whitespace Waste Management platform over its API), and a very simple
**example** provider for demos and development. A Webaspx/Routeware provider is in
development.

A quick privacy note worth reading before you launch: lookups are performed **by
address or postcode**, which is personal data. Handle and log those queries in
line with your privacy policy. If you use a provider that calls an external
council API (such as Whitespace), treat its **credentials as secrets** and make
sure the connection uses HTTPS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and turn on a data provider submodule.
2. [Configuration](configuration/index.md) — the base settings form (data
   provider, base path, public holidays), field by field.

## Where it lives in the admin menu

The base module's settings live at **Configuration → Web services → Waste
collection → Settings** (`/admin/config/services/waste-collection/settings`).

Once configured, residents reach the feature from the front end. By default the
base path is `/waste-collection-schedule`. If you already know a property's UPRN
you can link straight to its schedule at
`{base_path}/view/{uprn}`, and a postcode search page lives at
`{base_path}/find?postcode={postcode}`.
