<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
MD Sitemap publishes a single configurable endpoint (default `/sitemap-llm`) that lists the canonical URLs of chosen content-entity bundles as a Markdown bullet list, each URL given a configurable suffix (default `.md`) for LLM/AI crawlers.

---

MD Sitemap is a lightweight, standalone alternative to XML-sitemap modules aimed at AI/LLM crawlers rather than search engines. An admin picks, per entity type and bundle, which content should appear, and the module renders a plain `text/markdown` response of `- [label](https://host/path.md)` lines at a configurable path. It automatically offers every entity type that has a canonical link template (nodes, taxonomy terms, media, commerce products, users, etc.), and only includes published entities that the current viewer may access. The generated list is stored in a dedicated cache bin and invalidated automatically when any entity is inserted, updated or deleted, or when the settings change; `hook_cron()` pre-warms it. It is designed to be paired with a Markdown/plain-text page renderer (such as the Markdownify module) and referenced from an `llms.txt` file so LLM crawlers can discover machine-readable versions of your pages. It ships no permissions of its own — the sitemap route is public by design and the settings form is gated by `administer site configuration`.

---

- Publish an LLM-oriented sitemap at `/sitemap-llm` for AI crawlers.
- Expose a Markdown bullet list of your site's canonical URLs.
- Append a `.md` suffix to every listed URL for text/Markdown page variants.
- Switch the suffix to `.txt`, `.ai` or any other extension you serve.
- Move the sitemap to a custom path (e.g. `/llm-index`) without code.
- Select exactly which node bundles appear in the crawler sitemap.
- Include taxonomy terms, media, or commerce products alongside nodes.
- Include any custom content-entity type that has a canonical URL.
- Reference the endpoint from an `llms.txt` "Sitemap" directive.
- Pair with Markdownify to serve clean Markdown pages the sitemap points at.
- Give LLM crawlers a curated, machine-readable content index separate from `sitemap.xml`.
- Keep AI-discoverability config decoupled from your SEO XML-sitemap module.
- Automatically refresh the sitemap when editors add, edit or delete content.
- Pre-generate the sitemap on cron so the first request is fast.
- Limit the sitemap to only the published content you intend AI systems to ingest.
- Provide a lightweight content map without installing a heavy sitemap suite.
- Expose absolute URLs (scheme + host) suitable for external crawler consumption.
- Curate an AI training/ingestion feed of selected bundles only.
- Offer a single flat index of pages for a documentation or knowledge site.
- Control AI content exposure deliberately as an editorial policy choice.
