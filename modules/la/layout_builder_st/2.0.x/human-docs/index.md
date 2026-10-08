# Layout Builder Symmetric Translations — manual setup guide

**Layout Builder Symmetric Translations** (`layout_builder_st`) lets editors
translate the content of a Layout Builder **override** — a per-entity layout — into
other languages. Core Layout Builder does not support translating these overrides;
this module fills that gap. "Symmetric" means every language shares the same layout
structure (the same sections and components), and only the translatable parts —
inline block text and translatable component/block labels — differ per language.

Practically, this means you can build a landing page or homepage once with Layout
Builder, then offer it in several languages without duplicating the layout. Editors
translate the words inside inline blocks and the labels on blocks, while the
arrangement of the page stays in lockstep across all languages. Any structural
change you make — adding, moving or removing a section or component — is
automatically shared by every translation, by design.

There is **no settings form and no configure route**. You "turn it on" by enabling
Layout Builder overrides for a content type and enabling content translation; the
module then does the plumbing for you. When overrides are enabled on a bundle it
automatically adds a hidden, translatable storage field
(`layout_builder__translation`) to hold the translated strings, and it wires
translation into the Layout Builder UI. One important constraint: it is mutually
exclusive with **Layout Builder Asymmetric Translations** (`layout_builder_at`) —
enabling both raises a requirements error, so pick one.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no configuration form. "Configuring" the module means enabling overrides
and content translation, then translating a layout:

1. Enable **content translation** for your site and add at least one extra language.
2. On the content type, go to **Manage display** and, under **Layout options**,
   enable **Allow each … to have their layout customized** (this turns on Layout
   Builder *overrides*). As soon as overrides are enabled, the module adds its
   hidden translation-storage field automatically — you never create a field by
   hand.
3. Create or override a node's layout in the **default language**, adding your
   sections, blocks and inline blocks.
4. Go to the node's **Translate** tab and edit the target-language translation, then
   open its **Layout**.
5. Because the layout is symmetric, you cannot restructure it here — instead you get
   **Translate block** actions. Use them to translate block labels and the content
   inside inline blocks for that language.
6. Save. When the page is viewed in that language, the translated content is swapped
   in automatically.

Keep in mind the trade-off that makes this approach simple: structural edits are
always shared across every language, and only translatable strings and inline-block
content differ per language. If you need genuinely different layouts per language,
you want the asymmetric module instead (and cannot run both at once).
