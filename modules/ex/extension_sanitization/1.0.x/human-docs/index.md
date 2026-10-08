# Filename extension sanitization — manual setup guide

**Filename extension sanitization** (`extension_sanitization`) removes **duplicated
file extensions** from uploaded filenames. It collapses names like
`image.jpeg.jpeg` (→ `image.jpeg`) or `file.jpg.png.gif` (→ `file.gif`): for each
`.`-separated segment between the base name and the final extension, if that segment
is itself one of the field's **allowed extensions** it is dropped, so the name keeps
just its base and its real trailing extension. The main reason that matters is
practical: duplicated extensions confuse derivative generators — a tool that produces
`example.jpeg.webp` from `example.jpeg` can end up chasing mismatched names when the
original is `example.jpeg.jpeg`.

This is a small, defense-in-depth hygiene measure and it works quietly in the
background once enabled — there is nothing to configure. Keep the framing in mind,
though: it cleans up one specific shape (repeated allowed extensions) and
**complements, it does not replace**, Drupal core's own upload protections. You still
want a correct allowed-extensions list on your file fields, core's filename munging,
and uploads served from a location that never executes code. It has no
content-access role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings form** for this module — it starts sanitizing uploaded
filenames as soon as it is enabled.

## Where it lives in the admin menu

Filename extension sanitization adds no admin configuration page. Once enabled it
acts automatically on file uploads across the site; there is nothing to click.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. That's it — uploaded filenames with duplicated extensions are collapsed
   automatically from then on.
3. Treat it as one layer among several: confirm your file fields' **allowed file
   extensions** are still restrictive, and that uploaded files are stored where the
   web server will not execute them.
