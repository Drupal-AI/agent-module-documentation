# Entity Reference Override — manual setup guide

**Entity Reference Override** (`entity_reference_override`) adds a new field type,
**"Entity reference w/custom text"**: a normal entity reference paired with an
extra, per-reference text box. It lets the *referencing* entity override how the
*referenced* entity is shown — a different title, an appended note, a CSS class,
or even a replacement for one of its text fields — without editing the referenced
entity itself.

The classic use is a curated list: you reference the same article from several
pages, but each placement can show its own headline. Because the override lives on
the reference (not on the target), the referenced entity stays canonical while
each context gets exactly the display text an editor chooses. You can append a
qualifier in parentheses, add a note after the link, attach a styling class, hide
the label entirely, or — with the rendered-entity formatter — splice your custom
text into a chosen field of the fully rendered entity.

It ships two widgets (an autocomplete and a select list, each with the inline
override box) and two formatters (a label formatter with several override
"actions", and a rendered-entity formatter). There's only **one** override text
box per field, so each instance can override one aspect at a time. The module also
integrates with Diff, Feeds and Entity Usage, and offers two optional submodules
for Entity Browser and Entity Reference Revisions. There is **no admin settings
page and no permission** — everything is configured per field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and the optional submodules.

## Where it lives in the admin menu

There's no dedicated page. You add and configure the field through **Field UI** on
any fieldable bundle — its **Manage fields**, **Manage form display**, and
**Manage display** tabs (for example under *Structure → Content types → [type] →
Manage fields*).

## How to use it

**Add the field.** On a bundle's **Manage fields**, add a field and choose
**"Entity reference w/custom text"** (listed under *Reference*). Set the usual
entity-reference options (which entity type and bundles it targets), plus two
extra settings:

- **Custom text label** — the label/placeholder shown above the override box
  (defaults to "Custom text").
- **Text format** — leave it as **"Single line, no markup"** to make the override
  a plain one-line field (this is the mode that can override a *title* or a *CSS
  class*). Choose any filter format instead and the override becomes a rich-text
  area for overriding an actual *text field*.

**Choose a widget (Manage form display).** Both the **autocomplete** (default) and
**select list** widgets show the override box right beside the reference input, so
editors fill in both at once.

**Choose a formatter (Manage display).** Two options:

- **Rendered as label** *(default)* — renders the referenced entity's label as a
  link and applies your override according to an **Override action** setting:
  - *Title* — replace the link text with the override;
  - *Title append* — append the override to the label in parentheses;
  - *Suffix* — add the override as a note after the link;
  - *Class* — add the override as a CSS class on the link;
  - *Hide* — render nothing extra.
- **Rendered entity** — renders the full referenced entity and can inject the
  override text into a chosen string, long-text or email field on it, effectively
  replacing one of its fields for this placement only.

Because there is a single override box per field, each field instance overrides
one thing at a time — pick the widget/formatter combination that matches what you
want to override.
