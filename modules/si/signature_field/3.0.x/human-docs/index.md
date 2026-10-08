# Signature Field — manual setup guide

**Signature Field** (`signature_field`) adds a field type that captures a
handwritten signature drawn on an HTML5 canvas and stores it as an image. A signer
draws with a mouse, stylus, or finger on a touch device; the module turns those
strokes into a base64‑encoded PNG (a `data:` URL) and saves it to the field, then
displays it back as a plain `<img>`. It's the quick way to add a signature to a
contract, consent, delivery‑confirmation, or work‑order content type without
writing any custom code.

You add it like any other field, on an entity's *Manage fields* tab — there's no
global settings page and no permissions to manage. All of the tuning is done on
the field's widget in *Manage form display*: canvas size, pen stroke width, pen
and background color, whether to show a live thumbnail preview, and whether to show
or hide the raw data box. The signing surface is powered by the
[signature_pad](https://github.com/szimek/signature_pad) JavaScript library, which
loads from a public CDN by default (you can self‑host it if your site must avoid
external assets).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere of its own — there is no configuration page. You work with it entirely
through Field UI: add the field under **Structure → (your content type) → Manage
fields**, and configure its widget under **Manage form display**.

## How to use it

**1. Add the field.** On a content type's **Manage fields** tab, add a new field
and choose the **Signature** field type. You can add more than one (for example a
customer signature and a witness signature) to the same entity.

**2. Configure the widget.** On the **Manage form display** tab, the signature
widget ("Signature Data") offers these settings:

- **Show data box** — show or hide the raw data‑URL textarea. Turn it *off* to
  hide the raw value from signers; the value is still captured and saved. *(On by
  default.)*
- **Show thumbnail** — show a small live preview image that updates as the
  signature is drawn. *(Off by default.)*
- **Canvas width / height** — the size of the drawing area in pixels (defaults
  400 × 200). Set these to fit your form layout.
- **Min / max line width** — the range of pen stroke width, for a consistent look
  (defaults 1 and 2).
- **Pen color** — the ink color (e.g. blue). If core's **Color** module is
  enabled you get a color picker; otherwise it's a plain text field for a hex
  value.
- **Background color** — the canvas background color, handled the same way as pen
  color.

**3. Sign and display.** On the entity's edit form, the signer draws on the canvas
and can hit **Clear** to start over. On submit, the resulting image is saved. On
the entity's view page, the formatter renders the stored signature as an image at
its native size. When an entity that already has a signature is edited, the stored
image is shown and the signer can switch back to the canvas to re‑draw.

> **Self‑hosting the library.** The signature_pad library loads from
> `cdn.jsdelivr.net` by default. If you need to avoid third‑party assets, override
> the `signature_field/signature_pad` library (for example via
> `hook_library_info_alter`) to point at a local copy.
