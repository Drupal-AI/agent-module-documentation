# Configuration

There are two places you configure this module: a small **global settings page** that
defines the dropdown choices, and the **per-section fields** that appear inside Layout
Builder whenever you configure a section.

## The global settings page

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Layout Builder Sections Config**, or
   navigate directly to `/admin/config/content/layout-builder-sections-config`.

This page defines the option lists offered on every section's Configure-section form.
There are three of them, and each one is a plain text box where you type one option
per line in the form `key|Label`:

- **Title wrappers** — the HTML heading tags a title can use. The `key` is the tag
  and the `Label` is what editors see. The shipped default is `h1|H1` through `h6|H6`.
  Trim this if you only want to allow, say, `h2` and `h3`.
- **Title positions** — a CSS class controlling title alignment. The `key` becomes a
  class on the title. Defaults are `section-left-title|Left`,
  `section-center-title|Center`, and `section-right-title|Right`.
- **Title colors** — a CSS class controlling the title colour. Defaults are
  `section-black-title|Black`, `section-white-title|White`, and
  `section-blue-title|Blue`.

**Important formatting rule:** every non-empty line must contain a `|` with an
explicit key. If any line is missing its `|`, the whole list is treated as empty and
the dropdown will only show a "- None -" option. So always write `key|Label` on every
line. To add a colour, append a line such as `section-red-title|Red` — then add the
matching CSS for `section-red-title` in your theme, since the module only emits the
class, it does not define the colour.

Click **Save configuration** when done. These lists are stored in the
`layout_builder_sections_config.settings` config object and export with your
configuration.

## The per-section fields

These appear inside Layout Builder itself. When you add a new section or click
**Configure** on an existing one, the Configure-section dialog now includes:

- **Show section title to end users** — a checkbox. Leave it off and no title is
  rendered, regardless of the wrapper/position/colour choices. Turn it on to reveal
  the three title fields below.
- **Title wrapper** — which heading tag wraps the shown title (options from your
  Title wrappers list).
- **Title position** — the alignment class for the title (options from Title
  positions).
- **Title color** — the colour class for the title (options from Title colors).
- **ID** — a custom HTML `id` applied to the section wrapper, useful for anchor links
  and deep-linking.
- **Classes** — one CSS class per line; each is added to the section wrapper for
  bespoke styling.

The title that is shown is the section's **administrative label** (the same label you
see in the Layout Builder UI, such as "Hero" or "Sidebar"). Save the section and then
save the layout as usual. These values are stored inside the section's own layout
configuration, not in a separate global object — so they travel with the entity or
view display that owns the layout.

## Theme templates (important)

For the title, id, and classes to actually appear, the section's layout template must
print them. The module ships overrides of the core layout templates (a generic
`layout`, plus `layout--onecol`, `layout--twocol-section`, `layout--threecol-section`,
and `layout--fourcol-section`) together with CSS for the position/colour classes, and
it makes sure its templates take priority over core's.

The catch: if **your theme** (or another module) overrides the same layout templates,
your version wins and the module's title block is lost — the data is still saved, it
just does not render. To fix that, copy the module's title block into your theme's
matching template. It looks like this:

```twig
{% if content.title %}
  <div class="{{ content.title.attributes.class|join(' ') }}">
    {% if content.title.wrapper %}<{{ content.title.wrapper }}>{% endif %}
    {{- content.title.label -}}
    {% if content.title.wrapper %}</{{ content.title.wrapper }}>{% endif %}
  </div>
{% endif %}
```

The section's `attributes` already carry the id and merged classes, so keep printing
`attributes` as normal. The module's `layouts/*.css` files are a good reference for
styling the `section-left-title` / `section-black-title` style classes in your theme.

## One caveat

Uninstalling the module does **not** remove the section-config data already written
into your saved sections — that metadata stays in the stored layout configuration.
This is a known issue to be aware of if you ever remove the module.
