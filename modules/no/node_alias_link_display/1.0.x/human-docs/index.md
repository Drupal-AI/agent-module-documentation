# Node Alias Link Display — manual setup guide

**Node Alias Link Display** (`node_alias_link_display`) makes internal links in
your content show their friendly path alias instead of the raw
`/node/123` URL. When editors paste a canonical node link into the WYSIWYG editor
— which Drupal often produces as `/node/123` — this module rewrites it to the
node's alias (for example `/news/my-article`) when the content is rendered. The
result is more readable, more SEO-friendly URLs for both visitors and search
engines, without editors having to remember to use aliases by hand.

It works as a **Drupal text filter**, so you enable it per text format (like Full
HTML) rather than globally. At render time it scans the rendered markup for
anchor tags pointing to `/node/{nid}` and swaps in the correct alias. It is fully
**multilingual**: it respects the current language context and translated path
aliases, so canonical links resolve to the right localized URL. The module has no
dependencies beyond Drupal core.

There's a deliberate reason it rewrites at *display* time rather than on save:
the stored `/node/123` is the **stable** reference — it keeps working even if the
alias later changes — whereas markup rewritten on save would break when aliases
move. Two things are worth knowing operationally: aliases are resolved per link
at render time (normally fine, but worth remembering on a very link-heavy,
uncached page), and because it alters rendered links, check how it interacts with
anything else in your rendering pipeline — particularly language prefixes and any
link-tracking.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no separate settings page** — you switch it on per text format,
described in "How to use it" below.

## Where it lives in the admin menu

You enable the filter at **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`), inside each text format you want it
to apply to.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors**.
2. Edit the text format you want the filter to apply to (for example **Full
   HTML**).
3. In the **Filters** (Enabled filters) section, tick **Node Alias Link
   Display**.
4. **Save** the text format.

No further configuration is needed — from then on, any `/node/{nid}` link in
content using that format is converted to its path alias automatically at render
time.
