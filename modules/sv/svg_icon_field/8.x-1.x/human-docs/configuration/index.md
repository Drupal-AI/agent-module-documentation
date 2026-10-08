# Configuration

There is no site‑wide settings form for SVG Icon Field. You configure it **per
field** — you add an SVG Icon field to a bundle and, on the widget settings, pick
the default icon category and default icon. Everything below happens on the
bundle's field screens.

## Add the SVG Icon field

1. Log in as a user who can administer fields (an administrator by default).
2. Go to the bundle you want to add the icon to — for example
   **Structure → Content types → Article → Manage fields** — and click
   **Add field**.
3. From the field type list, choose **SVG Icon**. It is listed in the
   **Reference** section.
4. Give the field a label and click **Save and continue**.

## Choose the default icon category and icon

On the field's widget settings page you can:

- **Select icon category** — choose which of the built‑in icon sets editors pick
  from by default. The bundled library groups roughly 1,000 CC0 icons into themed
  categories such as *Branding and social*, *Business*, *Design*, *Ecology*,
  *Festivities*, *Food and kitchen*, *Health*, *Home*, *Internet*, *Sport*,
  *Travel and transport*, *Various*, and *Weather*.
- **Select a default icon** — the icon a new item starts with before an editor
  changes it.

Save the field settings. When editors create or edit content in that bundle they
will see the icon picker and can choose an icon; the chosen icon is stored on the
field and rendered inline as an SVG.

## Extending the icon sets (for developers)

If the bundled icons are not enough, a custom module can add or remove icon sets
by implementing `hook_svg_icon_field_categories_alter(&$categories)`. Each set
declares a label, an optional attribution string, a group, and the location of a
directory of SVG files inside your module, theme, profile, or theme engine. This
is a code‑level extension point rather than something you configure in the UI.

Because rendered inline SVG is active markup, only add icon sets from files you
trust — do not point the module at SVGs supplied by untrusted users.
