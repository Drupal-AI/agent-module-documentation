<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field type, widget, formatter, field access

The module ships its own field plugin trio (all under `src/Plugin/Field/`). Attach the field to any
fieldable bundle at its "Manage fields" screen ("Template Whisperer" in the field-type selector).

## Field type — `template_whisperer` (`FieldType/TemplateWhispererFieldItem.php`)
- Stores a single column `target_id` (varchar 128) = the chosen suggestion entity id (its machine name).
- `default_widget = template_whisperer`, `default_formatter = template_whisperer`.
- `referencedEntities()` loads the `template_whisperer_suggestion` config entity for the stored id.
- **Field settings form** (`fieldSettingsForm`): a checkbox list of suggestions under
  `handler.suggestions` restricting which suggestions this field instance may offer. Empty = allow all.
- **Cardinality is hidden and forced to single**: `inc/rm_cardinality.inc` alters
  `field_storage_config_edit_form` to `#access = FALSE` the cardinality container for TW fields.
- **Usage bookkeeping**: `postSave()` and `delete()` call the
  `template_whisperer.suggestion.usage` service to add/decrement rows in
  `template_whisperer_suggestion_usage` — including diffing the original vs new value on update,
  and decrementing per-translation on delete (all usages removed when the default translation is
  deleted). See [config/suggestion-entity.md](../config/suggestion-entity.md).

## Widget — `template_whisperer` (`FieldWidget/TemplateWhispererWidget.php`, label "Advanced Template Whisperer")
- A single `select` ("Select a template") whose `#options` come from
  `TemplateWhispererManager::getList()`, filtered by the field's `handler.suggestions` restriction.
- Wrapped in a `details` element; moved into the form's `advanced` (vertical tabs) group when present,
  except inside inline entity forms.

## Formatter — `template_whisperer` (`FieldFormatter/TemplateWhispererFormatter.php`)
- `viewElements()` returns `[]` — the field renders **nothing** on the page. Its only job is to hold
  the choice that drives theme suggestions; it is intentionally not display output.

## Field access — `inc/access.inc` (`hook_entity_field_access`)
For fields of type `template_whisperer` only:
- Allowed for `bypass node access`, `administer content types`, or `administer the template whisperer field`.
- **Forbidden otherwise for every operation** (including view) — so the raw field is not editable or
  exposed to unprivileged users. (Theme-suggestion reading uses the field value directly via the
  manager, not the access-checked render path, so alternate templates still apply for everyone.)

## Manager — `src/TemplateWhispererManager.php` (service `plugin.manager.template_whisperer`)
- `getList()` → id ⇒ name map of all suggestions.
- `getOneBySuggestion($machine_name)` → the suggestion entity (used by tokens, condition, widget).
- `suggestionsFromEntity($entity)` → the suggestion machine-name string(s) held in the entity's TW
  field(s); this is what the `hook_theme_suggestions_alter()` helpers consume.
