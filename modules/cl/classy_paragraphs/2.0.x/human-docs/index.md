# Classy Paragraphs — manual setup guide

**Classy Paragraphs** (`classy_paragraphs`) gives editors a controlled way to **apply CSS
classes to Paragraph items** — so a non‑developer can pick, say, a background color or a
button style for a paragraph from a drop‑down, without touching code or theme files. Site
builders define a menu of approved "styles" (each a named set of one or more CSS classes) and
editors simply choose one on the paragraph edit form.

It works in two parts. First, you create **styles** as configuration entities from a small
admin screen — each style is a label plus a list of classes (one per line), e.g. a "Loud"
style carrying `loud-background text-uppercase`. Second, you add a normal core **entity
reference field** to a Paragraph type (or any other entity) that points at those styles;
editors then pick a style with a select list or checkboxes. When the content renders, the
module automatically merges the referenced style's classes into the paragraph's wrapper
attributes (the `{{ attributes.class }}` in Twig), so the classes land on the markup with no
extra formatter and nothing printed as visible field output.

Because styles are configuration, they export and deploy with your normal config sync — so
the approved class list goes through code review and travels between environments. The module
adds **no new field type** of its own (you use a core entity‑reference field), no permissions
of its own (the styles screen is gated by core's *Administer site configuration*), and no
Drush commands. It depends on the **Paragraphs** module. It does not integrate with Display
Suite or Panelizer.

This guide is written for a **human** building styles and fields in the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it brings in Paragraphs)
   and enable the module.
2. [Configuration](configuration/index.md) — create styles, then add the class‑picker field
   to a Paragraph type and hide it on display.

## Where it lives in the admin menu

The style catalog is managed at **Structure → Classy paragraphs style**
(`/admin/structure/classy_paragraphs_style`) — this is the module's `configure` link. The
class‑picker field itself is added on the Paragraph type under **Structure → Paragraph types
→ *your type* → Manage fields**, the same place you add any other field.
