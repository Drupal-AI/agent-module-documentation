# Layout Builder Instant Preview — manual setup guide

**Layout Builder Instant Preview** (`layout_builder_instant_preview`) gives you
**live previews when editing custom blocks in Layout Builder**. Normally, editing
a block means filling in a form, saving, and only then seeing the result — and if
it is wrong, doing it all again. For anything visual, that save‑and‑look loop is
slow enough to change how people work. This module closes the loop: the block's
preview updates as you fill in the form, in the default off‑canvas sidebar, so you
see what you are making while you make it. It also provides an instant preview when
you configure a layout section.

The module is a fork of Panopoly Magic. The differences: it uses the default
off‑canvas sidebar rather than a modal dialog, it provides instant previews only
for custom blocks (not other fields or system blocks), it adds the section‑configure
preview, and it supports Drupal 10 and CKEditor 5.

**Two things to check before rolling it out on a busy editorial site.** Live
preview means the block re‑renders on each change, so an unthrottled preview on a
complex block can generate a lot of requests during editing — confirm what
debouncing is in place. And because preview uses the block's *real* render path,
anything expensive there (an API call, an uncached View, an image derivative)
happens repeatedly while editing rather than once on save. Neither is a reason to
avoid it — both are reasons to try it on your heaviest block first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no configuration page** — it works as soon as it is enabled.

## Where it lives in the admin menu

It adds no admin page. The live preview appears in the Layout Builder off‑canvas
sidebar whenever you add or configure a custom (inline) block, or configure a
section.

## How to use it

Enable the module, then edit a custom block in a Layout Builder layout. As you
change the block's form fields, the preview in the off‑canvas sidebar updates in
real time — no need to save and reload to see the result.
