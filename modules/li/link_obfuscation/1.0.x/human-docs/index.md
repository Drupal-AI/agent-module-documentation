# Link obfuscation — manual setup guide

**Link obfuscation** (`link_obfuscation`) is a light anti‑harvesting helper. It
obfuscates link markup — scrambling or masking it so that automated scrapers and
bots crawling the page cannot easily read the underlying address, while real
browsers still render a working link. It is most often used to reduce harvesting
of email (`mailto:`) addresses and the spam that follows, and, per its own
documentation, it integrates with the **Facets** module to mask facet links on
search pages by replacing them with masked `span` elements.

> **Understand what this does and does not do.** Obfuscation is a **deterrent, not
> a security boundary**. It raises the bar for naive scrapers, but a determined
> harvester that runs JavaScript or parses the encoding can still recover the
> address. Because the working link is typically reconstructed with JavaScript, it
> can also affect no‑JavaScript visitors and accessibility. Use it as a light
> measure to cut down casual harvesting — never rely on it to keep an address
> genuinely private.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no dedicated settings page** for this module. Its documented workflow
turns obfuscation on per facet in the Facets UI, described below.

## Where it lives in the admin menu

The module adds no settings page of its own. Its documented integration point is
the **Facets** configuration pages at **Configuration → Search and metadata →
Facets** (`/admin/config/search/facets`), where an **Obfuscate facet link**
option becomes available on each facet.

## How to use it

To obfuscate facet links on a search page, following the module's own
instructions:

1. Enable the module.
2. Go to the Facets configuration page (`/admin/config/search/facets`).
3. Edit the facet you want to obfuscate.
4. Check **Obfuscate facet link** and save your changes.
5. The module replaces the original elements with `span.drupal-masked-element`
   spans, so update your theme's **CSS to target that new selector** for the facet
   links to look the way you want.
