# CKEditor Media Title — manual setup guide

**CKEditor Media Title** (`ckeditor_media_title`) lets editors override the HTML
`title` attribute of media embedded in CKEditor 5 — typically an image — directly
in the editor, without changing the underlying media entity. The `title`
attribute is what shows as a tooltip on hover and is read by some assistive
technology, so being able to set it per embed is useful for accessibility and
context.

The gap it fills is that the same image is often reused across many pieces of
content where it needs a *different* contextual description each time. Editing the
media entity's own title would change it everywhere; this module instead stores
the override on the individual embed, so the original media entity stays untouched
and each article can carry its own tooltip text.

In use it adds a button to the embedded media's inline toolbar (a "T" icon) that
appears when you select an embedded media item. Clicking it opens a small,
native‑style balloon form with Save and Cancel buttons where you type the custom
title — or leave it blank to fall back to the media entity's default title. The
override is written to the `<drupal-media>` tag and rendered through core's media
embed, which sanitizes output, so there is no content or access‑control concern
beyond that.

It depends on core **CKEditor 5** and **Media**, and works on Drupal 10 and 11.
The feature is switched on per text format, and it only works on formats that use
the Media Embed filter with CKEditor 5. Note the module is *minimally maintained*
and **not covered by the Drupal security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   turn on the feature per text format.

There is **no separate settings page** — the only setup is a single checkbox on
each text format, described below and in Installation.

## Where it lives in the admin menu

The module adds no admin configuration page. You enable it per text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`). Edit a format that uses CKEditor 5 and the
Media Embed filter, find **Media Image Title Override** in the CKEditor 5 plugin
settings, tick **Enable media image title override**, and save.

## How to use it

Once enabled for a format, edit content that uses it, insert or select an embedded
media item, and click the **"T"** button in the media's inline toolbar. Enter your
custom title (or leave it blank to use the media's default) and click Save. The
tooltip text is stored with that embed only — the same image elsewhere keeps its
own title.
