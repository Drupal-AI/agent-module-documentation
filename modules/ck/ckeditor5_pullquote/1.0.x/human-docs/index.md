# CKEditor5 Pullquote — manual setup guide

**CKEditor5 Pullquote** (`ckeditor5_pullquote`) adds a **Pullquote** button to the
CKEditor 5 toolbar so editors can create magazine-style pull quotes without leaving
the editor. You can either **pull from existing text** — select a passage and mark
it as a pullquote, and a small frontend script clones it into a floated aside next
to its paragraph while the original stays in the body flow — or insert a
**standalone custom quote** with its own independently authored text.

Under the hood it's a CKEditor 5 plugin plus a display filter: the button inserts a
`<pullquote>` element, and the filter transforms it into styled markup when the
content is rendered. Because of that, the module's **Filter** must be enabled on
the text formats where you use pullquotes (Drupal registers the required HTML tags
automatically when you add the button). It depends on core's CKEditor 5 and Filter
modules, needs no external libraries, and runs on Drupal 10.5+ and 11.

A few extras worth knowing: pullquotes can carry an optional **cite** attribution
(visually hidden in the editor but present in the rendered markup); the module
applies **alternating odd/even classes** across pullquotes so you can float them
left/right with CSS alone; and you can define **style variants** — named CSS
classes editors pick from a toolbar dropdown — in each text format's plugin
settings. The module ships minimal default styles meant to be overridden in your
theme. It is not covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add the button to a text format and
   set up optional style variants.

## Where it lives in the admin menu

Pullquote has no dedicated admin page. You configure it entirely from a text
format's CKEditor 5 settings at **Configuration → Content authoring → Text formats
and editors** (`/admin/config/content/formats`) — placing the button, enabling the
filter, and defining style variants. See the [Configuration](configuration/index.md)
guide.
