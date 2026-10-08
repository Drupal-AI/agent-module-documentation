# Configuration

There's no global settings form here — "configuring" the module means **creating help
items** and, if you want visitors to see them too, **enabling the help on a Paragraph
type's display**. This page covers both, plus the permissions.

## Create a help item

1. Log in as a user with the **Manage paragraphs_type_help entity** permission.
2. Go to **Content → Paragraphs Type Help** (`/admin/content/paragraphs-type-help`) and
   click **Add Help**.
3. Fill in the fields:

| Field | What to enter |
|---|---|
| **Paragraph Type** | *(required)* The Paragraph type this help is for — where it will show. |
| **Admin label** | An optional name for the item. Leave it blank and it defaults to the Paragraph type's label. |
| **Active Paragraph Form mode** | The Paragraph *form* mode this help applies to. Defaults to **default**, which covers any form mode that doesn't have its own dedicated help. Set a specific mode to give, say, a simplified editing form different guidance from the full one. |
| **Active Paragraph View mode** | The Paragraph *view* mode this help applies to, if you want to show help to visitors on a rendered view. |
| **Weight** | Ordering when a Paragraph type has more than one help item (lighter sorts higher). |
| **Published** | Only published items render. Uncheck to hide an item without deleting it. |
| **Help text** | The rich-text guidance (links, lists, emphasis via a text format). |
| **Help image** | An optional image — for example an annotated screenshot showing how the fields map to the output. |

Save. Because help items are **translatable and revisionable**, you can translate the
text and image per language and keep a revision history.

## Where help appears automatically

As soon as a published help item exists for a Paragraph type, the module shows it on
that Paragraph's **edit form** — the "default" form-mode help is switched on out of the
box, so editors see it with no further setup. Multiple items for one type render in
weight order, and nothing shows for a type that has no published help.

## Show help to visitors (opt-in)

Showing help on the *rendered* page (not just the edit form) is deliberately opt-in:

1. Go to the Paragraph type's **Manage display**
   (**Structure → Paragraphs types → (your type) → Manage display**).
2. Find the **Paragraphs Type Help: Rendered as …** extra field — it's hidden by
   default on view displays.
3. Drag it out of the *Disabled* region into the layout where you want it, and save.

Now visitors viewing that Paragraph in that view mode see the help too. (The extra
field only renders when matching published help exists, so enabling it is safe even on
Paragraph types that don't have help yet.)

## Configure the help entity's own display

To change how the help entity's own fields (text, image) render, use its Field UI at
**Structure → Paragraphs Type Help** (`/admin/structure/paragraphs-type-help`), for
example to pick a different image style.

## Permissions

At **People → Permissions** (both are restricted, trusted-user permissions):

- **Administer paragraphs_type_help entity** — administer the entity type and its
  fields (the Field UI and settings routes).
- **Manage paragraphs_type_help entity** — create, edit, and delete help items and see
  the admin list. Grant this to whoever authors editorial guidance.

## Tidy the edit form with Field Group (optional)

If you install the suggested **Field Group** module, you can wrap the help extra field
in a collapsible "Need Help?" fieldset on the Paragraph's form display, so the guidance
is available but tucked away until an editor wants it.

## Theming

The help renders through `paragraphs-type-help.html.twig`, with theme suggestions per
view mode, per bundle, and per item, so you can override the markup for a specific
Paragraph type or help item in your theme. See the sibling
[`agent/`](../agent/start.md) docs for the full list of suggestions and preprocess
variables.
