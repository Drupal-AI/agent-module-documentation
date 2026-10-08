# Syntax Highlighting Field Formatter — manual setup guide

**Syntax Highlighting Field Formatter** (`syntax_highlighting_field_formatter`) is a
field formatter that displays the value of a text or string field as
syntax-highlighted source code instead of plain body text. If you have a field where
authors paste code — a snippet on a tutorial, a config example in documentation, a
command-line example in help text — this formatter renders it as a readable,
highlighted code block rather than run-of-the-mill prose.

It adds a single formatter plugin that applies to `string_long`, `text_long`, `text`
and `text_with_summary` fields. A nice property, per the module's own description, is
that it does the highlighting with PHP's built-in `highlight_string()` function, so
there is **no third-party library dependency** (no GeSHi or similar) to install or
maintain. It is a display-only concern: it changes how a field's stored value is
shown, not how the value is entered or saved, and it adds no admin routes,
permissions or services. Its trust boundary is the same as the field it formats,
since it only re-presents values the author already controls. It has no module
dependencies and ships no submodules.

This guide is written for a **human** setting the module up through the admin UI. If
you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no settings page to configure — you turn the formatter on per field, per
view mode. Go to the entity's **Manage display** screen (for example, for a content
type: **Structure → Content types → *your type* → Manage display**), find the
code-bearing field, and switch its **Format** to *Syntax Highlighting Field
Formatter*, then save. Because it is chosen per view mode, you can highlight the code
in the full view while leaving it plain in the teaser. Once set, that field's stored
value is rendered as highlighted source code wherever that display is used.
