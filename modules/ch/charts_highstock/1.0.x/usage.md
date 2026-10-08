<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Highcharts Stock Charts

## What it is / when to use

- Extends the Charts module with the Highcharts Stock (Highstock) library for time-series/stock-style charts.
- Use when you already use Charts + Highcharts and need stock/navigator/range-selector chart types.
- A thin integration/plugin layer on top of Charts.

---

## Install & configure

- Requires `charts` and `charts_highcharts`.
- Enable the module; a Highstock chart type/plugin becomes available in Charts.
- Configure via the Charts UI (per view/field/config) as usual.
- Provide the Highstock JS library per the Charts library-loading conventions.

---

## Usage & API notes

- Registers a Charts type plugin for Highstock via the module's `src/` plugin classes.
- Ships a Views integration include (`charts_highstock.views.inc`).
- Chart configuration is stored through the Charts module's config, not a standalone form.
- Provides config schema for its settings.
- Adds JS under `js/` to initialise Highstock.
- Best for financial/time-series datasets with range selectors and navigators.
- No custom routes, permissions, or anonymous endpoints are added.
- No external network calls from the server — charts render client-side.
- Depends entirely on the host Charts module for data sourcing.
- Highstock library licensing is the site owner's responsibility.
- Extend chart options through Charts' plugin/settings hooks.
- Works with Views-based and field-based charts.
- The `.install` may check for the Highstock library presence.
- Data access follows the underlying view/field permissions.
- Purely additive to the Charts ecosystem.
- Uninstall leaves other Charts libraries unaffected.
