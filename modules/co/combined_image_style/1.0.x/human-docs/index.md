# Combined image style — manual setup guide

**Combined image style** (`combined_image_style`) is a drop‑in replacement for
Drupal's image‑style system that lets you combine the output of **several image
styles** into a single derivative. Instead of building one big image style for
every shape‑and‑size combination you need, you keep small, focused styles and
stack them. For example, if you have cropping styles *portrait*, *square*, and
*landscape*, and sizing styles *thumbnail*, *medium*, and *large*, combining them
on demand means you maintain 6 styles rather than the 9 you'd otherwise need for
every pairing.

It "just works" alongside core: the two systems keep running side by side. Under
the hood it combines the image‑style machine names to build the derivative's
folder structure and uses `itok` tokens for the same access‑token security core
uses. This is primarily a **developer** tool — you generate combined derivatives
from PHP using a small fluent API (`CombinedImageStyle`) — but it also ships an
optional submodule, **Combined image style formatters**
(`combined_image_style_formatters`), that adds a couple of basic field formatters
for image and media (entity‑reference) fields so you can use combined styles
without writing code.

This is a media/display feature. It affects how image derivatives are generated;
the images themselves are ordinary content, and it plays no access‑control role.
It supports Drupal 10.2 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the formatters submodule.

There is **no central configuration page** for this module. You either call its
API from code, or use the formatters submodule on a field's *Manage display*, as
described in "How to use it" below.

## Where it lives in the admin menu

Combined image style adds no settings form of its own. Its building blocks are the
ordinary image styles you manage at **Configuration → Media → Image styles**
(`/admin/config/media/image-styles`). If you enable the formatters submodule, you
configure it on your image/media field's **Manage display** under
**Structure → Content types → *(type)* → Manage display**.

## How to use it

There are two ways to produce a combined derivative:

**From code** — use the fluent `CombinedImageStyle` API, naming the styles you want
to combine in order:

```php
// Return a render array for the combined derivative.
(new CombinedImageStyle())
  ->setSourceUri($uri)
  ->setImageStyles(['square', 'thumbnail'])
  ->toImage();

// Return the combined image-style URI (build it if needed).
(new CombinedImageStyle())
  ->setSourceUri($uri)
  ->setImageStyles(['square', 'large'])
  ->buildCombinedUri(TRUE);
```

**From the UI** — enable the `combined_image_style_formatters` submodule and pick
one of its formatters on an image or media entity‑reference field's *Manage
display*, choosing the styles to combine there.
