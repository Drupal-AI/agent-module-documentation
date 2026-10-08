# Configuration

Skillset Inview is admin-driven: you author the skills, choose their colours, and
decide where they appear. Everything below is gated by the **Administer skillset
inview** permission (`administer skillset inview`), which you grant at **People →
Permissions**.

## Add and reorder skills

Go to **`/admin/content/skillset-inview`** — the overview page. Here you can:

- **Add** a skill, giving it a name and a proficiency percentage.
- **Reorder** skills by weight using the drag table, so they appear in the order
  you want.
- **Review** and **delete** skills through the accompanying tabs.

There is a contextual link back to the edit page from the rendered block, so you
can jump straight to editing once it is placed.

## Choose colours

Open the **Skillbar colour** form to customise the bar colours through the UI so
they match your theme. This is where the farbtastic colour picker (placed during
installation) comes in. Save the form to apply your chosen colours to the bars.

## Add the field to content

If you want skills to live on a content type or user profile rather than (or as
well as) a standalone block, add the **Skillset** field through the normal Field
UI:

1. Go to, for example, **Structure → Content types → *your type* → Manage
   fields** and choose **Add field**.
2. Pick the **Skillset** field type and configure how many skills it should hold.
3. On **Manage display**, choose the formatter: the standard bar formatter renders
   the skills inline, or the **meter** formatter gives a gauge-style display.

## Place the block

To show the skills as a block, go to **Structure → Block layout**
(`/admin/structure/block`), place the **Skillset Inview** block in the region you
want, and configure it. You can preview the block before publishing, and reuse it
across several pages.

## Theming notes

The module ships template files (`.tpl`) so you can adjust the HTML and CSS
classes to suit your theme's needs, and it comes with Bootstrap-grid-ready CSS
classes (you include the grid framework yourself if your theme uses it). If you
customise templates, be careful with the `unescape` filter the module provides:
it marks its output as safe HTML after decoding entities, so only ever feed it
trusted, admin-entered values — never untrusted user input.
