# LLMs.txt Generator — manual setup guide

**LLMs.txt Generator** (`llms_txt_generator`) builds an `/llms.txt` file for your
site **automatically from your content**, rather than asking an administrator to
write and maintain it by hand. `llms.txt` is an emerging convention — a plain,
Markdown-style file served at a well-known path that tells large language models
(ChatGPT, Claude, and others) what your site is about and which pages matter,
much as `robots.txt` guides search crawlers. Once the module is enabled, the file
is served at `https://yoursite.com/llms.txt`.

The "generator" angle is what sets this module apart from its sibling
[`llmstxt`](https://www.drupal.org/project/llmstxt), which stores hand-written
content as configuration. Because this module derives the file from your site,
the listing stays current as content changes rather than going stale the week
after someone writes it. You control which content is listed through the
admin form.

A couple of honest caveats are worth stating up front. `llms.txt` is a
**proposal, not a ratified standard** — adoption is growing but partial, and no
crawler is obliged to fetch or honour it. And like `robots.txt`, it is purely
**advisory**: it expresses a preference and enforces nothing. A site that needs
to actually prevent AI scraping needs access control, not this file. Finally,
because the value of the file is *curation*, it is worth reviewing what the
generator includes — a listing of everything provides no more guidance than a
sitemap. This release is **1.0.0-alpha1**, so treat it as early software.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose what the generated `llms.txt`
   contains and turn the file on.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Search and metadata →
LLMs.txt Generator** (`/admin/config/search/llms-txt-generator`), behind a
dedicated **Administer LLMs.txt Generator** permission
(`administer llms txt generator`). The generated file is served publicly at
`/llms.txt`.
