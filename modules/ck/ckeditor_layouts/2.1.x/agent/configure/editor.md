# Configure — enable and tune the Layouts button

There is no dedicated settings page. Configuration happens on a **text editor** (CKEditor 5) and
its **text format**. `configure` points at the Text formats overview
(`/admin/config/content/formats`, route `filter.admin_overview`).

## 1. Add the toolbar button

Edit a format+editor at `/admin/config/content/formats/manage/<format>` (e.g. `full_html`). Drag
the **Insert layout** button (icon `icons/layouts.svg`, toolbar item `insertDrupalLayout`) from
"Available buttons" onto the Active toolbar. This enables the plugin
`ckeditor_layouts_drupal_layouts`.

## 2. Choose enabled layouts

Once the button is on the toolbar, a **Layouts** settings vertical-tab appears under the editor.
It lists every registered core Layout API layout as a checkbox (the internal `layout_builder_blank`
is hidden). Only checked layouts are offered in the editor. Config is stored on the
`editor.editor.<format>` entity under
`settings.plugins.ckeditor_layouts_drupal_layouts.enabled_layouts`.

Config schema (`ckeditor_layouts.schema.yml`), key
`ckeditor5.plugin.ckeditor_layouts_drupal_layouts`:

```yaml
enabled_layouts:            # sequence of layout ids
  - twocol_section
  - threecol_section
```

Constraints: the sequence must not be blank (`NotBlank` — "Enable at least one layout, otherwise
disable the Layouts plugin"), and each id must be a real installed layout
(`Choice` callback `Layouts::validChoices()`).

## 3. Let the layout markup through the filter

The plugin declares the elements `<div>` and `<div class>`, and at runtime derives the full
allowed tag/attribute set from each enabled layout's rendered template, feeding it into CKEditor 5
**General HTML Support** (`getDynamicPluginConfig()` sets `htmlSupport.allow` and `allowEmpty`).
For the saved markup to survive server-side filtering:

- If the format uses **Limit allowed HTML tags and correct faulty HTML** (`filter_html`), add
  `<div class>` (and any element/class your custom layouts emit) to the allowed tags.
- If the format is Full HTML (no `filter_html`), nothing extra is needed.

## 4. Editor vs front-end CSS

- Inside the editor, layout + region CSS is aggregated automatically: `hook_library_info_build()`
  builds `ckeditor_layouts/ckeditor5.layouts` from `css/layouts.css` plus each enabled layout
  library's CSS; the admin/settings UI uses `ckeditor_layouts/admin.ckeditor5.layouts`
  (`css/layouts.admin.css`).
- On the **rendered page**, only your front-end theme's CSS applies. You must style the layout's
  classes there yourself — the module does not inject front-end layout CSS.

## Using custom layouts

Any layout registered through the core Layout API is picked up automatically — define one in a
module/theme `*.layouts.yml` (a `layout` plugin with `template`/`theme` and `regions`), clear
caches, and it appears in the Enabled layouts checklist. In the editor the module renders the
layout's theme hook with an empty `#markup` placeholder in every region so editors can type into
any region; HTML comments (e.g. Twig debug) are stripped from the rendered template and icon.
