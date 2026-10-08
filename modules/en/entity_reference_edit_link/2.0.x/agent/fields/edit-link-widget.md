<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field widget: the reference edit link

This module does not register a new field widget plugin. It **overrides** the class of two core
entity-reference widgets and injects an edit link into their form element. In 2.x the hook that does
the swap is a method on the autowired `EntityReferenceEditLinkHooks` service (`#[Hook]` attribute),
not a bare function.

## Class swap

`EntityReferenceEditLinkHooks::fieldWidgetInfoAlter()` (via `#[Hook('field_widget_info_alter')]`,
plus a `#[LegacyHook]` shim `entity_reference_edit_link_field_widget_info_alter()` in `.module`):

```php
public function fieldWidgetInfoAlter(array &$info) {
  $info['entity_reference_autocomplete']['class'] = EntityReferenceEditLinkAutocompleteWidget::class;
  $info['entity_reference_autocomplete_tags']['class'] = EntityReferenceEditLinkAutocompleteTagsWidget::class;
}
```

So any field configured to use the core **"Autocomplete"** entity-reference widget silently gets the
subclass; the **"Autocomplete (Tags style)"** widget gets a subclass that removes the link.

## Single/multi autocomplete widget

`EntityReferenceEditLinkAutocompleteWidget::formElement()`
(`src/Plugin/Field/FieldWidget/EntityReferenceEditLinkAutocompleteWidget.php`):

1. Resolve the referenced entity for this `$delta` (`$items->referencedEntities()[$delta]`).
2. Bail to `parent::formElement()` if there is no entity, or it lacks an `edit-form` link template.
3. Load the current user (via `entity_type.manager` → `user` storage) and **check
   `$referencedEntity->access('update', $user)`** — bail if it fails. This is the access gate; a
   viewer without edit rights gets no link.
4. Attach the CSS library and add an `_link` element: `#type => link`,
   `#url => $referencedEntity->toUrl('edit-form')`, `#title => t('Edit')`,
   `class => button reference-edit-link`, `target => _blank`.

The `_link` is a sibling of the normal widget element (`parent::formElement(...) + ['_link' => $link]`).

For **multi-value** fields the widget is rendered through
`template_preprocess_field_multiple_value_form()`; this module's
`EntityReferenceEditLinkHooks::preprocessFieldMultipleValueForm()`
(`#[Hook('preprocess_field_multiple_value_form')]`) intercepts, adds an **"Edit Entity"** header, and
rebuilds each row so `_link` lands in its own `reference-link` cell. It reuses the tabledrag group
core already assigned (`$variables['table']['#tabledrag'][0]['group']`).

## Tags widget

`EntityReferenceEditLinkAutocompleteTagsWidget::formElement()` calls the parent then
`unset($element['_link'])`. The comma-separated tags widget has no per-item DOM to attach a link to,
so it is excluded by design.

## Select2 widget

Select2 uses a single combined element, so it is handled in
`EntityReferenceEditLinkHooks::fieldWidgetCompleteFormAlter()`
(`#[Hook('field_widget_complete_form_alter')]`) instead of a widget subclass. It only acts when
`$widget->getPluginId() == 'select2_entity_reference'`, and only after checking
`$entity->access('update', $this->currentUser)` on `$context['items']->entity` (the injected current
user, an improvement over the 1.x `User::load(currentUser()->id())`).
`_entity_reference_edit_link_prepare_link()` (still a function in `.module`) then builds either a
single `#type => link` (single-value) or a `#type => dropbutton` of per-entity edit links
(multi-value). Core's own entity edit-form routes enforce update access, so a link a viewer cannot
use resolves to a 403 when followed.

## The "Manage fields" title link (separate feature)

`EntityReferenceEditLinkHooks::formAlter()` (`#[Hook('form_alter')]`) and `::preprocessPageTitle()`
(`#[Hook('preprocess_page_title')]`) set the node edit page **title** to an
`Edit <type>` link built by `_entity_reference_edit_link_build_entity_type_link()`, which points to
the bundle's `entity.node.field_ui_fields` route (`target="_blank"`). Two gates, both required:
`_entity_reference_edit_link_allowed_content_type($node)` (the node's bundle is in
`entity_reference_edit_link.config:content_types`) **and** `_entity_reference_edit_link_check_permissions()`
(`administer node fields`). `::themeRegistryAlter()` (`#[Hook('theme_registry_alter')]`) re-orders the
`page_title` preprocess so this module runs after Gin's, so it works with the Gin admin theme.

## Cacheability

The links are rendered inside entity **edit forms**, which are built per request (POST, not page/render
cached in normal use), so the missing per-user cache metadata on the access-gated link has no practical
render-cache consequence here. Do not rely on this module's output being safe to render-cache in a
custom context without adding the appropriate `user`/`user.permissions` cache contexts yourself.

## Practical notes

- Nothing to enable per field: the link appears wherever an affected widget is used and access allows.
- Links open in a **new tab**.
- Editing the referenced entity affects **every** place it is referenced.
- 2.x is behaviour-compatible with 1.1.x; only the core requirement and hook wiring changed.
