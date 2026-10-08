# Image Field in Text if None — manual setup guide

**Image Field in Text if None** (`imagefieldintextifnone`) inserts the picture
from an image field into a long-text field — such as the body — when you view the
content, but only if the text does not already contain an image. The idea is
simple: an article often has a "main image" that appears in the teaser, and if
the body text has no image of its own, the page reads better with that main image
placed early in the copy rather than the article opening as a wall of text.

The insertion happens at **display time only**. When the content is rendered, the
module looks at the processed body, checks the first few paragraphs for an
existing `<img>`, and — if it finds none — works out a sensible spot (typically
just before the second paragraph, so the image sits between the first and second
paragraphs) and splices the rendered image field in there. It can also hide the
standalone image field once the picture has been folded into the text. Your
stored content is never modified; the body still passes through its text format
filters as usual.

Two important limitations are worth knowing before you install it. First, this
release is **hard-coded**: it maps `field_image` into the `body` field of the
**Article** content type in the `full` view mode, and there is no settings screen
yet — making it configurable is on the roadmap. If that mapping matches your site
you can use it as-is; if not, it will not do anything useful until the code is
extended. Second, it is **incompatible with Layout Builder**, which moves fields
into structures this module cannot splice into.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. The behaviour is defined in
code (Article's `field_image` into `body`, `full` view mode) and there is no
settings form to fill in. See "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. It works automatically whenever a matching entity
(an Article node in the full view mode) is displayed.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Make sure your site has the shape the module expects: an **Article** content
   type with an image field named **`field_image`** and a **`body`** field.
3. View an Article whose body text contains no embedded image. The image from
   `field_image` is inserted into the body, between the first and second
   paragraphs, when the page renders.
4. If the body already has an embedded image, the module leaves it alone, so
   editors who prefer to place an image manually keep full control.

> **Styling tip.** The inserted image is given an alignment class, so you can use
> CSS to control how it sits — for example centered above the second paragraph on
> mobile and inset to the top right on wider screens.
