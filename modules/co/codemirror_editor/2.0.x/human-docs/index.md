# The CodeMirror Editor — manual setup guide

**The CodeMirror Editor** (`codemirror_editor`) brings the popular **CodeMirror**
code editor into Drupal, giving you syntax‑highlighted, line‑numbered code editing
and display in several places at once. Wherever people enter or view code —
HTML, CSS, JavaScript, PHP, Twig, Markdown, SQL, and more — CodeMirror makes it
readable with highlighting, a formatting toolbar, tag auto‑closing, and optional
line wrapping and code folding.

It plugs in through several integrations that all share one library and toolbar:

- A **text‑format editor** — turn a text format's plain textarea into a CodeMirror
  instance.
- A **filter** — render code blocks inside content with CodeMirror highlighting.
- A **field widget and formatter** — give editors a proper code field on content
  types (widget) and display stored code read‑only with highlighting (formatter),
  for long‑string and long‑text fields.
- A reusable **`#type => 'codemirror'` form element** — for developers adding a
  code input to a custom form.

A single global settings form controls how the library loads and behaves for
every instance: whether to load CodeMirror from a **CDN** or a locally hosted
copy, whether to use the minified build, which editor **theme** to apply, and
which **language modes** to preload. Language modes are themselves a plugin type —
twelve ship by default (including CSS, JavaScript, PHP, Twig, Markdown, and SQL)
and modules can add more.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (if self‑hosting) download the CodeMirror library.
2. [Configuration](configuration/index.md) — the global settings form and where
   each integration is switched on.

## Where it lives in the admin menu

- The global settings form sits at **Configuration → Content authoring →
  CodeMirror** (`/admin/config/content/codemirror`).
- The individual integrations are turned on in the usual Drupal places: **Text
  formats and editors** (the editor and filter), and a content type's **Manage
  form display** / **Manage display** (the field widget and formatter).

## How to use it

Decide first whether to load the library from a CDN (the default — nothing to
download) or to self‑host it, then set your preferred theme and the language
modes you need on the settings form. After that, switch on whichever integration
fits: enable **CodeMirror editor** on a text format, add the **CodeMirror** widget
to a code field, or use the formatter to display stored code. See
[Configuration](configuration/index.md) for each.
