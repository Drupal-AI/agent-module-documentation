# Hooks implemented (integrator / themer facing)

All in `varbase_bootstrap_paragraphs.module`.

| Hook | What it does |
|---|---|
| `hook_theme()` | Registers `paragraph__default` + per-bundle paragraph templates and field templates (see [../theme/styling.md](../theme/styling.md)). |
| `hook_preprocess_paragraph()` | Builds the `VBP` template variable: background-image URL, `bp_width` → Bootstrap classes, `bp_classes`/`bp_gutter`/`bp_title_status`. Full detail in [../theme/styling.md](../theme/styling.md). |
| `hook_field_widget_WIDGET_TYPE_form_alter()` ×5 | For the Paragraphs edit widgets — attaches `vbp-default-admin` and rebuilds the `bp_background` widget `#options` from the `background_colors` config. |
| `hook_form_alter()` | Same `bp_background` option rebuild on standalone paragraph entity edit forms (`paragraph_*_entity_edit_form`); also attaches `vbp-default-admin` when a `field_lp_paragraphs` field is present. |

## The `bp_background` option injection

The widget/form alters read `varbase_bootstrap_paragraphs.settings:background_colors` live and set
the select/radios `#options` to `['_none' => 'N/A'] + (key => label per line)`. So the choices an
editor sees always reflect the current settings, independent of the field-storage `allowed_values`.

The five widget alters cover every Paragraphs widget variant, each delegating to the classic one:

- `..._entity_reference_paragraphs_form_alter` (Paragraphs Classic) — the real implementation.
- `..._paragraphs_form_alter` (Paragraphs EXPERIMENTAL / stable widget)
- `..._paragraphs_classic_asymmetric_form_alter`
- `..._entity_reference_paragraphs_previewer_form_alter`
- `..._paragraphs_previewer_form_alter`

## Extending

The module exposes no services, plugin manager, events, or public API — integration points are the
overridable Twig templates and the `vbp-colors` library. To change the background palette use the
settings form / config, not code (see [../configure/settings.md](../configure/settings.md)).
