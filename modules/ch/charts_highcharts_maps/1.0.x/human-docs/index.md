# Charts Highcharts Maps — manual setup guide

**Charts Highcharts Maps** (`charts_highcharts_maps`) extends the **Charts**
module to draw **maps** using the **Highcharts Maps** library — for example
choropleth (colour‑by‑region) maps driven by your Drupal data. It's an add‑on to
the Charts ecosystem: on its own it has no user‑facing features, and it relies on
Charts to provide the charting framework.

**Licensing is the first question, not the last.** Highcharts is **not free for
commercial use** — it's free for personal and non‑profit use, but a paid licence
is required otherwise — and **Highcharts Maps is licensed separately** from
Highcharts itself. Establish where you stand on both licences before adopting this
module; the Charts module supports other libraries with different terms if the
licensing doesn't fit.

A note on how it serves map data: the module exposes an endpoint at
`/charts-highmap/map-data/{json_field_name}/{taxonomy_term}` that is gated by a
**custom access check** (rather than a single flat permission), because whether a
request should be allowed depends on the specific field and taxonomy term being
requested. If you customise this module, **leave that access callback intact** —
it is the safeguard between the endpoint and arbitrary field reads.

The Highcharts Maps library is **not bundled** with the module; you install it
separately and then confirm it on the site's status report.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the
   Highcharts Maps library, and enable the module.

There is **no settings form specific to this module**. Maps are configured through
the Charts module and Views like any other chart — see "Where it lives" below.

## Where it lives in the admin menu

This module adds no settings page of its own. You work with it through the
**Charts** module's settings at **Configuration → Content authoring → Charts**
(`/admin/config/content/charts`) and the **Views UI**, building a map chart the
same way you build other Charts visualizations once the Highcharts Maps library is
present.
