# Layout Paragraphs Disable Duplicate — manual setup guide

**Layout Paragraphs Disable Duplicate** (`layout_paragraphs_disable_duplicate`)
lets you switch off the **Duplicate** button that
[Layout Paragraphs](https://www.drupal.org/project/layout_paragraphs) shows on
components in its drag‑and‑drop builder — and it lets you do it on a
per‑paragraph‑type basis. Layout Paragraphs renders a small toolbar of controls
(edit, delete, duplicate, drag to reorder) on every component. For most content
that is exactly what you want, but some paragraph types should never be copied: a
hero banner that must appear only once, a wrapper or "section" component, or a
type that carries a unique HTML ID or anchor.

Rather than patching the builder or hiding the button with fragile CSS, this
module gives you a single settings form where you tick the paragraph types whose
Duplicate control should disappear. Everything else — edit, delete, drag, reorder
— stays exactly as it was, and every other paragraph type keeps its Duplicate
button. Because the module uses Layout Paragraphs' own access mechanism, the
Duplicate link is not rendered at all for the types you choose, rather than merely
hidden from view.

The settings you pick apply everywhere Layout Paragraphs is used, including
editors built on top of it such as **Mercury Editor**. The module adds no new
content types, text formats, or permissions of its own — it simply reads your list
of "disabled" types and removes the control for them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Paragraphs and Layout Paragraphs.
2. [Configuration](configuration/index.md) — choose which paragraph types have
   their Duplicate control hidden.

## Where it lives in the admin menu

Once enabled, the module adds a **Disable Duplicate** tab to the Layout Paragraphs
settings area at **Configuration → Content → Layout Paragraphs settings →
Disable Duplicate**
(`/admin/config/content/layout_paragraphs/disable-duplicate`). You need the
**Administer site configuration** permission to open it.
