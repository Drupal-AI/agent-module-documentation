# Configuration

Layout Builder Section Variations has two parts: a configuration page where you
**define** the available variations, and the Layout Builder UI where editors
**choose** one per section. You need to define at least one variation before the
feature does anything useful.

## Define your section variations

1. Log in as a user with permission to administer the module's configuration.
2. Go to **Configuration → Content authoring → Section variations**, or navigate
   directly to `/admin/config/content/layout-builder-section-variations`.
3. Add one or more **Section variations**. Each variation is a preset that editors
   will be able to select on a section — for example "Default", "Highlighted", or
   "Full‑width".
4. Save the configuration.

## Use a variation on a section

Once variations are defined, they appear inside Layout Builder:

1. Edit a page's layout in **Layout Builder**.
2. Add a new section, or edit an existing one.
3. In the section form you'll see a new **Variation** field — a list of all the
   variations you defined. Pick the one you want and save the section.

## Template suggestions

Selecting a variation also makes it available as a **theme hook suggestion**, so
your theme can override the section markup per variation. For example, on a
"One column" layout the *Default* variation lets you override any of these
templates:

- `layout.html.twig`
- `layout--onecol.html.twig`
- `layout--default.html.twig`
- `layout--onecol--default.html.twig`

Add the corresponding template to your theme to customize how that specific
layout‑and‑variation combination renders.
