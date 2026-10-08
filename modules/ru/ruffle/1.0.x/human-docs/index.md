# Ruffle — manual setup guide

**Ruffle** (`ruffle`) lets your Drupal site play legacy Flash (`.swf`) content
again, without the long‑dead Adobe Flash Player plugin. It integrates
[Ruffle](https://ruffle.rs/), an open‑source Flash *emulator* written for the modern
web (WebAssembly with a JavaScript fallback), so old SWF animations and simple
interactive content run right in the browser.

It works as a **field formatter**: point a File (or Media) field at your `.swf`
files, set that field's display format to **Ruffle Flash Player**, and Ruffle
renders the content in place. There's no admin settings page — everything happens on
the field's *Manage display*, with a few per‑formatter options such as autoplay
where available.

Two things to keep in mind. Ruffle is an emulator, so it reproduces most — but not
necessarily all — Flash behavior, especially for complex or ActionScript‑heavy
files; test your specific SWFs. And the Ruffle player itself is a JavaScript library
loaded either from a CDN or locally, so if you load it from a CDN the visitor's
browser fetches it from that third party.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You set it up on a field's
display, described in "How to use it" below.

## How to use it

1. Add (or reuse) a **File** field on a content type, and configure that field so it
   accepts only Flash files — allow the `swf` extension.
2. Go to **Structure → Content types → *(your type)* → Manage display**.
3. Set the file field's **Format** to **Ruffle Flash Player**.
4. Configure the formatter's options (such as autoplay) if they're offered, then
   click **Save**.

Now create or edit a piece of content, upload a `.swf` file into that field, and
view the content — the Flash file plays through the Ruffle emulator, no browser
plugin required. The same approach works with a Media entity that has a file field
for SWF content.
