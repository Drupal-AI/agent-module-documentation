# Link Title — manual setup guide

**Link Title** (`linktitle`) is a text-format filter that automatically adds a
`title` attribute to links that don't already have one. The value it uses comes
from the **title of the page the link points to** — so a link to `drupal.org`
gets a `title` attribute of "Drupal - Open Source CMS | drupal.org", which shows
as a tooltip when a reader hovers over the link.

The main use case is links that are generated from raw URLs by core's standard
*"Convert URLs into links"* filter. Those come out with no title attribute; Link
Title fills one in for you, giving readers (and assistive technology) a bit more
context about where a link leads without editors having to type a title by hand.

It depends only on core's **Filter** module and does its work purely on output —
it has no content of its own, no permissions, and no access-control role. You
turn it on by enabling the filter on the text formats where you want it.

> **Upgrade warning (from the project maintainers):** updating from alpha4 to
> alpha5 or beta1 breaks text editors. Before updating the module code, disable
> the Link Title option in your text editor(s), or disable the module first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable.

There is **no dedicated settings form** — you configure Link Title by enabling
its filter on a text format, described in "How to use it" below.

## Where it lives in the admin menu

Link Title adds no admin page of its own. You enable its filter per text format
at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit the text format you want (often the same one that has *Convert URLs into
   links* enabled).
3. Enable the **Link Title** filter in the format's filter list. Because it reads
   the title from the destination link, order it **after** any filter that
   creates the links (such as *Convert URLs into links*).
4. Save the text format. From then on, links rendered with that format that lack
   a `title` attribute get one derived from the target page's title.
