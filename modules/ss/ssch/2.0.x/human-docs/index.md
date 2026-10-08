# Server sided code highlighting — manual setup guide

**Server sided code highlighting** (`ssch`) adds a dedicated *Code snippet* field
to Drupal that renders syntax-highlighted code — but does the highlighting on the
web server rather than in the visitor's browser.

Most code-highlighting solutions ship a JavaScript library that colors the code
after the page loads in the browser. That works, but it depends on JavaScript
running, and it produces a brief "flash of unstyled code" before the script
catches up. This module takes a different approach: it uses the `highlight.php`
library (a PHP port of the popular `highlight.js`) to generate the highlighted
markup on the server. The result can be cached like any other rendered content,
does not rely on client-side JavaScript, and appears fully styled the moment the
page arrives.

You add it as a field. The module provides a **Code snippet (server-sided code
highlighting)** field type that can be attached to any fieldable entity — nodes,
Paragraphs, custom entities, and so on. Its widget gives content authors a text
area for the code plus a dropdown to pick the programming language (185 languages
are supported), and its formatter lets you choose whether your theme styles the
highlighting or whether one of the 94 bundled stylesheets is delivered to the
browser. The highlighter escapes the code it renders, so it is intended for
displaying code as content; it plays no access-control role.

This module depends on core's **Field** module, the contributed **Vendor Stream
Wrapper** module, and the `scrivo/highlight.php` library — all of which Composer
pulls in automatically when you require the module. It runs on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its library
   with Composer, and enable it.

## How to use it

There is no central settings page. Once the module is enabled, the feature
surfaces as a field you add through the normal Field UI:

1. Go to **Structure → Content types** (or any other entity type) and open
   **Manage fields** for the bundle you want to add code snippets to.
2. Add a new field of type **Code snippet (server-sided code highlighting)**.
3. On the field's form-display settings, the widget presents a text area for the
   code and a language selector (choose from the 185 supported languages).
4. On the field's display settings, the formatter lets you decide whether your
   own theme styles the highlighting, or whether one of the 94 included
   stylesheets is served to the browser.

From then on, content authors editing that bundle can paste code into the field,
pick its language, and the highlighted result renders server-side on the
published page.
