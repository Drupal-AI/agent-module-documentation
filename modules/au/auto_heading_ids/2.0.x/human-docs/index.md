# Auto heading ids — manual setup guide

**Auto heading ids** (`auto_heading_ids`) provides a **text-format filter** that
automatically adds `id` attributes to headings (h2–h6) in rendered content,
derived from the heading text. That turns each heading into an anchor target, so
you can build tables of contents, "jump to section" links, and deep links to a
specific part of a page.

Because it works as a text-format filter, it applies wherever you add it: choose
the text formats whose content has headings that should be linkable, add the
filter, and headings in that content gain ids when rendered. It only affects the
output — the stored value of your content is unchanged — and it has no
access-control role of its own.

The packaged release is `2.0.0-beta3`, a **beta**, and it supports Drupal 8, 9,
10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no central settings page — you enable the behaviour per text format:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Choose the text format your content uses (for example *Full HTML* or *Basic
   HTML*) and click **Configure**.
3. Under **Enabled filters**, tick the Auto heading ids filter.
4. Save the format.

From then on, headings (h2–h6) in content using that format get `id` attributes
derived from their text, ready to be used as anchor targets. Because the ids come
from the heading text, keep in mind that editing a heading changes its id, and
duplicate heading text on the same page will be de-duplicated.
