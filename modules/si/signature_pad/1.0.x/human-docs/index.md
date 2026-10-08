# Signature pad — manual setup guide

**Signature pad** (`signature_pad`) is a **field widget** for core image fields
that replaces the file-upload control with a drawing canvas. A user draws with the
mouse or a finger, and the drawing is saved as an image file on the entity —
handy for e-signature-style capture on agreements, consent forms, and delivery
confirmations, and equally for capturing simple freehand images.

It is more flexible than a plain signature widget: you can save the drawing as
**SVG, PNG, or JPG**, choose the initial background color, store the raw stroke
data so the drawing can be edited again later, set the canvas height, width, or
aspect ratio, require a minimum number of strokes for validation, let the user
pick pen color (with a jscolor picker) and pen size, and offer an Undo button. The
underlying signature-pad JavaScript is fetched from the jsDelivr CDN, so there is
no library to download. Note that if you save as SVG, your image toolkit must
support SVG — for example ImageMagick.

The module depends only on core's **Image** module and has no submodules or
central settings form — all of its options are set on the **widget** in an
entity's *Manage form display*. One thing to be clear about: a drawing captured
this way is an *image of a signature*, not a cryptographically verifiable
e-signature. It is appropriate for lightweight consent and acknowledgement, not
for legally binding digital signatures, which need a proper e-signature service.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no settings page. You configure everything on the field widget:

1. Add (or reuse) an **image** field on the entity where you want a drawn
   signature or image.
2. Go to that entity's **Manage form display**, and for the image field choose the
   **Signature pad** widget type.
3. Open the widget's settings (the gear icon) to pick the output format (SVG, PNG,
   or JPG), background color, canvas dimensions or aspect ratio, minimum strokes,
   pen color/size options, and whether to keep raw stroke data for later editing.

Because the drawing is stored as a normal managed image file on the entity, it
inherits the standard field and entity access controls of whatever content type
or entity carries it.
