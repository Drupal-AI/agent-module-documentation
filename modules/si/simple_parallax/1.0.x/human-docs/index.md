# Simple Parallax JS — manual setup guide

**Simple Parallax JS** (`simple_parallax`) adds a **parallax scroll animation** to
images on your Drupal site. As a visitor scrolls the page, images move at a
slightly different speed than the surrounding content, which creates a sense of
depth — the "parallax" effect you see on many modern marketing and landing pages.

It works by wrapping the lightweight [simpleParallax.js](https://simpleparallax.com/)
JavaScript library in a Drupal **image field display formatter** called *Simple
Parallax*. You don't write any JavaScript: you point an image or media field's
display at this formatter and the animation is applied automatically. The effect is
deliberately minimal to configure.

The module has no admin settings page of its own — you enable the effect by
choosing the *Simple Parallax* formatter on an image or media field's display
settings. It has one setup wrinkle worth knowing before you install: it relies on
the third-party `simple-parallax-js` JavaScript library, which you install
alongside the module (see [Installation](installation/index.md)). It has no other
module dependencies and no submodules.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module and the
   simpleParallax.js library, then enable it.

## How to use it

Once the module and its library are installed and the module is enabled:

1. Go to the **Manage display** screen for the entity that has your image or media
   field (for example **Structure → Content types → Article → Manage display**).
2. For the image (or media) field, change its **Format** to **Simple Parallax**.
3. Save the display.

Images rendered through that field now animate with the parallax effect as the
visitor scrolls. Because it is a display formatter, the same image data works
normally everywhere else — only this particular display gets the animation.
