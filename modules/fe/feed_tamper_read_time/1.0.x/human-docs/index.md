# Feed Tamper Read Time — manual setup guide

**Feed Tamper Read Time** (`feed_tamper_read_time`) is a small
[Feeds Tamper](https://www.drupal.org/project/tamper) plugin that turns a chunk
of imported HTML into an estimated reading time in whole minutes. If your source
articles carry a rich body of text, this plugin can look at that text and
automatically populate a "5 min read" style field on the content you import — no
custom code required.

It adds a single Tamper plugin called **Read Time Calculator**. During an import
it strips the HTML down to plain text (loading it into a DOM parser and dropping
`<script>` and `<style>` content), counts the words, divides by a configurable
words‑per‑minute (WPM) rate, and rounds up to the nearest whole minute. The
result is returned as a number you can map onto a numeric or text field. The
default rate is **200 WPM**, and you can set anything from 50 to 1000 to suit
your audience.

Because it only reads and counts text, the plugin is a pure, read‑only
transformation — it has no settings page, no permissions, and makes no network
requests. Everything is configured on the Tamper instance you add to a feed
type's mapping.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Feeds Tamper.

There is **no configuration page** for this module. You set it up entirely on a
feed type's mapping, described in "How to use it" below.

## Where it lives in the admin menu

Feed Tamper Read Time adds no admin page of its own. You use it from **Structure →
Feed types → *(your feed type)* → Mapping**, where the Feeds Tamper module lets you
attach Tamper plugins to the sources you are importing.

## How to use it

Feeds Tamper adds a small gear/settings link next to each mapping source on a feed
type. To calculate reading time from an imported HTML body:

1. Make sure your feed type already maps the source that carries the HTML content
   (for example the article body) onto a destination field.
2. On the feed type's **Mapping** tab, open the Tamper settings for that source.
3. Add the **Read Time Calculator** tamper.
4. Set the **words per minute** rate you want (default **200**; valid range
   50–1000). A lower number produces a longer estimate; a higher number a shorter
   one.
5. Map the resulting value onto the field where you keep the reading time (a
   numeric field, or a text field such as one you render as "X min read").

On each import the plugin recomputes the minute count from the current source
text, so the reading time stays in sync whenever you re‑import.
