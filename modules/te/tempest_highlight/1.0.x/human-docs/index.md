# Tempest Highlight — manual setup guide

**Tempest Highlight** (`tempest_highlight`) gives your site fast, server‑side
syntax highlighting for code blocks. It integrates the `tempestphp/highlight`
library so that code entered in CKEditor 5 (for example in a code block) is coloured
and formatted **on the server** when the page is rendered, rather than by a
JavaScript highlighter running in each visitor's browser.

The problem it solves is that client‑side highlighters add JavaScript weight and a
flash of unstyled code while they run; doing the work on the server produces fast,
consistent output with no client‑side highlighter needed. It supports a wide range
of languages, which makes it a good fit for documentation sites, developer blogs,
and any technical content with lots of code samples.

The module depends on Drupal core's **CKEditor 5** module and has no submodules. It
does not add a general admin settings page — the highlighting applies to the code
blocks produced through CKEditor 5's editing experience.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once the module is enabled, code blocks authored in a CKEditor 5‑backed text format
are highlighted server‑side when the content is displayed. Use your text editor's
code‑block feature to add code (choosing the language where the editor offers it),
save, and view the page — the code renders with syntax highlighting already applied.
