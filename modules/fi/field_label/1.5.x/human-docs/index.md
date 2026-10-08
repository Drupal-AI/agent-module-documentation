# Field Label — manual setup guide

**Field Label** (`field_label`) gives you per‑display control over how a field's
*label* looks and reads, without renaming the field itself. On any **Manage
display** form (and in Layout Builder), every field formatter gains a "Label
settings" group where an authorized user can override the label text, provide a
separate plural label for multi‑value fields, wrap the label in a chosen HTML tag,
and add CSS classes to it. So you can rename "Body" to "Article text" only in the
teaser view mode, show "Author" / "Authors" depending on how many values appear,
or wrap a label in an `h3` for structure and SEO.

Each of these features is individually toggleable site‑wide and gated by its own
permission, so you decide which options editors even see. This makes the module
especially handy with **Layout Builder**: you can let editors style field labels
inside layouts without granting them the broad *Manage display* access.

The choices you make are stored as third‑party settings on the entity view
display configuration, so they export and deploy like any other config. The
module requires only core's Field module.

> **Theming note:** The wrapper‑tag feature works out of the box because the
> module overrides the *core* field template. If your theme ships its own
> `field*.html.twig`, it must reference `{{ label_tag|default('div') }}` for the
> chosen wrapper tag to take effect. The label text, plural label, and CSS
> classes apply regardless.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — where settings are stored,
the permissions, and the Twig variable — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Field Label has a small global settings form at **Configuration → Content
authoring → Field Label** (`/admin/config/content/field-label`), which decides
which of its features are available. The actual label customizations are made
per field on each **Structure → … → Manage display** form. Its five feature
permissions live on **People → Permissions** (`/admin/people/permissions`).

## How to use it

**1. Choose which features are available (optional).** Open **Configuration →
Content authoring → Field Label**. Here you turn individual features on or off
site‑wide: the **label value** override (on by default), the **plural label**
(off by default), the **label wrapper** tag select (on by default), the free‑form
**extra label classes** field (on by default), and the **label class** select
list (off by default). You can also set the **allowed tags** offered in the
wrapper select (default `div`, `span`, `h2`–`h6`) and, if you enable the class
select, a **class list** — one `.selector|Label` line per row — that gives
editors a curated dropdown of approved label styles instead of free‑form CSS.

**2. Grant permissions.** On **People → Permissions**, grant the feature
permissions your roles need: *edit field label value*, *edit field plural label*,
*edit field label class*, *edit field label class select*, and *edit field label
tag*. A feature only appears on a formatter form when its global toggle is on
**and** the user holds the matching permission (the global settings form itself
is gated by core's *Administer site configuration*).

**3. Customize a label.** Go to a **Manage display** form, click a field's
formatter settings cog, and open **Label settings**. Fill in the enabled options
— for example set the label value to "Article text", pick an `h3` wrapper, or add
a `visually-hidden` class — and save the display. The label renders with your
changes on that view mode.
