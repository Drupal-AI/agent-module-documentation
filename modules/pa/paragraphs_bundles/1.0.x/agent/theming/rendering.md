# How bundles render (CSS-variable pattern)

Paragraphs Bundles is theme-agnostic and uses **no jQuery**. Each bundle ships a
`paragraph--<bundle>.html.twig` template that reads the instance's Display-tab fields and turns them into
inline CSS custom properties + utility classes on a `.paragraph__inner` wrapper. Understanding this
pattern lets you read/override any bundle template without re-reading each one.

## Shared preprocess & Twig extension

- `paragraphs_bundles_preprocess_paragraph()` normalizes `attributes['class']` (may be null/string/array)
  so templates can `addClass()` safely, and only acts on managed bundles
  (`paragraphs_bundles_paragraph_is_managed_bundle()`).
- `paragraphs_bundles_theme()` registers shared includes like `pb-content-title.html.twig`.
- Twig extension `ParagraphsBundlesTwigExtension` (service `paragraphs_bundles.twig_extension`) adds the
  filter **`decode_entities`** → `html_entity_decode($s, ENT_QUOTES|ENT_HTML5, 'UTF-8')`, used for titles
  and aria-labels.

## The style-variable block (present in most bundle templates)

Templates map Display fields to CSS custom properties:

```twig
{% set pb_styles = {
  'pb-bg':   'pb_display_bg',        'pb-bg-h': 'pb_display_bg_hover',
  'pb-br':   'pb_display_border_color', 'pb-br-h': 'pb_display_border_hover',
  'pb-tx':   'pb_display_text',      'pb-tx-h': 'pb_display_text_hover'
} %}
{% set pb_bg_opacity = content.pb_display_bg_opacity|render|striptags|trim %}
{% if pb_bg_opacity != 100 %}{% set pb_bg_opacity = '0.' ~ "%02d"|format(pb_bg_opacity) %}{% endif %}
{# each color → --<key>:rgba(<val>, <opacity>) for bg, or #hex / rgb(...) otherwise #}
```

and map layout Display fields to utility classes appended to `classes_inner`:

```twig
{% set pb_displays = ['pb_display_width','pb_display_border','pb_display_border_radius',
                      'pb_display_margin','pb_display_padding','pb_display_shadow'] %}
```

The wrapper then renders as:

```twig
<div {{ attributes.addClass(classes) }}>
  <div class="{{ classes_inner }}" style="{{ pb_style_attributes|join(' ') }}">…</div>
</div>
```

## Libraries

`paragraphs_bundles.libraries.yml` defines `paragraphs-bundles` (basic + custom CSS),
`paragraphs-bundles-admin`, `color-picker` (JS+CSS), and `opacity-range` (JS+CSS). Bundle templates
`attach_library('paragraphs_bundles/paragraphs-bundles')` plus their own submodule library.

## Overriding

Override any `paragraph--<bundle>.html.twig` in your theme to change markup; the CSS variables
(`--pb-bg`, `--pb-tx`, `--pb-br`, `--pb-bt-a`, …) are the styling contract — target them (or the
`.pb__*` classes) in theme CSS. Content-title markup lives in the shared `pb-content-title.html.twig`.
