# Configuration

Everything happens on one screen, which doubles as a short workflow from intro text
to a published `llms.txt`.

## Open the generator

1. Log in as a user with the module's administer permission.
2. Go to **Configuration → Content authoring → llms.txt AI Generator**.

## Step 1 — Introduction text

Write a short introduction — two or three plain‑language paragraphs describing what
your site is and who it's for. This becomes the opening of your `llms.txt` and gives
an LLM the context it needs to summarize your site accurately.

## Step 2 — Content sources (menus)

Choose which menus to include — **Main navigation**, **Footer**, and any others that
represent your key pages. You also set a **depth** (three levels is the recommended
default) to control how far down each menu the generator reaches.

> **Think "executive summary," not "full catalogue."** The FAQ advice is to include
> roughly 20–50 key pages rather than every page on the site. And because `llms.txt`
> is published publicly for crawlers, only include content you're happy to have
> publicly discoverable.

## Step 3 — AI settings

Choose the AI provider the generator should use. Any provider you've configured in
the AI module is available here. The generator uses it to reformulate your pages'
SEO/meta text into natural language.

> **Egress and cost:** generating the file sends your content and structure to the
> chosen AI provider — an external call with the usual AI‑usage cost. Make sure that
> is acceptable, and confirm your provider key is stored securely (see the
> [installation](../installation/index.md) notes on the AI module and the Key
> module).

## Step 4 — Manage descriptions

Review the descriptions for the selected pages. Where a page already has a meta
description (via Metatag), it's used automatically; where one is missing, add a
manual description. You can also override any AI‑ or meta‑derived description with
your own wording.

## Step 5 — Generate

Click **Generate llms.txt**. The module extracts the menu pages and meta, applies
your manual edits, reformulates the text with AI, and writes the file — a process
that takes a few minutes. Generation runs on demand (not during page loads) and the
output is cached, so it won't slow your site.

## Result

Your file is live at `yoursite.com/llms.txt`. Re‑run the generator whenever your key
pages or descriptions change to keep it current.

> **A note on storage:** the module keeps its configuration in Drupal's config
> management (so it's exportable), while manual descriptions are stored lightweight
> in the key‑value store rather than in new database tables.
