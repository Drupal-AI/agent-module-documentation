<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Inline entity form - Complex (Open)" widget

The entire module is one field-widget plugin,
`src/Plugin/Field/FieldWidget/InlineEntityFormComplexOpen.php`:

```php
class InlineEntityFormComplexOpen extends
  \Drupal\inline_entity_form\Plugin\Field\FieldWidget\InlineEntityFormComplex
```

- Plugin id: **`inline_entity_form_complex_open`**
- Label: *"Inline entity form - Complex (Open)"*
- `field_types = { "entity_reference", "entity_reference_revisions" }`
- `multiple_values = true`

It changes only the widget's **initial render state and button labels**; storage, access, and
save handling are inherited unchanged from IEF Complex.

## Install & enable

```bash
composer require drupal/ief_complex_open
drush en ief_complex_open -y
```

Requires the contrib **Inline Entity Form** module (`drupal/inline_entity_form: ^1 || ^3`,
declared in both `composer.json` and `ief_complex_open.info.yml` as
`inline_entity_form:inline_entity_form`). No sub-modules, no permissions, no routes, no Drush
commands, no `.module`/`.install`, no config schema.

## Select the widget on a field

The widget targets `entity_reference` / `entity_reference_revisions` fields. Set it per form
display:

UI path — *Structure → (entity type) → (bundle) → Manage form display* → for the reference field,
choose widget **"Inline entity form - Complex (Open)"** → gear icon for settings.

Drush / config equivalent (form display):

```bash
drush cset core.entity_form_display.node.article.default \
  content.field_related.type inline_entity_form_complex_open -y
drush cr
```

Nothing else is required — there is no site-wide config page or install step beyond enabling the
module.

## Settings

`settingsForm()` calls `parent::settingsForm()`, so **every IEF Complex setting is inherited**
(`allow_new`, `allow_existing`, `allow_duplicate`, `match_operator`, `collapsible`, `collapsed`,
`override_labels`, `label_singular`, `label_plural`, `removed_reference`, `add_existing_widget`,
…).

`defaultSettings()` and `settingsForm()` add **one** extra option:

| Setting key | Default | Meaning |
|---|---|---|
| `bundle` | `''` | *"Restrict new inline entities to one bundle"* — a select listing the target type's bundles (`''` = "Do not restrict"). When set, inline creation is limited/pre-selected to that bundle. |

The option is built from `\Drupal::service('entity_type.bundle.info')->getBundleInfo($target_type)`
(`settingsForm()`, ~:560-579). It only **narrows** which bundle may be created — via
`$create_bundles = array_intersect([$settings['bundle']], $create_bundles) ?: $create_bundles`
in `formElement()` (~:314) — it never widens creation rights.

## How "open by default" works (from source)

`formElement()` is a near-verbatim copy of upstream `InlineEntityFormComplex::formElement()`
(the author states "Nearly exact copy of InlineEntityFormComplex 8.x-1.0-rc11" and marks every
divergence with a `Modifications:` comment). The differences:

1. **Reference form is built inline instead of behind a button.** In the `empty($open_form)`
   branch (~:358-407), when `allow_existing` is on and there is at least one referenceable entity
   (`$handler->getReferenceableEntities(NULL, 'CONTAINS', 2)`), the widget builds
   `$element['form']` directly via `inline_entity_form_reference_form()` rather than waiting for
   an "Add existing" click. On it:
   - `unset($element['form']['entity_id']['#title'])` — hides the autocomplete label.
   - `unset($element['form']['entity_id']['#required'])` — makes the autocomplete optional.
   - a `hideCancel` process callback is appended — removes the cancel button.
   - the fieldset title becomes *"Select existing @type_singular"* and the submit button
     *"Reference existing @type_singular"*.
   - the `#ief_element_submit` entry `inline_entity_form_reference_form_submit` is swapped for the
     class's own static `reference_form_submit` (~:402-405).
2. **Create controls relabeled.** In the `allow_new` block (~:410-460) the actions container is
   changed from `container` to `fieldset` and the "Add new …" button relabeled to
   **"Create new @type_singular"** (~:457-459).
3. **Cardinality can honor `field_config_cardinality`.** `formElement()` reads the
   `field_config_cardinality` / `cardinality_config` third-party setting (~:103) and, if present,
   uses it as the effective cardinality; otherwise it falls back to the storage cardinality. This
   is an optional integration with the like-named contrib module, not a dependency.

## `reference_form_submit()`

Because the autocomplete is no longer required, an empty value can be submitted. The static
override guards against that (~:538-543):

```php
public static function reference_form_submit($reference_form, FormStateInterface $form_state) {
  $form_values = NestedArray::getValue($form_state->getValues(), $reference_form['#parents']);
  if (!empty($form_values['entity_id'])) {
    inline_entity_form_reference_form_submit($reference_form, $form_state);
  }
}
```

An empty submit references nothing and no-ops; a non-empty one delegates to core's
`inline_entity_form_reference_form_submit()`. Referenceable candidates, per-entity `update` /
`delete` access on the Edit/Remove row buttons, and the create path are all the inherited
IEF Complex behavior.

## Rollback

Switch the field's widget back to standard **Inline entity form - Complex** on *Manage form
display* (or `drush cset … .type inline_entity_form_complex`). Field storage is unchanged, so no
data migration is needed.
