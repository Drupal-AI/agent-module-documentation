<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extending Edit+ — events, element, JS field plugins

## Events (`src/Event/*`) + subscribers (`src/EventSubscriber/*`)

Edit+ dispatches events (via `@event_dispatcher`) while attributing form items and building the
inline UI. Subscribe to alter how fields are made inline-editable.

- **`FieldAttributes`** (`src/Event/FieldAttributes.php`) — constants `ALTER =
  'field_attributes.alter'` and `AFTER_BUILD = 'field_attributes.after_build'`. Carries `form`,
  `view_mode`, `field_name`, `entity`, `form_state`; `getForm()/setForm()` let a subscriber mutate the
  form for a specific field. Dispatched from `EditPlusFormTrait::attributeFormItemsEventDispatcher()`.
  Built-in subscribers: `FormDefaultFieldAttributes`, `FormHandleFieldAttribute` (resolves the
  `form_item`/`wrapper` handle + `getDefault()`), `FormInlineEditorFieldAttributes`,
  `FormMediaFieldAttributes`, and `RenderEditableFieldAttributes` (attributes the *rendered* field,
  reacting to Navigation+'s `EditableFieldAttributes`).
- **`AddEmptyField`** (`src/Event/AddEmptyField.php`) — dispatched by
  `EditPlusFormTrait::populateEmptyField()` after a sample value is generated for a field being added
  to the page; wraps the `FieldItemListInterface`.
- **`NoChangeTool`** (`src/Event/NoChangeTool.php`) — wraps a Navigation+ `EditableFieldAttributes`;
  a subscriber calls `setNoChangeTool()` to suppress the Change tool for that field.
  Subscriber: `EventSubscriber\NoChangeTool`.
- **`BlockPropertiesEvent`**, **`FieldProperties`** — property-mapping events used by the block
  submodules (e.g. `edit_plus_cta_block`'s `CtaBlockProperties`, `edit_plus_header_block`'s
  `Heading`, `edit_plus_teaser_block`'s `Teaser` subscribers) to expose block/field properties as
  editable page elements.

Subscribers are auto-registered (`autoconfigure: true` in `edit_plus.services.yml`);
`AttributesTrait` holds shared attribution logic. `NavigationPlusReplaceMediaClearForm` handles
clearing the media form on replace.

## The `inline_textarea` element (`src/InlineEditorElement.php`)

Registered as service `element.edit_plus` and added as a `#pre_render` on the `inline_textarea`
element type via `edit_plus_element_info_alter()`. `preRenderTextFormat()`
(a `TrustedCallbackInterface` callback) adapts a `text_format` element for inline CKEditor:
it wires the format/editor selector (`data-inline-editor-for`), hides filter guidelines for formats
that have an editor, and — importantly — runs `editor_filter_xss($value, $format)` on the existing
value and stores the original as `data-editor-value-original` for change tracking. Respects a
`#editor => FALSE` opt-out. The `inline_textarea` theme hook +
`template_preprocess_inline_textarea()` (`edit_plus.module`) render the hidden textarea plus the
`edit-plus-inline-edit` wrapper (`templates/inline-textarea.html.twig`).

## JS field-plugin system (`js/edit_plus/plugins/*`)

Client-side extension point for custom inline widgets. `field-plugin-manager.js` selects a plugin per
field; `plugins/field-plugin-base.js` is the base class. Bundled plugins:
`plugins/default.js` (falls back to the standard form item), `plugins/textfield.js`,
`plugins/inline-editor.js` (CKEditor 5), `plugins/media.js`,
`plugins/entity-reference-autocomplete.js`. Supporting modules: `editable-element.js`,
`entity-form.js` (form AJAX round-trips incl. `ajaxReturnForm`/`updateTempstore`),
`edit-plus-hotkeys.js`, `effects.js`, `formatter-property-map.js`, and `indicators/change-indicator.js`.
To add a custom inline widget, extend the base plugin and register it with the field-plugin manager;
otherwise the `default` plugin renders the normal form widget inline.

## Server-side value handling

`InlineEntityFormAlter::getValue()` special-cases entity-reference widgets
(`entity_reference_autocomplete`, `options_buttons`, `options_select`) when mapping submitted values
back into the tempstore entity; other field types use `$field->getValue()` directly.
`updateFormState()` writes the value into user input + form state, re-sets the entity on the form
object, stores it in the tempstore, and clears stale `field_storage` (so e.g. the Media Library does
not keep stale state across edits).
