# Location Selector — manual setup guide

**Location Selector** (`location_selector`) lets editors assign content to one or
more **locations** — continents, countries, regions, cities — by adding a
purpose-built field to any fieldable entity. Instead of leaning on taxonomy
vocabularies (which get unwieldy and slow once you try to hold the whole world),
it draws its location data from the **GeoNames** location API, which offers a huge,
Creative-Commons-licensed database. That keeps your site fast and spares you from
importing and maintaining enormous location vocabularies yourself.

The field presents a **hierarchical select** experience: editors pick from top to
bottom (continent → country → region → …) through cascading select lists, and you
decide how deep they can go. Location labels are shown in the current user's
language automatically. You can define a **basic parent location** to scope what's
selectable (the whole world, or just one continent or country), force editors to
choose down to the deepest level, and choose whether to save only the last
selected element or the full parent chain.

It also integrates with **Views** — add the field as an exposed filter to let
visitors filter content by location — and the field formatter can link a selected
location to a custom View that already uses the field as a filter, so a location
becomes a clickable link to "everything here."

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add your GeoNames username, then add
   and configure the field.

## Where it lives in the admin menu

The module's settings (the GeoNames username) live at **Configuration → Location
Selector → Settings** (`/admin/config/location_selector/settings`). The field
itself is added and tuned through the standard Field UI on your content type's
**Manage fields**, **Manage form display**, and **Manage display** tabs.

## How to use it

1. Create a free GeoNames account (see Configuration) and enter the username in
   the module settings.
2. On your content type's **Manage fields**, add a **Location Selector** field.
3. On **Manage form display**, configure the widget — the parent location, how
   many child levels to show, whether to force the deepest level, and whether to
   save only the last selected element.
4. On **Manage display**, configure the field formatter — including, optionally,
   linking selected locations to a custom View.
