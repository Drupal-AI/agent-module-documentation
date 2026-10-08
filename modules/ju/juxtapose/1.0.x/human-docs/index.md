# Juxtapose Slider Image Formatter — manual setup guide

**Juxtapose Slider Image Formatter** (`juxtapose`) adds a before/after **slider**
to image fields. It renders a two‑image field as an interactive
[JuxtaposeJS](https://juxtapose.knightlab.com/) slider that the visitor drags
left and right to compare the two images — the classic "before and after" reveal.

There's no settings page and nothing to configure globally. You turn it on where
it's used: on an image field's **Manage display**, you pick **Juxtapose Before
After Slider** as the field's format. The field must be **multi‑value** and must
hold **at least two images** — the first two supply the "before" and "after" halves
of the slider.

The interactive slider is powered by the JuxtaposeJS JavaScript library, which you
download once and place in your site's `/libraries` folder (or let Composer install
it). The module depends only on core's **Image** module and works on Drupal 10 and
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and add the
   JuxtaposeJS library.

There is **no configuration page** for this module — it has no settings form. You
set it up entirely on your image field's display, described in "How to use it"
below.

## Where it lives in the admin menu

Juxtapose adds no admin page. You use it from **Structure → Content types →
*(your content type)* → Manage display** (or the Manage display of any fieldable
entity that has a multi‑value image field).

## How to use it

1. Add (or reuse) a **multi‑value image field** on your content type — its
   cardinality must allow more than one value.
2. Go to that content type's **Manage display**.
3. For the image field, choose the **Juxtapose Before After Slider** format and
   save.
4. When you create content, **upload at least two images** to that field. The
   first two render as the before/after images the visitor drags to compare.

> **Tip:** If you want a comparison slider that is more focused on accessibility,
> the project also points to *Image Compare Accessible Slider* as an alternative.
