# LLMs.txt Sites — manual setup guide

**LLMs.txt Sites** (`llms_txt_sites`) makes the `/llms.txt` endpoint
**site-aware** on a multi-site Drupal installation. Where the base
[llms.txt](https://www.drupal.org/project/llmstxt) module serves one file for the
whole site, this module composes a different `llms.txt` per site or section by
tying the `llms.txt` machinery together with the **Sites** and **Group** modules.

For each site it merges a configurable header with an ordered set of
`llms_txt_section` entities, preserving the ordering you assign, and it emits the
correct cache tags and the *site* cache context so that outputs invalidate
precisely — a change to one site's sections does not needlessly rebuild another's.
The result is a controlled, site-specific `llms.txt` for installations that run
several sites from one Drupal codebase.

Like the base module, this is an SEO / AI‑discoverability feature. The content it
exposes simply reflects the site's own content (which already follows your access
rules), so it plays **no access-control role** — it does not restrict or grant
access to anything. This release is **1.0.0-alpha3**, so treat it as early
software.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Sites /
   Group / llms.txt dependencies with Composer, then enable it.

There is no standalone settings form for this module. You configure the per-site
output through the section entities and per-site assignment described below,
working within the **llms.txt**, **Sites**, and **Group** modules it builds on.

## How to use it

1. Set up your multi-site structure with the **Sites** and **Group** modules, and
   configure the base **llms.txt** content.
2. Create the `llms_txt_section` entities you want to publish and put them in the
   order you want them to appear.
3. Assign sections to each site (this module uses the *Sites* contrib technique
   for per-site assignment) so that each site's `/llms.txt` composes the header
   plus its own ordered sections.
4. Fetch `/llms.txt` on each site to confirm it returns that site's own,
   correctly ordered content.
