# Configuration

The whole module is driven by one small settings form with three fields. Nothing
happens until you turn the master switch on and rebuild caches.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Content authoring → Layout Paragraphs → Default Theme**,
   or navigate directly to
   `/admin/config/content/layout_paragraphs/default-theme`.

## The fields

### Display default theme in admin

A checkbox — this is the master switch. When it is **off**, the module does nothing.
When it is **on**, the builder starts rendering paragraphs with your default
theme's `paragraph.html.twig` and `paragraph--[type].html.twig` templates (plus any
additional templates you list below), even while an admin theme is active.

### Default theme library

The machine name of a library defined in your default theme's `*.libraries.yml`,
for example `mytheme/layout-paragraphs-editor`. When set, that library's CSS/JS is
attached to the Layout Paragraphs builder UI, so your front‑end styling appears in
the editor. Leave it empty if you only want the templates and not extra styling.

> **Tip — scope your editor CSS.** The builder markup is wrapped in a `.lp-builder`
> class. Scope your editor stylesheet to that wrapper (for example
> `.lp-builder:not(.is-navigating) { … }`) so your theme's styles only affect the
> builder and don't leak into — or collide with — the admin theme. You define the
> stylesheet as a library in your theme's `*.libraries.yml`, then enter that
> library's machine name here.

### Additional templates to load

A list of extra template machine names, **one per line** (for example
`node__teaser` or a custom block template). The builder will pull these from your
default theme's registry in addition to the paragraph templates, which is useful
when your components reference other rendered entities.

## Save, then rebuild caches

Click **Save configuration**. Then **rebuild caches** — run `drush cr` (or
`ddev drush cr` from your host) — because theme‑registry changes only take effect
after a cache clear. Reopen a page in the Layout Paragraphs builder and the
paragraphs should now render with your front‑end templates and styling.
