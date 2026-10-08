# Entity Class Formatter — manual setup guide

**Entity Class Formatter** (`entity_class_formatter`) provides a field formatter called
**Entity Class** that prints nothing itself — instead it copies the field's value onto the
rendered entity's wrapper element as a **CSS class** (or any HTML attribute you name). It is
the clean, no-code way to let a field value drive styling: pick a "Theme colour" in a list
field and have that value become a class on the article, or turn a Category reference into a
class on every node that references it, so your theme (or its JavaScript) can key off it.

It replaces the little `hook_preprocess_node()` snippets people so often write purely to
push a field value into `attributes.class`. Four optional settings shape the output: a
**prefix** and **suffix** wrapped around each value, an **attribute name** so you can emit
something like `data-variant` instead of a class, and — for entity-reference fields — a
**field** setting to read a named sub-field off the referenced entity instead of its label.
Values are sanitised automatically (into valid CSS identifiers for classes, HTML-escaped for
other attributes), boolean fields contribute their on/off labels, and reference fields
contribute the referenced entity's label.

There is **no settings page, no permission and no configuration object** — everything lives
in the view-display settings for the field you apply it to, and it works with Layout Builder
too. The module only depends on core's **Field** module and supports Drupal
`^9.5 || ^10 || ^11 || ^12`.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

You use Entity Class Formatter by choosing it as the display format for a field on a
**Manage display** page — there is nothing else to configure.

1. Go to the bundle's *Manage display*, e.g. **Structure → Content types → Article →
   Manage display** (`/admin/structure/types/manage/article/display`).
2. Find the field whose value should become a class (for example a "Theme colour" list
   field), and in its **Format** column choose **Entity Class**.
3. Click the field's cog to open its settings and fill in any of:
   - **Prefix** — text placed before each value, e.g. `bg-` to produce `bg-blue`.
   - **Suffix** — text placed after each value, e.g. `--dark`.
   - **Attribute name** — leave empty to write a CSS **class**; set it to emit a different
     attribute such as `data-variant`. This field is **required** for numeric field types
     (decimal, float, integer), because bare numbers make poor class names.
   - **Referenced entity field name** *(entity-reference fields only)* — read a named field
     off the referenced entity (e.g. a machine-name field on the term) instead of using its
     label.
4. Click **Update**, then **Save**.

The field now disappears from the visible output, and its value shows up on the entity's
wrapper element instead. Supported field types are boolean, decimal, entity reference,
float, integer, list (text) and string. When the attribute is `class`, a space-separated
string value is split into several classes at once.

**One thing to know:** the class lands on the entity wrapper, so your theme template must
actually print `attributes` (core's node, taxonomy-term, media and paragraph templates all
do). Also, applying this formatter *hides* the field — there is no way to both print the
value and use it as a class with a single component. In Layout Builder you can add the same
field twice as two blocks to do both.
