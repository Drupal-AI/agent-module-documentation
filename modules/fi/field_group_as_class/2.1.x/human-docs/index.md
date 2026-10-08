# Field Group as Class — manual setup guide

**Field Group as Class** (`field_group_as_class`) adds a new display format to the
**Field Group** module. Instead of drawing visible markup like a fieldset or tabs, an
"As Class" field group wraps its fields in a plain container and gives that container
a CSS class taken from the **value of one of the entity's own fields**. In other
words, an editor can drive a wrapper's CSS class straight from content — pick a
"variant" or "status" in a list field, and that value becomes a class your
stylesheet can react to, with no custom preprocess code.

A typical use is a "card" or "hero" that should look different depending on an
editorial choice: add a List (text) field with options like `dark`, `featured`, or
`compact`, group the fields you want to affect, format the group **As Class**, and
point it at that field. At render time the container picks up the field's value as a
class (alongside any static classes you also set), so the same markup can present
several design variations driven entirely by content.

It works for nodes, paragraphs, taxonomy terms, and custom blocks, and it requires
the contrib **Field Group** module. There is no settings page, no permissions, and no
Drush commands — everything is configured per field group on the entity's **Manage
display** tab.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with Field Group)
   and enable the module.

## Where it lives in the admin menu

There is **no global settings page**. The "As Class" format appears on any entity's
**Manage display** tab (*Structure → Content types → [type] → Manage display*, and
the equivalent for paragraphs, taxonomy, and block types) once you add a field group
there.

## How to use it

1. Make sure the bundle has a **Text (plain)** (`string`) or **List (text)**
   (`list_string`) field whose values are valid CSS class strings — for example a
   select with options `dark` and `featured`. (Base fields are not eligible.)
2. On the entity's **Manage display** tab, add a **Field group** (this needs the
   Field Group module) and set its **Format** to **As Class**.
3. Open the group's settings and set **Select the Field Class** to the field from
   step 1. This is required; if the select is empty, no eligible string/list field
   exists on the bundle yet.
4. Drag the fields you want wrapped inside the group.

When the entity is displayed, the group becomes a container whose classes are the
standard field‑group "Extra CSS classes" (static) **plus** the first value of the
field you selected. You can also add an optional `id` using the standard field‑group
settings.

**Tip:** because the class comes from editor‑entered content, prefer a constrained
**List (text)** field (with fixed option machine names) over a free‑text field, so the
classes your CSS relies on stay predictable.
