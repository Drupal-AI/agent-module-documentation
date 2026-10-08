# Country — manual setup guide

**Country** (`country`) adds a simple, standards‑based **country field** to
Drupal. It stores a two‑letter ISO 3166 country code (like `US`, `GB`, or `FR`)
and resolves it to a localized, human‑readable country name for display. You can
add it to any fieldable entity — content types, user profiles, taxonomy terms —
whenever you need to capture "which country": a shipping or billing country, a
member's nationality, a product's country of origin, and so on.

Because it stores a validated ISO code rather than free text, the data stays
clean and consistent across your whole site, and it plays nicely with search,
filtering, and imports. The field ships with two **widgets** for data entry — a
**select dropdown** (the default) and a **type‑ahead autocomplete** — and two
**formatters** for display — one that shows the localized **country name** (the
default) and one that shows the raw **ISO code**. A per‑field setting lets you
restrict which countries are offered, so a select can list only the countries
you actually operate in.

Country also integrates with the wider Drupal ecosystem: a **Views** filter and
sort (sort by name or by code), a **Facets** processor that shows country names
instead of codes in facet links, a **Feeds** target for importing country
values, a reusable `country` form element for custom forms, and a token that
prints a country's name in emails or paths. There is **no admin settings page** —
everything is configured through the standard Field UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Country has no settings page of its own. You add and configure a country field
wherever you manage fields — for a content type that is **Structure → Content
types → [type] → Manage fields**, then the matching **Manage form display** and
**Manage display** tabs for its widget and formatter.

## How to use it

### Add a country field

1. Go to **Manage fields** for your entity bundle (e.g. *Structure → Content
   types → Article → Manage fields*).
2. Click **Add field** and choose **Country**.
3. Give it a label and save through the field settings.

### Restrict the offered countries (optional)

On the field's settings there is a **Selectable countries** option. Leave it
empty to offer every country, or pick a subset (for example just the countries
you ship to) to limit what appears in the widget.

### Choose how people enter it

On **Manage form display**, set the field's widget:

- **Country** (`country_default`) — a **select dropdown**. This is the default.
- **Country autocomplete** (`country_autocomplete`) — a text field with
  type‑ahead **autocomplete**; it has optional **size** and **placeholder**
  settings.

### Choose how it displays

On **Manage display**, set the field's formatter:

- **Country** (`country_default`) — shows the localized **country name** (e.g.
  "United States"). This is the default.
- **Country ISO code** (`country_iso_code`) — shows the raw **ISO code** (e.g.
  `US`).

### Beyond the field

- **Views** — add the country field as a **filter** (including an exposed filter
  for a directory listing) or a **sort** (by name, or by ISO code).
- **Facets** — enable the **Country name** processor on a facet so links show
  country names instead of codes (requires the Facets module).
- **Feeds** — map an incoming column to the field with the **Country** target
  (requires the Feeds module).
- **Token** — use `[<entity>:<field>:country_original_name]` (for example
  `[node:field_country:country_original_name]`) to print the country name in
  emails, Pathauto patterns, and the like.
- **Custom forms** — developers can drop a `#type => 'country'` element into any
  form to get a pre‑populated country select; see the
  [`agent/api/api.md`](../agent/api/api.md) reference.
