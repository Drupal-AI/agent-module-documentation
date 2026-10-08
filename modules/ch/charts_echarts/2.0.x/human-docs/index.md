# Apache ECharts Charts — manual setup guide

**Apache ECharts Charts** (`charts_echarts`) is a rendering backend for the
**Charts** module. It plugs the **Apache ECharts** JavaScript library into Charts,
so any chart you build — through Views, an entity field, or the Charts API/config
— can be drawn with ECharts. On its own it has no user‑facing features; it exists
to give the Charts module another library to render with. Apache ECharts is a
free, open‑source charting library, which makes it an appealing alternative to
libraries with commercial licensing requirements.

Chart data comes from whatever source you point Charts at, and it respects that
source's access — this module adds no access role of its own. This is the **2.0.0**
release and the ECharts integration is still considered experimental, so test it
against your chart types before relying on it in production.

Two general notes for any client‑side chart library apply here too: the plotted
data lives in the page source (aggregate first if the underlying rows are
sensitive), and a chart reads as an image to assistive technology unless you also
provide a data table or text summary.

A small companion submodule, **`charts_echarts_api_example`**, demonstrates
building a chart with ECharts through the Charts API in code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   select ECharts as your charting library.

There is **no settings form specific to this module**. You select ECharts as the
Charts library on the Charts module's own settings page — see "Where it lives"
below.

## Where it lives in the admin menu

Once enabled, choose Apache ECharts as your charting library on the Charts
module's settings page at **Configuration → Content authoring → Charts**
(`/admin/config/content/charts`). Then build charts the usual Charts way: a View
with the **Chart** format, a **Chart** field on an entity type, or the Charts API
in code.
