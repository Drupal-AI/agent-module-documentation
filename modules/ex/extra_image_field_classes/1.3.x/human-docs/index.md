# Extra Image Field Classes — manual setup guide

**Extra Image Field Classes** (`extra_image_field_classes`) does exactly one small,
useful thing: it adds an image field formatter that behaves just like Drupal core's
**Image** formatter but also lets you type extra CSS classes to put on each rendered
`<img>` element. If you have ever needed to add a Bootstrap utility class like
`img-fluid rounded`, a lazy‑load hook, or a class a JavaScript lightbox expects —
without writing a preprocess hook or a custom Twig template — this is the shortcut.

Under the hood it is a thin subclass of the core image formatter, so you keep every
core option (image style, link to content or file) and simply gain one extra
setting: a space‑separated list of class names. Whatever you enter is appended to
the classes on the rendered image markup.

There is no global settings page, no permissions, and no configuration entity —
everything is set behind **Manage Display** on an image field. It works on Drupal 8,
9, 10, and 11, and depends only on core's **Image** module (plus the **Field UI**
module if you want to reach the Manage Display screen; Field UI is not needed to
render).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You use it entirely through the **Field UI**:
at **Structure → Content types →** *(your type)* **→ Manage display**, choose the
*Extra Image Field Classes* format for an image field.

## How to use it

1. Enable the **Field UI** core module if it is not already on, so you can reach
   Manage Display.
2. Go to the **Manage display** page for the bundle whose image field you want to
   style (a content type, media type, and so on).
3. Find your image field and set its **Format** to **Extra Image Field Classes**.
4. Click the gear icon to open the formatter settings. You will see the usual core
   image options (image style, link) plus an **extra classes** text field — enter
   one or more class names separated by spaces (for example `img-fluid rounded`).
5. Click **Update**, then **Save**.

From then on, every image rendered through that display carries your classes on its
`<img>` element, ready for your theme's CSS or a JavaScript library to target. You
can give different view modes (teaser versus full) different classes by configuring
each display separately, and you can set the classes in exported field‑display
config (`core.entity_view_display.*`) for deployment.
