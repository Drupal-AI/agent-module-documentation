# JSON-LD Simple — manual setup guide

**JSON-LD Simple** (`jsonld_simple`) is a lightweight SEO helper that lets content
managers output **Schema.org JSON-LD structured data** in the HTML `<head>` of
pages, so search engines can better understand the site and it becomes eligible
for richer search results. Everything is managed from a single admin settings
form — there is no need to hand-edit theme templates.

Rather than generating schema from field mappings, JSON-LD Simple emits the
structured data you configure. It can enable or disable JSON-LD schema per content
type and per individual node, and it can output breadcrumb structured data. The
result is emitted inside a `<script type="application/ld+json">` tag in the page
head. It has no entity type of its own, makes no external calls, and has no
front-end interaction — the output is controlled entirely by trusted
administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings form, where you enable
   JSON-LD per content type, per node, and for breadcrumbs.

## Where it lives in the admin menu

Once enabled, the settings form sits at
`/admin/config/search/jsonld-simple/settings` (config route
`jsonld_simple.settings`), under **Configuration → Search and metadata**. It is
gated by the **Administer JSON-LD** permission, so grant that only to trusted
administrators.
