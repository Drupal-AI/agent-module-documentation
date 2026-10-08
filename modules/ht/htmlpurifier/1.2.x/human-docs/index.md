# HTML Purifier — manual setup guide

**HTML Purifier** (`htmlpurifier`) wraps the audited
[`ezyang/htmlpurifier`](http://htmlpurifier.org/) PHP library as a Drupal
**text-format filter**. When enabled on a text format, it strips XSS and other
malicious HTML from stored markup and rewrites what remains into clean,
standards-compliant, well-formed output. It is a strong companion to a WYSIWYG
editor and a good fit anywhere semi-trusted authors can paste arbitrary HTML.

Unlike core's kses-based "Limit allowed HTML tags" filter, HTML Purifier understands
the full HTML specification. That lets you permit rich constructs — tables, inline
`style` attributes, fonts, images — while still guaranteeing safe, valid output. It
can also auto-correct malformed markup (for example messy HTML pasted from Word or
Google Docs), strip event handlers and `javascript:` URIs, and normalize deprecated
tags to modern equivalents.

You configure it per text format by pasting a small block of **YAML** that maps to
HTML Purifier's configuration directives — for example an `HTML.Allowed` whitelist,
`URI.*` rules to restrict link protocols, or `CSS.AllowedProperties` for inline
styles. Leave the configuration empty and it uses the library's safe default
whitelist. One global setting points Purifier's serializer cache at a writable path.

> **It is only as effective as its placement.** HTML Purifier protects a format only
> when it is **enabled on the formats that accept untrusted input** and ordered
> **last** in that format's filter chain — after any filter that could add or
> re-introduce markup (line-break conversion, URL-to-link, media/embed filters).
> Placed too early, a later filter could inject unsanitized HTML.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the
   `ezyang/htmlpurifier` library with Composer, and enable it.
2. [Configuration](configuration/index.md) — enable the filter on a text format,
   order it correctly, write its YAML directives, and set the cache path.

## Where it lives in the admin menu

There is no module-level settings page. You enable and configure the **HTML
Purifier** filter per format at **Configuration → Content authoring → Text formats
and editors** (`/admin/config/content/formats`). The one global option (a cache
path) lives in the `htmlpurifier.settings` config object, editable with Drush.
