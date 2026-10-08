# Twig Field — manual setup guide

**Twig Field** (`twig_field`) adds a new field type whose stored value is a Twig
template. The template is written and edited right in the browser with a
CodeMirror code editor, and it is compiled and rendered at display time. In
other words, you can attach a small, per‑entity template to a content type and
have it produce custom markup from the entity's other fields — without writing a
preprocess function or shipping a template file in your theme.

The module gives you one field type (**Twig template**), its own widget
(**Template editor**, the CodeMirror editor with a *Variables* insert helper),
and a formatter (**Rendered Twig template**) that runs the stored string as Twig.
Inside a template you can reach a set of global variables (`theme`, `base_path`,
`language`, `is_front`, `logged_in`, `is_admin`, and more), the host entity
itself (keyed by its entity type, e.g. `node`), and — when you point the field's
*display mode* setting at an entity view display — every field rendered by that
display, exposed as its own variable.

Because a Twig template is effectively executable code, editing a Twig field is
gated behind the restricted **Create and edit templates stored in Twig fields**
(`access twig fields`) permission. Grant it only to fully trusted administrators
— a user who can set a template value can run arbitrary Twig (a server‑side
template injection / RCE risk). Viewing the rendered output is not restricted.

There is no global settings page; the field type, widget, and formatter are all
configured per field and per display. This module requires the
**CodeMirror Editor** (`codemirror_editor`) module, which powers the in‑browser
editor.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its CodeMirror
   dependency) with Composer and enable it.

## Where it lives in the admin menu

Twig Field adds no menu item and no global settings page. You work with it in two
places on the content type (or other entity bundle):

- **Structure → Content types → *(your type)* → Manage fields** — add a field of
  type **Twig template**.
- **Manage form display** — configure the **Template editor** widget.
- **Manage display** — configure the **Rendered Twig template** formatter.

Grant the `access twig fields` permission at **People → Permissions**
(`/admin/people/permissions`).

## How to use it

1. **Grant the permission first.** At **People → Permissions**, give
   **Create and edit templates stored in Twig fields** only to trusted admin
   roles. Without it, no one can enter or change a template value.
2. **Add the field.** On **Manage fields** for your content type, add a new
   field of type **Twig template**. You can set a default template as the field's
   default value, and make it multi‑value if you want several templates on one
   entity.
3. **Point it at a display (optional).** In the field settings, the **display
   mode** setting takes an entity view display (like *Content: Article: Teaser*).
   When set, that display is rendered and each of its fields becomes a Twig
   variable you can reference in your template. Leave it as *None* to only use
   the global variables and the host entity.
4. **Configure the editor.** On **Manage form display**, the **Template editor**
   widget lets you set the number of rows and a placeholder, and toggle CodeMirror
   options (toolbar, line wrapping, line numbers, fold gutter, auto‑close tags).
   The editor's *Variables* dropdown lists every available context key and inserts
   it for you.
5. **Set the formatter.** On **Manage display**, choose **Rendered Twig template**
   so the stored template is compiled and rendered on the page.
6. **Author the template.** Edit an entity, write your Twig in the editor, and
   save. The widget compiles the template on save and blocks the save with a
   *Template error* message if the Twig syntax is invalid.

Typical uses include composing several fields into custom markup, building a small
presentational snippet (a badge, callout, or ratio bar) from field values, or
producing context‑aware output that changes with the current theme, language, or
login state.

### Extending it (for developers)

Two alter hooks let other modules add options and context:
`hook_twig_field_widget_variable_alter()` adds entries to the widget's variable
picker, and `hook_twig_field_formatter_variable_alter()` injects extra variables
into the formatter's render context.
