# Alternative Hreflang for SEO — manual setup guide

**Alternative Hreflang for SEO** (`seo_alt_hreflang`) lets you advertise a
different language code in your pages' `hreflang` tags than the one Drupal uses
in its URLs — without touching your actual language setup, URL prefixes, or
routing.

On a multilingual site, Drupal emits `hreflang` link tags (and language-switcher
links) using the registered language code for each language. Sometimes the code
you want search engines to see is not the same as the code Drupal routes on: you
might want to serve a region-specific value like `en-GB` while keeping the URL
langcode `en`, advertise a search-engine-preferred code, or make a
`zh-Hans` / `zh-Hant` style distinction that Drupal's langcode does not express.
This module stores a simple per-language mapping and rewrites only the emitted
`hreflang` value at output time — your canonical URLs, prefixes, and routing stay
exactly as they were.

It works by adjusting the alternate-language `<link>` tags in the page head and
the attributes on language-switcher block links; requests that return 403 or 404
are skipped. The emitted values are HTML-escaped for safety. This is a
configuration-driven module: after enabling it you need to open its settings form
and enter the alternative codes you want — an empty field simply leaves that
language's `hreflang` untouched. It requires only Drupal core's **Language**
module and is genuinely only useful on a site that has more than one language
with translated content. No coding knowledge is needed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core Language.
2. [Configuration](configuration/index.md) — map each language to the
   alternative `hreflang` code you want to advertise.

## Where it lives in the admin menu

The settings form sits under **Configuration → Regional and language →
Languages → Alternative Hreflang settings**
(`/admin/config/regional/language/seo-alt-hreflang`), behind the dedicated
`administer seo alt hreflang configuration` permission (marked as restricted
access).

## How to use it

Enter your alternative codes on the settings form, save, then load a translated
page and view its source: the alternate-language `<link>` tags in the `<head>`
should now carry your custom `hreflang` values, while the URLs themselves are
unchanged. Language-switcher links pick up the same mapping.
