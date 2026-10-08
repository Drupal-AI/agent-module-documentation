# Element Class Formatter — manual setup guide

**Element Class Formatter** (`element_class_formatter`) is a set of field
formatters that add CSS classes directly to the rendered field **element** — the
`<a>`, `<img>`, list `<ul>`, label, or wrapper tag — rather than to the field's
outer wrapper. That distinction matters when a CSS or JavaScript framework
(Bootstrap, Tailwind, and the like) needs a class on the element itself, which is
otherwise awkward to reach from a Twig template.

It ships twelve formatters, each of which extends one of core's own formatters and
adds an **"Element class"** text field (a space-separated set of classes) plus a
few formatter-specific options. There is **no settings page, no permissions, and
no Drush** — you pick one of these formatters per field on *Manage display*, type
in the classes you want, and save. Because it is pure display configuration, the
result exports with the rest of your configuration and gives editors control of
element classes without touching templates.

For example, you can put `btn btn-primary` straight onto a Link field's anchor,
add `img-fluid` to an image's `<img>`, wrap a plain-text field in an
`<h2 class="card-title">`, or render a multi-value field as a real classed `<ul>`
list.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including every formatter's
settings keys and the reusable traits behind them — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and add the optional Responsive Image submodule.

## How to use it

You use the module entirely from a bundle's **Manage display** page:

1. Go to **Structure → Content types → (your type) → Manage display**
   (`/admin/structure/types/manage/<type>/display`).
2. In the **Format** column for the field you want to style, choose the matching
   Element Class formatter (see the table below).
3. Click the gear icon, fill in **Element class** with the space-separated
   class(es), set any formatter-specific options, click **Update**, then **Save**.

The available formatters, the field types they work on, and their notable extra
settings are:

| Formatter | Field types | Notable extra settings |
|-----------|-------------|------------------------|
| **Link class** (`link_class`) | link | core Link settings (trim length, URL-only, rel, target) |
| **Link (accessible) class** (`link_ally_class`) | link, string | visible text, screenreader-only text, wrapper tag |
| **Link list class** (`link_list_class`) | link | list type (`ul`/`ol`) + core Link settings |
| **Image class** (`image_class`) | image | all core Image settings (image style, link) |
| **File link class** (`file_link_class`) | file | use description as link text, show file size/type |
| **Email link class** (`email_link_class`) | email | adds a class to the `mailto:` link |
| **Telephone link class** (`telephone_link_class`) | telephone | title |
| **Entity reference label class** (`entity_reference_label_class`) | entity reference | linked or plain, wrapper tag |
| **Entity reference list label class** (`entity_reference_list_label_class`) | entity reference | linked or plain, list type |
| **String list class** (`string_list_class`) | string, string_long | list type, linked |
| **List (string) list class** (`list_string_list_class`) | list_string | list type, linked |
| **Wrapper class** (`wrapper_class`) | email, string(_long), text(_long), text_with_summary | wrapper tag (`span`/`div`/`p`/`strong`/`h1`–`h5`), link + link class, summary, trim |

(The Responsive Image submodule adds a `responsive_image_class` formatter for
image fields.)

Each formatter puts the class in the right place for the element it targets — on
the link's `<a>`, the image's `<img>`, the list wrapper, or the chosen HTML tag.
The full list of per-formatter settings keys is in the
[`agent/`](../agent/configure/formatters.md) docs.

## Where it lives in the admin menu

The module adds **no admin page** of its own. You use it from the **Manage
display** tab of whatever entity has the field
(`/admin/structure/types/manage/<type>/display`), where its formatters appear in
the field's format dropdown.
