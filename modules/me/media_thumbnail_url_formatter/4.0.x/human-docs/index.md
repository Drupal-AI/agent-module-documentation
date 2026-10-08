# Media thumbnail URL formatter — manual setup guide

**Media thumbnail URL formatter** (`media_thumbnail_url_formatter`) adds one field
formatter, **Thumbnail URL**, that outputs the plain URL of a referenced media
entity's thumbnail image — just the URL string, not an `<img>` tag and not a link.
It applies to media reference (entity reference) fields and is selected on an
entity's **Manage display** tab like any other formatter.

The URL is handy wherever you need the address of an image rather than a rendered
picture: feeding a meta tag (an Open Graph or Twitter-card image), supplying a
background-image or CSS custom property in a template, handing a preview URL to a
JavaScript slider, or exposing the thumbnail to a decoupled front end through
JSON:API. Because it extends core's Media Thumbnail formatter, it can run the
thumbnail through an **image style** (for example a `medium` or `thumbnail`
derivative) before printing the URL.

A second option, **Absolute URL**, controls the form of the address: on keeps the
URL absolute (useful for emails, feeds, or sitemaps where a root-relative path
would not resolve), while off (the default) produces a root-relative path for
same-site markup. It works with multi-value fields, printing one URL per value.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has no settings page, so there is no separate configuration guide — its
two options live on the field's display and are covered in *How to use it* below.

## Where it lives in the admin menu

There is no admin page of its own. You select the formatter per field on an
entity's **Manage display** tab, for example
**Structure → Content types → Article → Manage display**.

## How to use it

1. Make sure the entity has a **media reference** field (an entity reference to
   media).
2. Go to the bundle's **Manage display** tab (`/admin/structure/…/display`).
3. Set that field's **Format** to **Thumbnail URL**.
4. Click the settings cog to choose:
   - **Image style** — the image style whose URL you want (for example `thumbnail`
     or `medium`). Leave empty to use the original file URL.
   - **Absolute URL** — on to keep the URL absolute; off (default) to output a
     root-relative path.
5. Click **Update**, then **Save**.

Each referenced media item now renders as a bare thumbnail URL string. The media
entity and the image style are registered as cache dependencies, so the output
updates correctly when either changes.
