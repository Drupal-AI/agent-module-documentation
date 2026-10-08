# D2: Declarative Diagramming — manual setup guide

**D2: Declarative Diagramming** (`d2`) generates **SVG diagrams from D2 syntax**.
D2 is a text‑based diagram language: you write a compact description of the
boxes and arrows you want, and D2 renders it into an SVG. This module takes that
D2 input, produces the SVG through the D2 renderer, caches the result, and
displays it.

The primary use case is programmatic — a developer calling the module's
`D2Helper` to turn D2 markup into a cached SVG. There is also an optional
**`d2_filter`** text‑filter submodule, which is the easiest way to get started:
enable it and configure a text format to use it, and editors can then embed D2
diagrams directly in content.

Two operational points are important before you rely on it. First, the module
**shells out to the `d2` binary** — it runs the D2 command‑line tool through a PHP
wrapper (using Symfony Process, which passes arguments as an argv array rather
than a shell string, so naive shell injection is avoided). That means the `d2`
executable must be installed on the server and kept up to date. Second, the output
is an **SVG rendered on the page**, and SVG can carry active content, so you
should treat **D2 input as trusted (editor‑level)** and gate who can supply it via
the module's permission — don't expose D2 authoring to untrusted users. The
module requires **Drupal 11** and provides its own permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, install the
   `d2` binary on the server, and enable the module (and optionally the
   `d2_filter` submodule).

## How to use it

- **The easy path:** enable the **`d2_filter`** submodule, then go to
  **Configuration → Content authoring → Text formats and editors**, edit a text
  format, and enable the D2 filter for it. Content authored in that format can
  then embed D2 diagrams, which render as cached SVGs.
- **The programmatic path:** in custom code, call
  `\Drupal\d2\D2Helper::getSvg($d2_input, $d2_options)` to generate an SVG (or use
  a cached copy — recommended). For an uncached SVG you can call the underlying
  library directly.

## Security note

Because D2 diagrams render as SVGs and SVG can carry active content, **only let
trusted, editor‑level users supply D2 input**, and gate that with the module's
permission. Don't expose D2 authoring to anonymous or untrusted users.
