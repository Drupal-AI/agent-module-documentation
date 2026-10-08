# ERL — setup & configuration

## Field setup (per the README)
1. Have some Paragraph types configured.
2. Create a Paragraph type to act as the **layout section** (e.g. "Section"); fields optional.
   (The `erl_paragraphs` submodule provides a ready-made one.)
3. On the target content type add a field of type **"Paragraph with Layout"**
   (`entity_reference_layout_revisioned`), referencing Paragraph, cardinality **Unlimited**.
4. On *Manage form display* the field uses the `entity_reference_layout_widget`; on *Manage
   display* the `entity_reference_layout` formatter renders sections recursively via each
   paragraph's view mode.

Note: `hook_form_field_ui_field_storage_add_form_alter` hides the raw "Reference revisions →
entity_reference_layout_revisioned" storage option (a known field-config-form bug); add the
field via the "Paragraph with Layout" type option instead.

## Global settings — `entity_reference_layout.settings`
Form route `entity_reference_layout.settings` →
`/admin/config/content/entity_reference_layout` (requires `administer site configuration`).
Two integer flags (schema `config/schema`, defaults in `config/install`):

| Key | Default | Effect |
|---|---|---|
| `show_paragraph_labels` | `0` | Show each paragraph type's label in the widget preview. |
| `show_layout_labels` | `0` | Show each section's layout label in the widget. |

## Per-section layout options (author UI)
The widget's section/"entity form" exposes (`EntityReferenceLayoutWidget`, ~line 814+):
- `options.container_classes` — free-text CSS classes added to the section wrapper.
- `options.bg_color` — a background color applied to the section wrapper.

At render time `entity_reference_layout_merge_attributes()` (in the `.module`) puts
`container_classes` into `#attributes['class']` and `bg_color` into
`#attributes['style'] = 'background-color: ' . $bg_color`, then dispatches
`ErlMergeAttributesEvent`. Values are rendered through Drupal's `Attribute` object (HTML-
escaped, so no attribute breakout), but they are otherwise free-form CSS supplied by whoever
can edit the content/section — if you want to constrain what authors can enter, use the
`erl_layouts` submodule's "select from a list" / "force" modes instead of free text.
