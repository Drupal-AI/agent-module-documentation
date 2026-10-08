# Text File Viewer — manual setup guide

**Text File Viewer** (`text_file_viewer`) is a field formatter that displays the
*contents* of an uploaded text file directly on the page, with syntax
highlighting, instead of showing only a download link. Point a file field at
this formatter and readers can see the text of a `.txt`, `.md`, source or log
file inline, rather than having to download it first to find out what is in it.

The highlighting is provided by **Prism.js**. The module supports syntax
highlighting for a range of file extensions, gives you configurable display
options to control formatting and appearance, and can load the Prism library
either from an external source or from a local copy you place in the module — so
you can choose between convenience and self-hosting.

Text File Viewer runs on Drupal 10 and 11, has no other module dependencies, and
provides its own permission. The formatter operates on the managed file entity's
URI, so it respects the access control already applied to the file field — it
does not bypass field-level access. The maintainers list it as minimally
maintained (maintenance fixes only) and the release covered here is a beta.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose the Prism library location,
   the enabled file extensions, and apply the formatter to a file field.

## How to use it

The module surfaces as a display option on file fields. On the **Manage
display** screen of any content type (or other entity) that has a file field,
choose the Text File Viewer formatter for that field. When the entity is viewed,
the file's text contents are rendered inline with syntax highlighting instead of
appearing as a plain download link.
