# AI Image Filename — manual setup guide

**AI Image Filename** (`ai_image_filename`) gives uploaded images sensible,
descriptive filenames instead of the camera-generated `IMG_4821.jpg` or
`Screenshot 2026-01-02 at 14.03.png` that editors usually drop in. When an image
is uploaded it is sent to an AI vision model, which "looks" at the picture and
returns a short description; the module uses that to rename the file to something
readable like `red-bicycle-leaning-on-brick-wall.jpg`. Better filenames help both
SEO and accessibility, since search engines and assistive tools read the filename
as a signal of what the image shows.

The module builds on Drupal's **AI** module, which supplies the connection to a
language/vision model. You choose and configure that provider (and its API key)
once in the AI module; AI Image Filename simply reuses it. It also depends on
core's **File** module.

Because renaming happens by sending the image to an external AI provider, each
upload is transmitted out of your site to that provider over HTTPS. Confirm that
sending your image content to a third party is acceptable for the material you
host, and keep the provider's API key stored as a secret through the AI module's
Key configuration — never paste a key into plain module settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and make sure an AI provider is configured.

## Where it lives in the admin menu

AI Image Filename has no settings form of its own — its behavior is driven
entirely by the AI provider you configure in the **AI** module (at
**Configuration → AI**). Once the module is enabled and a working text/vision
provider is in place, renaming happens automatically as part of the normal image
upload flow.

## How to use it

1. Enable the module and confirm the AI module has a provider configured that can
   describe images (see [Installation](installation/index.md)).
2. Upload an image the way you normally would — through a media form, an image
   field, or the media library.
3. The module sends the image to the AI provider, gets back a short description,
   and saves the file under a descriptive, URL-friendly filename. From then on the
   image behaves like any other managed file in Drupal.
