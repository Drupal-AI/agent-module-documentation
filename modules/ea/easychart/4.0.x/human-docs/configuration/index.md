# Configuration

Easychart works once the module is enabled and the JavaScript libraries are
installed (see [Installation](../installation/index.md)). This page covers the
admin settings, presets and templates, the permissions, the Chart content type, and
the remote-CSV refresh.

## Open the admin screens

1. Log in as a user with the **Administer easychart settings** permission.
2. Go to **Configuration → Media → Easychart**
   (`/admin/config/media/easychart`).

All of Easychart's admin screens live under this path:

| Screen | Path | Purpose |
|--------|------|---------|
| **Options** (default page) | `/admin/config/media/easychart` | Default chart options applied to new charts |
| **Templates** | `…/templates` | Manage reusable chart templates (standardise look and feel) |
| **Presets** | `…/presets` | Manage reusable chart presets (starting points for editors) |
| **Settings** | `…/settings` | Module settings, including the CSV refresh frequency |
| **Reset options / templates / presets** | `…/reset-options`, `…/reset-templates`, `…/reset-presets` | Confirmation forms that reset each back to defaults |

The stored settings live in the `easychart.settings` config object, whose keys are
`presets`, `templates` and `url_update_frequency`.

## Permissions

- **Administer easychart settings** — required to reach and change the admin screens
  above (defaults, presets, templates, settings).
- **Access full easychart configuration** — when granted, the chart editor exposes
  the *complete* set of Highcharts options. Without it, editors see a reduced set.
  Grant this to power users who need advanced chart control.

## The Chart content type

Enabling the module ships a ready-made **Chart** content type (`node.type.easychart`)
with an Easychart field already attached, plus its form and view displays and an
Entity Embed button. So the quickest way to author a chart is *Content → Add content
→ Chart*.

You can also add an **Easychart** field to any existing content type via *Manage
fields*. Two widgets are available — the default Easychart plugin editor (with the
Handsontable data grid) and the Highcharts Editor — and matching formatters render
the chart read-only in a view mode.

## Presets and templates

- **Presets** give editors ready-made chart starting points, so they don't build
  every chart from scratch.
- **Templates** standardise the look and feel across charts for a consistent style.

Manage both from the admin screens above; use the corresponding *Reset* forms to
return them to the module defaults.

## Remote CSV data and cron

A chart can pull its data from an external CSV URL instead of hand-entered data. The
URL is stored per chart. On cron — throttled by the **CSV update frequency**
(`url_update_frequency`, default **3600** seconds / one hour) — Easychart fetches
each chart's CSV URL, parses it (auto-detecting tab, comma or semicolon separators),
and caches the result back into the chart's data. Tune the frequency on the
*Settings* screen to refresh cached data more or less often.

## Save

Each admin screen has its own **Save** button; changes take effect immediately.
