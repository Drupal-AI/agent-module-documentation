# Layout Builder Context — manual setup guide

**Layout Builder Context** (`layout_builder_context`) brings conditional
visibility to core's Layout Builder by borrowing the condition system of the
[Context](https://www.drupal.org/project/context) module. Out of the box, Layout
Builder gives you per‑entity layouts but almost no way to say "show this only
sometimes" — a section is either in the layout or it is not, and core's block
visibility conditions do not reach inside Layout Builder components. The usual
workarounds are duplicating a whole layout per audience or writing a custom block
plugin.

This module closes that gap. Once enabled, both **whole sections** and
**individual blocks** inside a layout gain a **Context visibility** option. You
build your Contexts at **Structure → Context** as you normally would, then simply
select the relevant Context here. If its conditions do not pass, the section or
component is not rendered — so you can, say, show a promo only to anonymous users,
vary a layout by language or path, or combine several conditions on one component.

Two things are worth stating up front. It drives **visibility only**: Contexts
that carry *Reactions* (swapping a theme, adding a block elsewhere) have no effect
through this module. And it is a deliberately thin layer that inherits Context's
evaluation semantics wholesale rather than reimplementing them — so if a site
already uses Context, its existing conditions become available inside Layout
Builder for free.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (along with the Context dependency).

This module has **no settings form of its own**. Visibility is chosen per section
or per block inside the Layout Builder UI, and the Contexts themselves are built
in the Context module, as described below.

## Where it lives in the admin menu

- The **Context visibility** option appears inside the Layout Builder interface,
  on a section's or a component's configuration form (for example **Structure →
  Content types → *(type)* → Manage display → Layout**).
- The Contexts you choose from are managed separately at **Structure → Context**
  (`/admin/structure/context`).

## How to use it

1. Build one or more Contexts at **Structure → Context**, giving each the
   conditions you need (role, language, path, and so on).
2. In a Layout Builder layout, configure a **section** or a single **block**. You
   will find a **Context visibility** option — select the Context(s) that should
   govern whether it renders.
3. Save. When the entity is displayed, the section or component only renders if its
   selected Context conditions pass. Test each condition before launch to confirm
   it evaluates as you expect.

> **Note on visibility vs. access:** this controls whether content *renders*, not
> who is permitted to see it. For genuinely sensitive content, back it with real
> access control rather than relying on a visibility condition alone.
