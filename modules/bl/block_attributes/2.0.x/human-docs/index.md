# Block Attributes — manual setup guide

**Block Attributes** (`block_attributes`) lets site builders attach arbitrary
HTML attributes — a CSS `class`, an `id`, `data-*` hooks, ARIA attributes like
`role` or `aria-label`, `lang`, `title`, and so on — to blocks, without writing
template overrides. It works in two steps: you define, once and site‑wide, the
list of attributes editors are allowed to set, and then you fill in the actual
values on each individual block's configuration form.

The global list lives in a small settings form where you describe each attribute
with a label, optional help text, and optionally a fixed set of preset options
(which turns that attribute's per‑block input into a dropdown instead of a free
text field). Once an attribute is defined, an **Attributes** section appears on
every block's configuration form with one input per attribute. Whatever you enter
is stored with the block and merged onto its wrapper when the page renders — a
space‑separated value such as `promo featured` becomes two separate classes. Out
of the box the module defines a single attribute, `class`.

The module depends only on core's **Block** module. It defines no permissions of
its own: managing the global list uses core's *Access administration pages*
permission, and setting values on a block uses core's *Administer blocks*. Both
of those are trusted, admin‑level permissions — attribute values render into your
site's markup, so grant them only to roles you trust.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — define the global attribute list and
   set values on individual blocks.

## Where it lives in the admin menu

The global attribute list is edited at **Structure → Block layout → Attributes**
(`/admin/structure/block/attributes`). The per‑block inputs appear inside each
block's own **Configure** form under **Structure → Block layout**.
