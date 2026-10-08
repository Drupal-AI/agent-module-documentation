# Feeds XSLT Pipeline Parser — manual setup guide

**Feeds XSLT Pipeline Parser** (`feeds_xsltparser`) adds a *parser* plugin to the
[Feeds](https://www.drupal.org/project/feeds) module that runs a simple XSLT
pipeline over an XML source. XSLT (Extensible Stylesheet Language Transformations)
is especially useful when importing document-style XML files: you write one
stylesheet per field you want to extract, and the parser applies them to turn the
original document into the values Feeds maps onto your entities.

You point the parser at a directory of XSLT stylesheets. Each stylesheet extracts
one field; if you group stylesheets into a folder, they run in alphabetical order,
each operating on the result of the one before it — that's the "pipeline". You can
change the stylesheets path in the parser settings, which is handy when you run
several XSLT-based importers and want a different set of stylesheets for each.

**A security note worth reading before you use this.** XSLT is applied to XML that
your import fetches, and XML/XSLT processing can be abused (for example XML
External Entity, or "XXE", attacks, or stylesheets that pull in external resources).
Treat XML sources and stylesheets as you would any code: only run stylesheets you
trust, and be cautious about importing XML from sources you don't control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, ensure
   the PHP XSL extension is present, and enable it alongside Feeds.

There is **no site-wide configuration page** for this module — it has no settings
form of its own. The parser (and its stylesheets path) is configured on each Feed
type, as described below.

## Where it lives in the admin menu

Feeds XSLT Pipeline Parser adds no admin page of its own. You use it from a Feed
type at **Structure → Feed types** (`/admin/structure/feeds`), where it appears in
the **Parser** list.

## How to use it

1. Install and enable the module, along with the Feeds UI (see
   [Installation](installation/index.md)).
2. Go to **Structure → Feed types** and add a new Feed type. Set up its basic
   settings and fetcher for your source.
3. Change the **parser** to **XSLT Pipeline Parser**.
4. Place your XSLT stylesheets in the pipelines directory — one stylesheet per
   field you want to extract. You may also place folders of stylesheets, which run
   in alphabetical order as a pipeline. You can override the stylesheets path in the
   parser settings if you want a dedicated set for this importer.
5. Set up the field mapping in the processor section, then create a feed of that
   type and import.
