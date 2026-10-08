# llms.txt — manual setup guide

**llms.txt** (`llmstxt`) lets you write and manage the contents of an `/llms.txt`
file through a simple Drupal admin form, and serves it dynamically at
`https://yoursite.com/llms.txt` — no direct file-system access needed. `llms.txt`
is an emerging convention for helping large language models understand a site: a
Markdown summary published at a well-known path that says what the site is, which
pages matter, and where the canonical documentation lives. It is aimed at AI
consumers in the same spirit that `robots.txt` is aimed at search crawlers.

The distinctive thing about this module is that it stores the file's content as
**Drupal configuration**, not as a static file in your docroot. That has two
practical benefits: the content survives a deployment (a Composer‑built docroot
would otherwise overwrite a hand-placed file), and it travels with your
configuration export (`drush cex`) so it can be versioned and moved between
environments. If you would rather have the file generated automatically from your
content instead of writing it by hand, look at the sibling
[LLMs.txt Generator](https://www.drupal.org/project/llms_txt_generator) module.

Two honest caveats belong with any recommendation. The convention is a
**proposal, not a ratified standard** — adoption is growing but partial, and
nothing obliges a crawler to fetch or honour it. And it is **advisory**, exactly
like `robots.txt`: it expresses a preference and provides no enforcement
whatsoever against a model or scraper that ignores it. A site that needs to
actually prevent AI scraping needs access control or blocking, not this file.
This release is **1.0.0-alpha1**, so treat it as early software.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — write the `llms.txt` content in the
   settings form.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Search and metadata →
llms.txt** (`/admin/config/search/llmstxt`), behind the module's own **Administer
llms.txt** permission (`administer llmstxt`). The content you save is served
publicly at `/llms.txt`.
