# JSnippet — manual setup guide

**JSnippet** (`jsnippet`) lets you create reusable JavaScript (and CSS) snippets
and attach them to content in a controlled, exportable way. You can either type
JavaScript into a text area or point to a URL for a third‑party resource. Each
snippet you create is wrapped in a Drupal behavior, written to the public file
system, and made available through Drupal's standard libraries system — so it
behaves like a proper asset library rather than ad‑hoc inline code.

The point of the module is **control**. Snippets are stored as configuration
entities, which means they're exportable to your site's codebase and move through
your normal config workflow. To display a snippet you add an entity reference to
the snippet config entity and use its custom Snippet formatter; when the
referencing content is rendered, the snippet's library is attached and the code
runs on that page. This gives you tight, deliberate control over how JavaScript
gets added to a site — rather than letting content editors paste scripts in
ad‑hoc.

> **Important — trust and XSS considerations.** Snippets are JavaScript/CSS that
> run in visitors' browsers, which is effectively arbitrary front‑end code (an
> XSS/defacement risk if misused). There is no server‑side evaluation, but you
> should still keep the ability to create and edit snippets to **fully trusted**
> administrators and developers, and review snippet content. Grant the module's
> permissions accordingly — never to general content editors.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no single settings form** for this module. You work with it by creating
snippet config entities and referencing them from content, described in "How to
use it" below.

## How to use it

1. **Create a snippet.** In the snippet admin listing, add a new snippet and
   either paste your JavaScript into the text area or provide a URL to an external
   resource. Saving it stores the snippet as a config entity and registers it as a
   Drupal library.
2. **Reference it from content.** Add an **entity reference** field that targets
   the Snippet config entity to the content type (or other entity) where you want
   the snippet to run.
3. **Display it.** On that field's Manage display, use the custom **Snippet**
   formatter. When the referencing content is rendered, the snippet's library is
   attached and the code runs on the page.
4. **Export it (optional).** Because snippets are configuration entities, they
   export with the rest of your site config and can be committed to your codebase.
