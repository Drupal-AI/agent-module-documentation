# Page Metatag — manual setup guide

**Page Metatag** (`page_metatag`) lets you configure meta tags for the pages and
entities on your site — the SEO and social‑sharing metadata that search engines
and social platforms read from the page `<head>`. Values can be built with
**tokens**, so a tag can pull in dynamic content (a node's title, for example)
rather than being hard‑coded. It depends on the contributed **Token** module for
that token support.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Token
   dependency with Composer, then enable it.
2. [Configuration](configuration/index.md) — how meta tags are configured, and how
   tokens supply dynamic values.

## Where it lives in the admin menu

Page Metatag configures meta tags for pages and entities. Its settings are reached
through the site's administration area once the module and Token are enabled — see
[Configuration](configuration/index.md).
