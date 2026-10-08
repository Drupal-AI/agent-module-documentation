# Layout Paragraphs Restrictions — manual setup guide

**Layout Paragraphs Restrictions** (`layout_paragraphs_restrictions`) lets you
control which Paragraph (component) types editors can place **where** inside
[Layout Paragraphs](https://www.drupal.org/project/layout_paragraphs) layouts. You
write rules that match a context — the parent layout type, a specific region, the
layout plugin, the field name, the entity type, or the bundle — and either **allow
only** a set of components there or **forbid** specific ones. It's how you stop
editors from dropping unsupported components that would break your design system,
without writing custom code.

Rules are authored as **YAML** in a single admin settings form. Each named rule
pairs a `context` (one or more sets of conditions) with an allow list
(`components`) or a deny list (`exclude_components`). Enforcement happens on the
server through an event subscriber that trims the list of component types offered
in the "add component" dialog before it is built, so editors only ever see valid
choices. A companion JavaScript guard re‑checks the same rules during
drag‑and‑drop, giving live "This component cannot be moved here" feedback, and can
optionally **transform** a component into an allowed variation on drop instead of
rejecting it.

Context values support `!` negation (for example `region: '!_root'` means "any
region except the top level"), and `_root` denotes the top level of a Layout
Paragraphs field. Rules can also target Mercury Editor templates. The module
depends only on the **Layout Paragraphs** module, adds no permissions of its own
(the settings form uses core's *Administer site configuration*), stores its rules
as exportable configuration, and has no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the full context
key list and how enforcement works — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   required Layout Paragraphs dependency) and enable the module.
2. [Configuration](configuration/index.md) — the restrictions settings form and how
   to write allow/deny rules.

## Where it lives in the admin menu

Once enabled, the rules are edited at **Configuration → Content authoring → Layout
Paragraphs → Restrictions**
(`/admin/config/content/layout-paragraphs/restrictions`), which appears as a
*Restrictions* tab under the Layout Paragraphs settings.
