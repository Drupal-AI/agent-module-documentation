# External Hreflang — manual setup guide

**External Hreflang** (`external_hreflang`) lets you declare
`rel="alternate" hreflang` links that point at **other domains**. Drupal's built‑in
hreflang support only covers the languages that live inside this Drupal install, so
it can't tell search engines that, say, the US‑English version of a page lives on a
separate `us.example.com` site. This module fills that cross‑domain gap for SEO and
language/region targeting.

Rather than adding an admin screen of its own, it extends the **Metatag** module. It
provides a single new tag — **External Hreflang** — that appears as a textarea on
every Metatag configuration form: global defaults, per‑content‑type defaults, and
per‑entity overrides. You enter one alternate per line in `langcode|url` form, and
the module emits a standards‑compliant `<link rel="alternate" hreflang="…" href="…">`
tag in the page head for each line. Because the field supports tokens, you can even
build the external URL from the current path.

If the Simple XML Sitemap module is installed, the same external alternates are also
added to your sitemap entries automatically. The module requires Metatag and has no
configuration page, permissions, or Drush commands of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Metatag.

## Where it lives in the admin menu

It has no page of its own. You set the values inside the Metatag admin screens under
**Configuration → Search and metadata → Metatag** (`/admin/config/search/metatag`),
or on an individual entity's Metatag field.

## How to use it

### Choose the level to set it at

The External Hreflang field appears on every Metatag form, so pick the level you
need:

| Level | Where |
|---|---|
| Site‑wide default | Metatag → **Global** |
| Front page | Metatag → **Front page** |
| A whole entity type | Metatag → e.g. **Content** |
| A specific bundle | Metatag → e.g. **Content: Article** |
| A single entity | That entity's own **Metatag** field (an override) |

### Enter the alternates

In the **External Hreflang** textarea, add one alternate per line as
`langcode|url` — the part before the `|` is the hreflang code, and the part after is
the absolute external URL:

```
en-US|https://us.example.com
es-ES|https://es.example.com
fr-CA|https://ca.example.com/fr
```

Use precise language/region codes like `en-US`, `es-ES`, or `fr-CA` for accurate
targeting. Lines that aren't exactly `code|url` are rejected when you save.

Each line becomes a `<link rel="alternate" hreflang="…" href="…">` tag in the page's
`<head>`.

### Build URLs dynamically with tokens

The field supports tokens, so you can append the current relative path to a base
domain, for example:

```
en-US|https://us.example.com[current-page:url:relative:en]
```

### XML sitemap

If you have the Simple XML Sitemap module, no extra step is needed — the same
external hreflang alternates are added to your sitemap entries automatically.
