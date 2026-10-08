# Snippet Manager — manual setup guide

**Snippet Manager** (`snippet_manager`) lets you manage reusable pieces of Twig
code — "snippets" — as entities you edit in the admin UI and render around your
site. Reusable bits of markup or logic (a formatted address, a call‑to‑action, a
small computed widget) tend to end up scattered across templates and custom
blocks. Snippet Manager centralises them in one place.

A snippet is a Twig template with its own variables. You can render a snippet as
a **block** (placing it through the normal Block layout UI) and you can embed one
snippet inside another with the provided `snippet()` Twig function, and pull in
views and blocks from within a snippet. Snippets render through Drupal's standard
Twig (`inline_template`) — the same engine that renders your theme templates.

Because a snippet author is effectively writing Twig that renders on the live
site, creating and editing snippets requires the **`administer snippets`**
permission, and that is a **high‑trust** capability — comparable to letting
someone edit theme templates or run arbitrary PHP. Grant it only to developers
and trusted site builders, never to ordinary content editors. Used as intended,
it is a clean way to keep reusable snippets organised; the one rule is to keep
`administer snippets` narrow.

The module depends on core's **Filter** (`filter`) and **File** (`file`)
modules, and on the contributed **CodeMirror Editor**
(`codemirror_editor`) module, which provides syntax highlighting for editing
snippet code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer, then enable it.

## How to use it

After enabling the module, an administrative interface for managing snippets
becomes available to users with the **`administer snippets`** permission. From
there you create a snippet, give it a machine name, write its Twig markup and
declare any variables it uses, and save it. A saved snippet can then be rendered
as a block through **Structure → Block layout**, or embedded inside another
snippet with the `snippet()` Twig function. There is no separate site‑wide
settings form — the module is administered entirely through the snippet entities
you create.
