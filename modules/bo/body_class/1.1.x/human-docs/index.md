# Body Class — manual setup guide

**Body Class** (`body_class`) lets you add a custom CSS class to the `<body>` tag
on a **per‑node** basis. Where core gives the whole site the same body markup,
this module lets a specific piece of content carry its own class, so you can
target that page with custom CSS or JavaScript — for example to give one landing
page a distinct look without touching every template.

The class is stored with the node and emitted into the body tag's `class`
attribute when the page renders. It is a content‑display and theming convenience;
it has no access‑control role. This release supports Drupal 9, 10 and 11.

Because the class value is written into the page's HTML, treat it as a
**trusted‑editor** setting: constrain it to valid class tokens and restrict who
may set it, via the module's permission, so a free‑text value cannot be used to
inject unexpected markup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

The module ships settings at `body_class.settings` and provides its own
permission:

1. Under **People → Permissions** (`/admin/people/permissions`), grant the
   Body Class permission only to the trusted editor roles that should be able to
   set body classes.
2. When adding or editing a node, enter the CSS class you want on that page's
   `<body>` tag.
3. Save the node. The class is emitted into the body tag, ready for your CSS or
   JavaScript to target.

Keep values limited to valid class names — the field is emitted into the `class`
attribute, so it should not be able to carry markup.
