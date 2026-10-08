# GTM Snippet Loader — manual setup guide

**GTM Snippet Loader** (`gtm_snippet_loader`) lets site builders add a trusted
Google Tag Manager (or similar tag‑manager) snippet to a Drupal site without
editing any theme files. It gives you a simple configuration screen for a **head**
snippet and an optional **body‑open** snippet (the `noscript` fallback that GTM
recommends), with controls for excluding admin pages and specific paths — all
managed inside Drupal configuration so it travels through your normal export and
deployment workflow.

It is intentionally smaller and more direct than full integrations like *Google
Tag* or *GoogleTagManager*. Rather than managing a whole Google tag workflow, it
focuses on loading trusted snippets in the right places with configurable
exclusions. Reach for it when you need to drop in a GTM container snippet, a
server‑side GTM loader, or another trusted tag‑manager script and want that
snippet version‑controlled in Drupal instead of hard‑coded in a template.

For most sites the module's automatic injection mode is the simplest choice — it
places the snippets for you. If you need stricter control over exactly where the
markup lands, your theme can instead render the variables the module provides in
its page templates.

**Two cautions worth reading first.** Because this module lets a user inject
JavaScript and HTML into every page, the configuration permission should be granted
only to fully trusted administrators. And because it loads a tag manager, the
usual privacy and consent obligations apply: pair it with cookie‑consent handling
and disclose the tracking as your jurisdiction requires.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the head and body snippets and
   set the exclusions.

## Where it lives in the admin menu

The configuration page is at **Configuration → System → GTM Snippet Loader**
(`/admin/config/system/gtm-snippet-loader`).
