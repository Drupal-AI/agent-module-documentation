# Attach Inline — manual setup guide

**Attach Inline** (`attachinline`) is a developer tool that lets a render array
carry an **inline JavaScript or CSS snippet directly**, without you having to define
a whole library file for a two‑line snippet.

Drupal's asset system is deliberately strict: assets come from libraries, libraries
are declared in a `*.libraries.yml`, and code attaches them by name. That design
buys aggregation, dependency ordering, cache correctness, and a single place to
audit what a page loads — but it is genuinely awkward for the one case it does not
cover: a snippet that exists only for one render array and has no meaningful life as
a reusable library. Drupal 7 did this in one line with `drupal_add_js($js,
'inline')`; without a replacement, people tend to paste a `<script>` tag into
markup, which bypasses the asset pipeline and every protection in it. Attach Inline
supplies the missing path *properly* — it decorates Drupal's asset resolver so
inline snippets travel through the same machinery as everything else, rather than
around it.

It has **no configuration, no routes, and no permissions**, and no dependencies. It
runs on Drupal 10 and 11. Use it with the same discipline the library system
otherwise enforces, and mind two things:

- An inline snippet is **not aggregated and not separately cached** — it is paid for
  on every render of that element.
- **Never build a snippet by concatenating request or content data.** Inline
  JavaScript is the classic XSS delivery point; the risk starts the moment a snippet
  is assembled from a variable rather than written as a constant.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere. Attach Inline is a code‑level tool with no admin pages, settings form, or
permissions. You use it from a render array in your own module or theme.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. In your own module or preprocess code, attach an inline snippet to the render
   array that needs it, using the module's inline asset keys instead of pointing at
   a declared library. The snippet then flows through Drupal's normal asset
   resolution.
3. **Keep it safe and small:** write the snippet as a constant string, never
   assembled from user input or content, and reserve it for genuinely one‑off cases
   (initialising a widget, passing a small config value, a scoped style) rather than
   anything reusable — reusable assets still belong in a real library.
