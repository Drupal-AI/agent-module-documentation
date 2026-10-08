<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field widgets

Two `@FieldWidget` plugins swap in for the core widget of the same field types. Both use
`ChoicesWidgetTrait` (shared settings form/summary and `formElement()`) and render through the
`choices_autocomplete` render element (see [../api/element.md](../api/element.md)).

| Widget id | Class | Field types | Extends (core) |
|---|---|---|---|
| `entity_reference_choices` | `EntityReferenceChoicesWidget` | `entity_reference` | `EntityReferenceAutocompleteWidget` |
| `options_select_choices` | `SelectChoicesWidget` | `list_integer`, `list_float`, `list_string` | `OptionsSelectWidget` |

Both are declared `multiple_values = TRUE`. Cardinality drives the UI: single-value fields render a
placeholder ("- Select -" / "- None -" or your "No selection text"); multi-value fields render a
search field and enforce `maxItemCount` from the field's cardinality.

## Apply it

1. Go to the entity type's **Manage form display** tab (`admin/.../form-display`).
2. Set the field's widget to **Choices.js autocomplete**.
3. Click the gear to edit settings, then save.

The choice is stored in the entity form display config, e.g.
`core.entity_form_display.<entity_type>.<bundle>.<form_mode>` at
`content.<field>.type` = `entity_reference_choices` (or `options_select_choices`) and
`content.<field>.settings.options` = the settings below.

### Set via PHP / drush

```php
\Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article', 'default')
  ->setComponent('field_tags', [
    'type' => 'entity_reference_choices',
    'settings' => [
      'match_operator' => 'CONTAINS',
      'match_limit' => 10,
      'options' => [
        'instance' => ['minlength' => 2, 'maxlength' => 64],
        'plugin'   => ['position' => 'auto', 'searchResultLimit' => 10],
      ],
    ],
  ])
  ->save();
```

## Settings

Defaults come from `ChoicesAutocompleteDefaults::getOptions()`; `getSetting()` deep-merges saved
values over them. Settings live under `settings.options`.

### `options.plugin.*` (both widgets)

| Key | UI label | Default | Notes |
|---|---|---|---|
| `searchPlaceholderValue` | Start typing text | `Start typing to find results` | Search-input placeholder (multi-value / multiple only). |
| `loadingText` | Searching text | `Loading...` | Shown while results load. |
| `noResultsText` | No results text | `No results found` | |
| `itemSelectText` | Press to select text | `Press to select` | |
| `maxItemText` | Max items text | `Max number of items selected` | Shown at cardinality limit. |
| `position` | Dropdown position | `auto` | `auto` \| `top` \| `bottom`. |
| `searchResultLimit` | Number of results | `10` | Suggestion count; `0` = unlimited (stored/sent as `10000`). Select widget exposes it directly; entity-ref widget derives it from core's `match_limit`. |

### `options.instance.*` (both widgets)

| Key | UI label | Default | Notes |
|---|---|---|---|
| `remove_item_text` | Remove item text | `Remove item` | Chip remove-button label / aria-label. |
| `none_text` | No selection text | `''` | Single-value only; disabled on multi-value (use `searchPlaceholderValue`). |

### `options.instance.*` — entity reference widget only

| Key | UI label | Default | Notes |
|---|---|---|---|
| `input_type` | Limit characters | `''` | `''` \| `alpha` \| `alphanumeric` \| `numeric`. Only shown when the reference field's selection handler has `auto_create`. |
| `allowed_characters` | Allowed characters | `''` | Extra characters permitted on top of `input_type`. |
| `minlength` | Minimum length | `0` | Min chars before searching / min autocreate label length. |
| `maxlength` | Maximum length | `64` | Max autocreate label length. |
| `auto_create` | (derived) | `FALSE` | Set automatically from the field's selection-handler `auto_create`; enables typing new tag-style entities. |

The entity-reference widget also keeps its parent's `match_operator` and `match_limit` settings; the
select widget also keeps the core select settings. On both, the parent's `placeholder` and `size`
settings are force-hidden (`#access = FALSE`).

## Runtime behavior (entity reference)

- `formElement()` sets `#type => choices_autocomplete` and chains the process callbacks
  `EntityAutocomplete::processEntityAutocomplete`, `FormElement::processAutocomplete`,
  `self::processEntityAutocomplete`, `ChoicesAutocomplete::processChoicesAutocomplete`. The
  autocomplete search therefore uses **core's `system.entity_autocomplete`** route — access to
  referenceable entities is enforced by the field's selection handler (standard or Views), not by
  this module (it defines no route or controller).
- `processEntityAutocomplete()` formats labels for already-selected values and passes them in
  `drupalSettings.choices_autocomplete.<id>.values` (option elements can't hold HTML; Choices.js
  substitutes the formatted label on init). Standard handlers use
  `SelectionInterface::getReferenceableEntities()` (core-escaped labels); Views handlers execute the
  reference view for the single id and render the row (this is the "rich HTML label" feature).
- `validateEntityAutocomplete()` re-extracts each value, and for autocreated entities enforces
  `input_type`/`allowed_characters` (via `validateAutoCreate()`), `minlength`, and `maxlength`,
  setting form errors; it writes `target_id` for existing entities and `entity` for new ones.

## Config schema

`config/schema/choices_autocomplete.schema.yml` defines the reusable `choices_autocomplete` mapping
(`options.instance.*`, `options.plugin.*`). `choices_autocomplete.module`'s
`hook_config_schema_info_alter()` copies it onto `field.widget.settings.options_select_choices` and
`field.widget.settings.entity_reference_choices`, merges core's own widget-settings mapping back in,
and strips `placeholder`/`size` from the entity-reference schema. The entity-reference schema adds
`input_type`, `allowed_characters`, `minlength`, `maxlength`.
