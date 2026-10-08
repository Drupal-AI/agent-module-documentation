# Colorbox Field Formatter — manual setup guide

**Colorbox Field Formatter** (`colorbox_field_formatter`) gives you field
formatters that turn a field's value into a link that opens in a **Colorbox
lightbox** — the popup/modal overlay provided by the Colorbox module. The link
can point at the entity's own page, a manually entered (token-aware) URL, an
image, or inline content, and you can group several links so Colorbox cycles
through them as a gallery.

You never touch a settings page for this module: you choose one of its formatters
on a field's **Manage display** row, exactly like picking any other display
formatter. Everything you set — popup size, iframe mode, image style, gallery
grouping, CSS classes — is stored in that display's configuration and exports
with it. The module requires the **Colorbox** module and attaches Colorbox's
JavaScript and CSS automatically when a formatted field is on the page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install Colorbox Field Formatter (and
   its Colorbox dependency) with Composer and enable it.

## Where it lives in the admin menu

There is no configuration page. You use the module on **Manage display** for any
fieldable entity — *Structure → Content types → your type → Manage display* (and
the equivalent for media, taxonomy terms, users, or any other entity), or in a
View's field display settings.

## How to use it

### The three formatters

On a field's **Manage display** row, open the **Format** dropdown and pick the
Colorbox formatter that matches the field type (all three are labelled "Colorbox
FF"):

| Formatter | Use it on | Notes |
|-----------|-----------|-------|
| **Colorbox FF** (`colorbox_field_formatter`) | Text (`string`) and computed fields | The field value becomes the clickable link text. |
| **Colorbox FF (image)** (`colorbox_field_formatter_image`) | Image fields | The image itself is the clickable thumbnail; adds an image-style option. |
| **Colorbox FF (entity reference)** (`colorbox_field_formatter_entityreference`) | Entity reference fields | Always links to the referenced content (the link-destination options are hidden). |

### The settings

Click the settings cog on the field's Manage display row to configure:

- **Style** — `default`, or `colorbox-inline` / `colorbox-node` when the matching
  Colorbox submodules are enabled (inline opens hidden markup via a CSS selector;
  node loads a node into the modal).
- **Link colorbox to** — for the text/computed formatter, choose **Content**
  (link to the entity's own page) or **Manual** (type your own URI). A manual URI
  is run through the Token system when the Token module is installed, so you can
  use tokens like `[node:field_x]` and get a token browser in the form.
- **Width** and **Height** — the popup's size in pixels (defaults 500 × 500),
  passed to Colorbox as query parameters.
- **Open in iframe** — load the target inside an iframe (useful for external
  pages or PDFs).
- **Anchor** — a fragment appended to the URL so the modal jumps to a specific
  part of the page.
- **CSS classes** — extra classes added to the link, for styling or JS hooks.
- **Rel (gallery group)** — give several formatted links the same `rel` value and
  Colorbox shows next/previous arrows to cycle through them as a gallery.
- **Image style** *(image formatter only)* — any image style for the clickable
  thumbnail, or the special **hide** value to suppress the image entirely while
  keeping the Colorbox trigger.

### A quick example

To make an Article's title open its node page in a Colorbox: on *node.article*
Manage display, set the **Title** field's format to **Colorbox FF**, leave **Link
colorbox to** at **Content**, set a width and height, and save. Clicking the title
now opens the node in a lightbox instead of navigating away — handy for keeping
users on a listing page while they preview an item.

Because all settings live in the entity view display config, you can export the
whole setup and reuse the formatters across any content type, media, taxonomy
terms, or Views field displays.
