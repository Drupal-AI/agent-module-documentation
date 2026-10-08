# Markdownify — manual setup guide

**Markdownify** (`markdownify`) serves a clean **Markdown** version of your content
alongside the normal HTML page. Add `.md` to a URL — for example `/node/1.md` — and
you get the same content as Markdown: no theme, no navigation, no markup chrome. This
is aimed squarely at AI and automation: LLMs, crawlers, and retrieval pipelines can
ingest a page as Markdown at a fraction of the tokens (and cost) of full HTML, and get
cleaner text to work with.

Under the hood, Markdownify renders the entity through Drupal's normal pipeline and
then converts the resulting HTML to Markdown using the `league/html-to-markdown`
library. Out of the box it works for **nodes** and **taxonomy terms** with no
configuration — you can start requesting `.md` URLs immediately. Crucially, the
Markdown version respects the same access rules as the HTML page, so it never leaks
content a user could not otherwise see.

There are six ways to reach the Markdown of a page, so any client can use whichever
fits: the `.md` suffix (`/node/1.md`), a `/markdownify/…` path prefix
(`/markdownify/node/1`), a `?_format=markdown` query parameter, an
`Accept: text/markdown` request header, a `Content-Type: text/markdown` header, and —
with the optional `markdownify_path` submodule — `.md` on a path alias like
`/blog/my-post.md`. Every HTML page of a supported entity also advertises its Markdown
twin with a `<link rel="alternate" type="text/markdown">` tag, and there's a token
(`[node:markdownify-url]`) for printing the Markdown URL anywhere.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its conversion
   library with Composer, enable it, and pick the submodules you need.

The settings form is optional — the module works immediately for nodes and taxonomy
terms. Everything you can tune is covered below.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Markdownify**
(`/admin/config/services/markdownify`), gated by the **Administer markdownify**
permission. The module does not add any menu items beyond this settings page — the
Markdown output lives at the content's own URLs.

## How to use it

### Request Markdown

Once enabled, just append `.md` to a node or term URL (`/node/1.md`) — or use any of
the other five access methods listed above. The response comes back as
`text/markdown` and, by default, carries a `noindex` header so search engines leave
the raw Markdown alone.

### Tune it on the settings form (optional)

Open **Configuration → Web services → Markdownify**
(`/admin/config/services/markdownify`) to adjust:

- **Supported entities** — choose which entity types, bundles, and languages expose a
  Markdown version. By default all bundles and languages of the enabled entity types
  are covered; you can narrow this to, say, only Article nodes, or only certain
  languages. (The selection works as an include/exclude list per entity type.)
- **Converter** — Markdownify ships the **League** HTML‑to‑Markdown converter and lets
  you tune its options (heading style, list bullet character, whether to strip unknown
  tags, table handling, and so on). Developers can add their own converter — for
  example a CommonMark‑based one — by implementing the `html_to_markdown_converter`
  plugin type.
- **Noindex** — whether Markdown responses send an `X‑Robots‑Tag: noindex` header. It
  is on by default; turn it off if you actually want the Markdown indexed.

### For developers

You can convert an entity to Markdown in code via the
`markdownify.entity_converter` service, and there are four alter hooks
(`hook_markdownify_supported_entities_alter`, `…_entity_build_alter`,
`…_entity_html_alter`, and `…_entity_markdown_alter`) for adding entity‑type support,
reshaping the render array before conversion, or post‑processing the Markdown (for
example prepending a front‑matter header). See the [`agent/`](../agent/start.md) docs
for the full API surface.
