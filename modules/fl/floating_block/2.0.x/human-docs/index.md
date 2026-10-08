# Floating Block — manual setup guide

**Floating Block** (`floating_block`) keeps chosen parts of a page pinned in
place as the visitor scrolls down a long page — the same idea as core's sticky
table headers, but for any element you name. You tell it which parts of the page
to float using ordinary jQuery/CSS selectors (an id like `#sidebar-left`, a
class, and so on), and the module keeps those elements visible while the reader
scrolls through the rest of the content.

The classic use is a sidebar or side menu that stays on screen next to a long
article, but it works for anything: a table of contents, a call‑to‑action box, a
faceted‑search panel, a shopping‑cart summary, or an in‑page jump menu. You can
also fine‑tune each floating element — offset it from the top so it clears a
sticky header, offset it from the bottom near the footer, or constrain it inside
a container so it never overlaps other regions.

Everything is configured from a single admin form; there is no code or template
editing involved. The module only loads its front‑end JavaScript on pages once
you have at least one floating block configured, so it stays out of the way until
you actually use it. It depends only on core's **Block** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, the
   `selector|key=value` line syntax, and the per‑block options, field by field.

## Where it lives in the admin menu

Once enabled, Floating Block's settings form sits at **Configuration → User
interface → Floating Block** (`/admin/config/user-interface/floating-block`). It
adds no menu items or blocks of its own — it simply pins the elements you list.

## How to use it

Enable the module, open the settings form, and list one element to float per
line. In the simplest case a single line like `#sidebar-left` is enough to keep
that element in view as the page scrolls. See
[Configuration](configuration/index.md) for the full line syntax and the
per‑block options (`padding_top`, `padding_bottom`, `container`) and the
`min_width` setting that disables floating on small screens.
