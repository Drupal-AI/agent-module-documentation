# Media Filter — manual setup guide

**Media Filter** (`media_filter`) provides a text filter for embedding media in
content. Once enabled and added to a text format, it lets media references be
rendered from within processed text — turning media markup/tokens in a field into
fully rendered media when the text is displayed.

It is purely a content-display feature. It adds no admin pages of its own, and it
plays no part in access control: any media embedded through the filter still
follows Drupal's normal media access rules, so a viewer only ever sees media they
are allowed to see. The module works across Drupal 9, 10, and 11 and has no
third‑party dependencies.

Because it is a text filter, the only setup step is to switch it on for the text
format(s) where you want in‑text media to render — for example your *Full HTML* or
a dedicated editor format.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated configuration page** for this module. You turn it on where
it matters — inside a text format — as described below.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** next to the text format you want media embeds to render in.
3. Under **Enabled filters**, tick the **Media filter** checkbox.
4. If your format runs several filters, check the **Filter processing order** tab
   so the media filter runs at a sensible point relative to the others.
5. Click **Save configuration**.

From then on, content in that text format will have its media markup rendered as
real media when displayed.
