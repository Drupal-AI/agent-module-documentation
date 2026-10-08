# Textimage — manual setup guide

**Textimage** (`textimage`) renders text onto images on the fly. It pairs the Image
Effects module's **"Text overlay"** effect with your content, so an image style
becomes a reusable template: the effect's default text is swapped out at render
time for text coming from a field, from code, or from a URL. Use it to produce
crisp heading images, banners, watermarks, captions, or social‑share graphics whose
wording is driven by your content instead of hand‑made in a graphics editor.

The core idea is simple: build an **image style** that contains one or more "Text
overlay" effects (plus any resize/background/convert effects you like), and that
style is now a Textimage template. To display a field through it, Textimage ships
two field formatters — one for **text** fields (`textimage_text_field_formatter`,
which works on text, long text, and text‑with‑summary) and one for **image** fields
(`textimage_image_field_formatter`, which overlays text onto an uploaded image).
You select them on an entity's *Manage display* screen.

Beyond the formatters, Textimage offers a fluent PHP API (the `textimage.factory`
service) for building images in code, two tokens
(`[node:textimage-url:field]` / `[node:textimage-uri:field]`) that return a
generated image's location, and optional **direct URL generation** where an image
is built straight from a URL path. Generated files are cached (keyed on style plus
resolved text) and cleaned up on cron.

Textimage is a Media add‑on for core's Image module and the contrib Image Effects
module, and it needs PHP's GD2 and FreeType libraries plus at least one available
font file.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   check the GD2/FreeType prerequisites.
2. [Configuration](configuration/index.md) — the settings form, per‑image‑style
   Textimage options, the field formatters, and the cleanup action.

## Where it lives in the admin menu

The settings form is at **Configuration → Media → Textimage**
(`/admin/config/media/textimage`). You build the template styles under
**Configuration → Media → Image styles**, and you apply the formatters on each
entity type's **Manage display** tab.

## How to use it

1. Create an image style with a **Text overlay** effect (and any other effects you
   want) under **Configuration → Media → Image styles**.
2. On the *Manage display* of the entity whose field you want to render, switch that
   field to the **Textimage** text or image formatter and pick your style.
3. Optionally set a default font and output format on the settings form.

The field‑by‑field details, including the formatter options, are in
[Configuration](configuration/index.md).
