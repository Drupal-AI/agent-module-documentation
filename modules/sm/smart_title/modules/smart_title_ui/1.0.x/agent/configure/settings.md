# Configure Smart Title UI

The submodule is one settings form. It adds no title format options of its own — the tag,
classes and link settings live per view display and are documented in the parent module
([../../../../../1.0.x/agent/configure/smart-title.md](../../../../../1.0.x/agent/configure/smart-title.md)).
This form only manages the **bundle eligibility list** stored in the parent's
`smart_title.settings` config under key `smart_title`.

## The form

- Route: `smart_title_ui.settings` → `/admin/config/content/smart-title`
- Permission: `administer smart title`
- Class: `\Drupal\smart_title_ui\Form\SmartTitleConfigForm` (extends `ConfigFormBase`, form id
  `smart_title_config_form`), editable config `smart_title.settings`.

### Which entity types / bundles are listed

`buildForm()` renders one `checkboxes` element per eligible entity type
(`$form["<entity_type>_bundles"]`, title "Smart Title for <label>"), with one checkbox per
bundle whose value is the string `"<entity_type>:<bundle>"`. An entity type is listed only when
ALL of these hold:

| Condition | Source check |
|---|---|
| Content entity type | `instanceof ContentEntityTypeInterface` |
| Fieldable | `entityClassImplements(FieldableEntityInterface::class)` |
| Has a Field UI base route | `->get('field_ui_base_route')` is set |
| Has a label key | `->getKey('label')` is non-empty |
| Its label base field is NOT already display-configurable | `!$base_field_definitions[$label_key]->isDisplayConfigurable('view')` |

The last rule is why `node` and similar content entities appear, while entity types whose label
is already a configurable display component are omitted (Smart Title would be redundant there).
Checkbox defaults come from the current `smart_title.settings.smart_title` list.

### What saving does (`submitForm()`)

1. Collects every checked `entity_type:bundle` into the new list, and every bundle shown on the
   form into a "seen" list.
2. Computes the unchecked-but-seen bundles (`array_diff`). For each `entity_view_display` whose
   `entity_type:bundle` is in that set, it calls
   `unsetThirdPartySetting('smart_title', 'enabled')` and
   `unsetThirdPartySetting('smart_title', 'settings')`, then saves the display — i.e. it cleans
   up orphaned per-display Smart Title config when you turn a bundle off.
3. Writes the checked list to `smart_title.settings` key `smart_title` and saves it.
4. Runs `Cache::invalidateTags(['entity_field_info'])` so the parent's `smart_title` extra field
   appears (or disappears) on the affected Manage-display forms.

### Doing it without the form

The form is a convenience over one parent config key; you can set the same list directly:

```php
\Drupal::configFactory()->getEditable('smart_title.settings')
  ->set('smart_title', ['node:article', 'node:page'])->save();
\Drupal\Core\Cache\Cache::invalidateTags(['entity_field_info']);
```

The parent module owns the `smart_title.settings` schema; this submodule defines no config
object or schema of its own. It can be uninstalled after configuring — the parent keeps working
from the stored list.
