# Select2 Boxes — manual setup guide

**Select2 Boxes** (`select2boxes`) turns Drupal's plain `<select>` and
entity‑reference form elements into searchable, type‑ahead dropdowns powered by
the popular [Select2](https://select2.org/) JavaScript library. Instead of
scrolling a long list of taxonomy terms or countries, editors type a few letters
and filter instantly; multi‑value fields become tidy tag‑style "chips."

You can apply it two ways. Precisely, by switching individual fields to one of the
module's three **field widgets** on a form display. Or broadly, by flipping a
**global** switch that applies Select2 to *every* dropdown on the site at once
(with an option to leave admin pages alone). Select2 itself is loaded from a
configurable CDN, so you can pick the version or point it at a self‑hosted copy.

The module leans on core's **Field** module and nothing else. It also ships one
submodule, **Select2 for Better Exposed Filters** (`select2_bef`), which brings
the same searchable widget to Views exposed filters.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally enable the Better Exposed Filters submodule.

## How to use it

There are two ways to switch dropdowns over to Select2.

### Option A — per field (via the widget)

On the entity's **Manage form display** screen (for example *Structure → Content
types → Article → Manage form display*), change a field's widget to one of:

| Widget | Use it on |
|---|---|
| **Select2 autocomplete (single)** | single‑value entity‑reference fields (also supports "auto‑create" new terms inline) |
| **Select2 autocomplete (multi)** | multi‑value entity‑reference fields — renders as tag chips, and can **preload** a set number of options for a faster first interaction |
| **Select2 autocomplete (list)** | list fields (`list_string`, `list_integer`, `list_float`) and language fields |

Each widget exposes a few extra **third‑party settings** via the little gear icon
next to it:

- **Enable preload / preload count** (multi entity‑reference) — pre‑load a capped
  number of options into the widget, or leave the count blank to preload all.
- **Enable flags** (language/country fields) — show flag icons beside options.
  This is only offered when the contributed **Flags** module is enabled.
- **Enable Select2** for the **Address** module's country/zone selects — appears
  when the Address module is installed.

If the entity‑reference field is configured to auto‑create new terms, the single
widget lets editors add a brand‑new referenced entity right from the dropdown.

### Option B — globally, for every dropdown

Go to **Configuration → User interface → Select2 Boxes**
(`/admin/config/user-interface/select2boxes`; requires the *Administer site
configuration* permission). The settings there are:

- **Apply Select2 globally** — enhance every `<select>` on the site at once,
  without touching individual form displays.
- **Disable on admin pages** — when global mode is on, skip administrative
  routes so the back end keeps its plain selects.
- **Limited search / minimum search length** — hide the Select2 search box until
  a list is long enough to need it, and set that length threshold.
- **Provider / version / URL** — where Select2's assets come from. The provider
  is *CDN*, the **version** is one of 4.0.1–4.0.5 (default 4.0.5), and the **URL**
  is the CDN base (default cdnjs/Cloudflare). Edit the URL and version to pin a
  release or self‑host.

Click **Save configuration** to apply.

## Where it lives in the admin menu

The global settings form is at **Configuration → User interface → Select2 Boxes**
(`/admin/config/user-interface/select2boxes`). Per‑field setup happens on each
entity's **Manage form display** page.
