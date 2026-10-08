# Sinoptik.ua Weather Informer — manual setup guide

**Sinoptik.ua Weather Informer** (`sinoptik_weather`) provides a configurable block
that embeds the weather widget from sinoptik.ua — a weather-information site covering
mostly Ukraine — for one or more cities you choose. Fully supported languages are
Ukrainian and Russian, with limited support for English and Polish.

You place the block, pick the widget language, choose a colour scheme and width, and
select cities through an autocomplete field. Behind the scenes the block talks to
sinoptik.ua to resolve city names and spellings, and the actual weather informer is
drawn on the page by sinoptik.ua's own remote assets — the module attaches a small
script and passes your chosen city IDs and language through to it. Everything you
configure happens in the block's own settings when you place it, so there is no
separate admin settings page.

By using this module you agree to sinoptik.ua's terms, conditions and user agreement,
since the widget loads remote assets and city data from that third-party service.

A couple of things worth knowing about how it fetches data: the city autocomplete is
served by a route that is available to anonymous visitors, and it is read-only — it
only issues a request to a fixed sinoptik.ua endpoint with the term you type. Because
the destination host is a hard-coded constant, a visitor cannot redirect it to an
internal address, so there is no server-side request forgery risk; the worst case is
triggering outbound searches to sinoptik.ua.

This guide is written for a **human** placing the block through the admin UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.

## How to use it

Sinoptik.ua Weather Informer is configured entirely through block placement, not a
settings form:

1. Go to **Structure → Block layout** and place the **Sinoptik.ua Weather Informer**
   block in the region where you want the weather to appear.
2. In the block's configuration, choose the **language** (Ukrainian, Russian, English
   or Polish), the **colour scheme**, and the **width** (fit or a fixed pixel value).
3. Use the **autocomplete field** to search and select the city or cities to display —
   the field looks up city names from sinoptik.ua as you type.
4. Optionally restrict where the block appears using Drupal's standard block
   visibility settings.

Save the block, and the sinoptik.ua weather informer will render for your selected
cities.
