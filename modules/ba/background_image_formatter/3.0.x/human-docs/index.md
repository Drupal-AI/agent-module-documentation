# Background Image Formatter — manual setup guide

**Background Image Formatter** (`background_image_formatter`) lets you display an
image field as a CSS `background-image` instead of a regular `<img>` tag. That's
exactly what you want for hero banners, full-bleed section backgrounds, card
backgrounds, and mastheads — places where the image is a backdrop for other
content rather than a picture in the flow of the page. Editors upload an image to
a field as usual; the theme decides nothing; the image simply becomes the
background of a `<div>` (or of a selector you name).

The module adds two field formatters, both labeled **Background Image**. One works
on plain **image** fields; the other works on **entity_reference** fields that
point at **media** (it reads the referenced media entity's thumbnail image), so
you can drive a background from your media library. You choose which to use on the
field's **Manage display** tab — there is no separate settings page.

When you configure the formatter you pick an **image style** (so the background
uses an appropriately sized derivative, or the original if you leave it empty) and
decide how the background is written to the page. In **inline** mode it renders a
`<div>` with a `style="background-image:url(...)"` attribute, and it appends the
entity id to your selector so multiple items on one page never collide — great for
a multi-value image field driving a row of cards or a slideshow. In **CSS** mode
it instead injects a `<style>` rule targeting a CSS selector you specify, which is
handy when several page elements should share one field-driven background. Inline
mode can also wrap the background div in a link — either to the host entity or to a
custom URL, and that custom URL supports tokens when the
[Token](https://www.drupal.org/project/token) module is installed.

Under the hood it integrates with core image styles (generating derivatives as
needed) and provides granular theme suggestions per entity type, bundle, field,
and entity id, so front-end developers can override the markup precisely. It has
**no admin settings page, no route, no permission, and no Drush command** — it is
configured entirely on the field's Manage display.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the formatter
settings and the theme hook — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Background Image Formatter has **no settings page of its own**. You use it on the
**Manage display** tab of whichever entity carries the image field — for example
an Article at **Structure → Content types → Article → Manage display**
(`/admin/structure/types/manage/article/display`). It also works on a View's
field settings when you display an image field through Views.

## How to use it

1. Make sure you have an **image** field (or an **entity_reference** field
   targeting media) on the entity you want a background for.
2. Go to that bundle's **Manage display** tab.
3. Find the field's row and set its **Format** to **Background Image**.
4. Click the gear/cog icon to open the formatter settings and choose:
   - **Image style** — which derivative to use (leave empty for the original
     image).
   - **Output type** — **Inline** (a `<div>` with an inline `style` attribute) or
     **CSS** (a `<style>` rule injected into the page head).
   - **CSS selector** — the class or selector the background is applied to. In
     inline mode the entity id is appended automatically so each item is unique.
   - *(Inline mode only)* whether to **wrap the div in a link**, and an optional
     **custom link URL** (which accepts tokens when the Token module is enabled).
5. Click **Update**, then **Save**.

From then on, that field renders as a background image wherever the view mode is
displayed. Change the section's look by uploading a new image to the field — no
theme edits needed.
