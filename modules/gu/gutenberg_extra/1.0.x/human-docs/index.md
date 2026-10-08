# Gutenberg Extra — manual setup guide

**Gutenberg Extra** (`gutenberg_extra`) adds a set of text-format filters that
post-process the HTML produced by the Gutenberg editor. It doesn't change how you
write content — it refines the markup on the way out, cleaning up or transforming
the wrappers Gutenberg blocks generate so the rendered output matches what your
theme and front-end libraries expect.

Out of the box it gives you three filters you switch on in the **Gutenberg
Blocks** text format:

- A **group** filter that removes the `div.wp-block-group__inner-container`
  wrapper Gutenberg adds around grouped blocks.
- A **gallery** filter that replaces the `figure.wp-block-gallery` wrapper with a
  plain `div`, and recognizes three helper classes you can add to a gallery
  block: `swiperjs-player` (prepares the structure for the Swiper.js carousel
  library), `remove-figure` (strips the `<figure>` around images), and
  `switch-figure-to-div` (swaps each `<figure>` for a `<div>`).
- An **image** filter that removes the `<figure>` wrapper around images — either
  per block, by adding the `img-only` class to an image block, or globally, by
  ticking "Remove all figure around img" in the filter's own configuration.

Because this is a filter, it is configured on a text format rather than on a
settings page of its own — see "How to use it" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Gutenberg/Filter dependencies.

There is **no standalone configuration page**. Everything is set up on the
Gutenberg Blocks text format, described next.

## Where it lives in the admin menu

The filters appear on the **Gutenberg Blocks** text format at **Configuration →
Content authoring → Text formats and editors → Gutenberg**
(`/admin/config/content/formats/manage/gutenberg`).

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors** and
   edit the **Gutenberg Blocks** text format.
2. In the **Enabled filters** list, tick the Gutenberg Extra filter(s) you want —
   the group, gallery, and/or image filters.
3. If you want the image filter to strip the `<figure>` wrapper from every image,
   open the filter's settings on the same page and check **Remove all figure
   around img**. Otherwise, add the `img-only` class to individual image blocks in
   the editor.
4. For gallery styling, add one of the helper classes (`swiperjs-player`,
   `remove-figure`, `switch-figure-to-div`) to the gallery block in the editor.
5. Check the filter processing order on the text format so these filters run in
   the right place relative to the others, then **Save configuration**.
