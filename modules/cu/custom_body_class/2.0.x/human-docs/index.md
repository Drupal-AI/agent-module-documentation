# Custom body class — manual setup guide

**Custom body class** (`custom_body_class`) lets editors add CSS class names to
the `<body>` tag of a node's page — without touching Twig templates or writing a
custom preprocess module. It's the ready-made way to give a page (or a whole
content type) a styling hook that your CSS or JavaScript can target.

You can add classes in three ways, and they combine. Per **individual node**, an
"Add CSS class(es)" field on the node form lets an editor type one or more
space-separated classes for just that page — handy for a one-off landing page, a
campaign promo, or a seasonal decoration. A per-node **checkbox** can
automatically add the node's content-type machine name as a class (so an Article
node gets `article` on its body). And per **content type**, a field on the node
type edit form applies the same class(es) to every node of that bundle — for
example tagging every blog post with `blog-post`.

On each page load the module reads whichever of these apply to the current node
and appends them to the body tag's class attribute, in a predictable order. The
class fields are translatable, and a validator blocks stray special characters so
you keep to normal CSS-identifier characters. There's **no settings page**, no
permissions, and nothing site-wide to configure — everything is driven by the node
fields and the per-content-type setting. It works on any node type out of the box.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere on its own — this module has no settings page. You set body classes in two
familiar places:

- **On a node** — in the *Custom Body Class Settings* group on any node's add/edit
  form.
- **On a content type** — in the *Custom Body Class Settings* group on the node
  type edit form (**Structure → Content types → *(type)* → Edit**,
  `/admin/structure/types/manage/*(bundle)*`).

## How to use it

### Add a class to a single node

1. Edit (or create) the node.
2. Open the **Custom Body Class Settings** group.
3. In **Add CSS class(es)**, type one or more classes separated by spaces (for
   example `promo-page featured`).
4. Optionally tick **"If checked, add name of node type as class to body tag"** to
   also add the content type's machine name.
5. Save. The classes now appear on that page's `<body>` tag.

### Add a class to every node of a content type

1. Go to **Structure → Content types**, and edit the type.
2. In the **Custom Body Class Settings** group, fill in the **CSS class(es)**
   field (for example `campaign-2026`).
3. Save. Every node of that type now carries those classes on its `<body>`.

### How the classes combine

When a page renders, the module appends, in order: the node's own classes, then
the content-type machine name (if the per-node checkbox is ticked), then the
content type's stored classes. All of them land on the body tag's `class`
attribute, so a single page can carry a mix of node-specific and content-type-wide
classes.

### Keep the class names clean

Stick to normal CSS identifier characters — letters, digits, `-`, and `_` — with
spaces to separate multiple classes. The module rejects a set of special
characters (such as `^ £ $ % & * ( ) { } @ # ~ ? > < , | = +`) with a form error.
