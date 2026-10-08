# SEO analyzer — manual setup guide

**SEO analyzer** (`seo_analyzer`) puts a traffic-light SEO checklist right next to
your content. It checks a node (or canvas page) against a set of on-page SEO best
practices and shows you the results, so you can fix problems while you are still
writing rather than discovering them months later across a thousand pages. You
can also type in a keyword or keyphrase and see how well the content scores for
that term.

The checks it runs include: whether your meta title and description contain your
keyword; whether the keyword appears in your headings (H1, H2) and whether it is
overused; whether the path and domain include the keyword; whether the meta title
and description are a sensible length; whether the heading structure is correct;
the code-to-text ratio; whether images have alt text; whether the URL is a
reasonable length; whether the site uses HTTPS; whether the page redirects
elsewhere; whether the HTML source is too long; and whether the site has a proper
`robots.txt` and a sitemap. The results are presented so you know what to adjust.

This module works as soon as you enable it — there is **no settings form** to fill
in. Instead it adds a new **SEO Analyzer** task link to each node, sitting
alongside the usual *Edit* and *Translate* tabs, and anyone who is an
administrator or holds the `access seo analyzer` permission can open it. It has no
module dependencies. Note that it targets **Drupal 11 only**
(`core_version_requirement: ^11`), and its description mentions "a given node or
canvas page", so if you rely on Drupal's newer page-building features it is worth
confirming against your actual content model.

A few honest caveats to keep in mind. On-page checks are the smallest part of how
pages actually rank — that is dominated by content quality, links, and
performance, so a page scoring green is not automatically a page that ranks; the
tool measures what is measurable. SEO advice also ages: things like keyword
density and meta keywords were once recommended and are now neutral or even
harmful, so treat the checks as guidance rather than gospel. And an editorial
checklist works best as a helper, not a gate — writing purely to satisfy a score
produces text optimised for the rule rather than the reader.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.

## How to use it

Log in as an administrator (or a user with the `access seo analyzer` permission)
and open any node. Click the **SEO Analyzer** tab — it appears next to *Edit* and
*Translate*. You will see the analysis results for that page, and at the top you
can enter a keyword to check the content against. Adjust your content based on
what the checks flag, and re-open the tab to see the updated results.
