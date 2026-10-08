# Image URL Formatter — manual setup guide

**Image URL Formatter** (`image_url_formatter`) adds a display formatter that
renders an image field as **just its URL, in plain text**, instead of a full
`<img>` tag. It is the tool you reach for when you need the address of an image
rather than the image itself — to feed an `og:image` meta tag, a CSS
`background-image`, a `data-*` attribute, or a JSON/data feed built with Views.

You can optionally run the URL through an image style preset (so you get the URL
of, say, the `thumbnail` or `large` derivative), and choose whether it comes out
as a full URL with scheme and host, a root‑relative path, or a plain relative
path. The printed URL can also be wrapped in a link to the host content or to the
file itself. A companion **File URL Formatter** does the same job for plain file
fields.

There is nothing to install beyond the module, no settings page, and no
permissions — everything is set per field on the entity's **Manage display**
page, or in a View's field settings. It depends only on Drupal core's Image
module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You apply the formatter wherever fields are
displayed: **Structure → Content types → (your type) → Manage display** (or a
Media type, or any entity display), or in a View's field configuration.

## How to use it

1. Go to **Manage display** for the bundle that has your image field (or add the
   image field to a **View**).
2. Change that field's **Format** to **Image URL Formatter**. For a plain file
   field, choose **File URL Formatter** instead.
3. Click the gear icon to open the settings and choose:
   - **URL type** — **Full URL** (scheme + host), **Absolute file path** (a
     root‑relative path with a leading slash), or **Relative file path** (no
     leading slash).
   - **Image style** — run the URL through an image style preset, or leave it as
     **None (original image)** for the un‑styled original. (Image styles apply to
     the image formatter only.)
   - **Link** — wrap the printed URL in a link to the **Content**, to the
     **File**, or **Nothing**.
4. Save. The field now outputs the image's URL as plain text.

To consume the output, render the field in a Twig template (for example
`{{ content.field_image }}`) and drop it into a `style=""`, a `data-*`
attribute, or an `<img src="">` you build yourself; or add the field to a Views
JSON/data export so API consumers receive the URL. Note that the "Global: Custom
Text" area in Views may not pick up the value — prefer a Twig template or
template override when you need to format it.
