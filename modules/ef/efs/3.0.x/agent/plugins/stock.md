<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
# efs stock plugins

Six `@ExtraFieldFormatter` plugins ship in `src/Plugin/efs/Formatter/`. Each extends
`ExtraFieldFormatterPluginBase`. `supported_contexts` controls where each may be added.

## `entity_label` — Entity label

`EntityLabel.php`. Contexts: `display`. Renders `$entity->label()` as `#markup`, HTML-escaped with
`Html::escape()`. Settings: `wrapper` (HTML tag, default `h2`) and `class` (CSS class); when set, the
label is wrapped as `<wrapper class="...">label</wrapper>` (wrapper and class also escaped). Returns
`[]` when the label is empty.

## `field_mirror` — Field mirror

`FieldMirror.php`. Contexts: `display`. Injects `plugin.manager.field.formatter` + `language_manager`.
Lets you re-render one of the display's existing fields (`getFieldDefinitionsAsOptions`) with a chosen
core field formatter and formatter settings. `view()` loads the field's items from the host entity
(`$entity->get($settings['field'])`), instantiates the selected core formatter with the stored
`formatter_settings`, runs `prepareView()` + `view()`, and returns the element. Settings:
`field`, `formatter`, `formatter_settings` (label + settings), plus `required_fields` in form context.
The settings form uses AJAX to populate the formatter list and its settings from the selected field.

## `entityreference_field` — Entity reference field

`EntityReferenceField.php`. Contexts: `display`. Injects the field formatter manager, language
manager, entity type manager, module handler and entity field manager. For an entity-reference /
dynamic-entity-reference field on the display, it renders a **chosen field of the referenced
entities** with a chosen formatter: `view()` iterates the reference items, builds a throwaway
`EntityViewDisplay` for the referenced entity's bundle exposing only the selected field
(`getViewDisplay()`), and returns `$view_display->build($item->entity)` per item (skipping items whose
referenced field is empty). Settings: `field`, `referenced_entity_field`, `formatter`,
`formatter_settings` (label, settings, third_party_settings). AJAX chains field → referenced field →
formatter → settings.

## `view` — View

`View.php`. Contexts: `form`, `display`. Requires the `views` module; injects the `token` service.
Renders a chosen View display inline instead of a field value. Settings: `view`
(`view_id::display_id`), `arguments` (repeatable — tokens or `field_name::property`), `hide_empty`,
`check_access`. `view()`:
- returns early if no view is selected;
- if `check_access` is on, loads the view and returns nothing when `$view->access($display)` fails;
- if `hide_empty` is on, executes the view and returns nothing when it has no results;
- otherwise returns a `#type => 'view'` render element (`#name`, `#display_id`, `#arguments`, a
  CSS class from the field name). `getArguments()` resolves each argument from the entity's keys,
  a field value/property, or token replacement.

The `#type => 'view'` element is rendered through core's Views element, which performs the View's own
access check.

## `tokenizer_wysiwyg` — Tokenizer Wysiwyg

`TokenizerWysiwyg.php`. Contexts: `form`, `display`. Injects `token` + `language_manager`. Stores rich
text plus a text format (`content` = `{value, format}`; schema-typed `text_format`) authored by the
configuring administrator in a `text_format` element with token support (`token_element_validate`,
`token_tree_link`). `view()` returns a `#type => 'processed_text'` element whose `#text` is the stored
value after `token->replace()` (with `clear => TRUE`) and `#format` is the stored format — i.e. output
runs through the selected text format's filters. `getTokenType()` maps the entity type to its token
type.

## `entity_form_display` — Entity form display

`EntityFormDisplay.php`. Contexts: `display`. Injects `efs.entity.form_builder` (the module's
`EntityFormBuilder`, `src/EntityFormBuilder.php`). Embeds an entity **edit form** inside a view
display: `view()` calls `entityFormBuilder->getForm($entity, $form_display, $additions[, $form_class])`
so the current entity's form (of the configured form mode, optionally with a custom form class) is
rendered in place. Settings: `form_display` (form mode, default `default`) and `form_display_class`
(optional override form class, e.g. `\Drupal\Core\Entity\ContentEntityForm`).

`EntityFormBuilder` (`efs.entity.form_builder`) wraps core's entity form builder to allow overriding
the form-object class via the class resolver (`getFormObject()`), then builds the form with the extra
`form_state` additions (`efs` key: entity type/id + embed view mode).
