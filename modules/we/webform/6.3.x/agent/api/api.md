# Webform API (services & entities)

## Entities
- `webform` — config entity (`Drupal\webform\WebformInterface`). The form definition.
- `webform_submission` — content entity (`Drupal\webform\WebformSubmissionInterface`). A response.

```php
// Load a form and create a submission programmatically.
$webform = \Drupal::entityTypeManager()->getStorage('webform')->load('contact');

use Drupal\webform\Entity\WebformSubmission;
$submission = WebformSubmission::create([
  'webform_id' => 'contact',
  'data' => ['name' => 'Ada', 'email' => 'ada@example.com'],
]);
$submission->save();

// Read data back.
$values = $submission->getData();               // array keyed by element
$one    = $submission->getElementData('email');
```

## Programmatic submission with validation
```php
/** @var \Drupal\webform\WebformSubmissionGenerateInterface */
$errors = \Drupal::service('webform.submission_generate'); // test data generator
// Validate + submit like the real form:
$result = \Drupal\webform\Entity\WebformSubmission::create($values);
```
Use `WebformSubmissionForm::submitFormValues($values, $webform)` (static helper) to run a
submission through handlers/validation from code.

## Key services (`webform.services.yml`)
- `webform.token_manager` — replace `[webform_submission:...]` tokens.
- `webform.elements_validator` — validate an elements YAML tree.
- `webform.message_manager` — render the module's standard messages.
- `webform.access_rules_manager` — evaluate per-form access rules.
- `webform.libraries_manager` — status of optional external JS/CSS libraries.
- `webform.theme_manager` / `webform.request` — theming + current webform/source-entity context.
- Plugin managers: `plugin.manager.webform.element|handler|exporter|variant|source_entity`.

## Element helper
`Drupal\webform\Utility\WebformElementHelper` and `WebformYaml` (decode/encode the elements tree)
are handy static utilities when manipulating form definitions.
