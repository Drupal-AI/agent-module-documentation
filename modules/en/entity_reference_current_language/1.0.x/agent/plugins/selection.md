<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Current Language selection plugin

Source: `src/Plugin/EntityReferenceSelection/CurrentLanguageSelection.php`.

## Plugin definition

`@EntityReferenceSelection` annotation:
- `id = "current_language"`
- `label = "Current Language"`
- `group = "current_language"`
- `weight = 0`

Class `CurrentLanguageSelection extends
Drupal\Core\Entity\Plugin\EntityReferenceSelection\DefaultSelection`. Because it extends the core
Default selection handler, it inherits all of the Default handler's behaviour (target-type/bundle
handling, `match`/`match_operator` autocomplete matching, sorting, `getReferenceableEntities()`,
`validateReferenceableEntities()`, and — importantly — the entity-query **access checking** the Default
handler applies). This module changes only two things.

## Setting

`buildConfigurationForm(array $form, FormStateInterface $form_state)`:
- calls `parent::buildConfigurationForm()` (so all standard Default-selection settings render), then
- adds `$form['current_language']`, a `checkbox` titled *"Filter by current language"*,
  `#default_value = $this->configuration['current_language'] ?? TRUE` (i.e. **on by default**),
  described as *"If checked, only content in the current language will be available for selection."*

There is no config schema shipped for this extra key; it is stored inside the field's existing
`handler_settings`.

## Query behaviour

`buildEntityQuery($match = NULL, $match_operator = 'CONTAINS')`:
1. `$query = parent::buildEntityQuery($match, $match_operator);` — the core Default handler builds the
   base query (bundle conditions, label match, and its access filtering).
2. If `!empty($this->configuration['current_language'])`, it adds
   `$query->condition('langcode', \Drupal::languageManager()->getCurrentLanguage()->getId());`.
3. Returns the query.

The current language comes from the core language manager's `getCurrentLanguage()->getId()` — the
active interface/content language for the request. The added `langcode` condition only **restricts** the
candidate set to that language; when the checkbox is unchecked the plugin behaves exactly like the core
Default handler.

## Enable / use

1. `composer require drupal/entity_reference_current_language` (no `composer.json` in the module; the
   dependency is resolved by drupal.org packaging) and `drush en entity_reference_current_language`
   (core `language` is required).
2. Edit an entity reference (or entity reference revisions/media/taxonomy, etc.) field's settings.
3. Set **Reference method** / **Reference type** to *"Current Language"*.
4. Leave *"Filter by current language"* checked to filter, or uncheck it to fall back to plain Default
   behaviour. Save.

The field's widget (autocomplete, select, checkboxes/radios, etc.) then offers only entities whose
`langcode` matches the current language.
