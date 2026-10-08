<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PII redactor plugin type

The module defines a `pii_redactor` plugin type for stripping Personally Identifiable Information
from stored Webform submissions, plus one working sample plugin. There is no UI or automatic hook
that runs it — a site invokes it in its own code / a submission handler.

## The plugin type

Registered in `localgov_forms.services.yml` as `plugin.manager.pii_redactor` →
`Drupal\localgov_forms\Plugin\PIIRedactorPluginManager` (`parent: default_plugin_manager`).

`PIIRedactorPluginManager` (`src/Plugin/PIIRedactorPluginManager.php`) scans namespace
`Plugin/PIIRedactor`, uses attribute `Drupal\localgov_forms\Attribute\PIIRedactor`, interface
`Drupal\localgov_forms\Plugin\PIIRedactorPluginInterface`, alter hook `pii_redactor_info`, cache key
`pii_redactor_plugins`. (`src/Annotations/PIIRedactor.php` is a legacy annotation kept alongside the
attribute.) Manager interface: `PIIRedactorPluginManagerInterface`. Plugin base:
`PIIRedactorPluginBase` (extends `PluginBase`; a placeholder). A plugin implements
`redact(WebformSubmissionInterface $webform_submission): array` and returns the redacted element keys.

### Writing a plugin

```php
namespace Drupal\my_module\Plugin\PIIRedactor;

use Drupal\localgov_forms\Attribute\PIIRedactor;
use Drupal\localgov_forms\Plugin\PIIRedactorPluginBase;
use Drupal\webform\WebformSubmissionInterface;

#[PIIRedactor(id: 'my_redactor', label: 'My redactor', description: '…')]
class MyRedactor extends PIIRedactorPluginBase {
  public function redact(WebformSubmissionInterface $webform_submission): array { /* … */ }
}
```

Invoke via `\Drupal::service('plugin.manager.pii_redactor')->createInstance('best_effort_pii_redactor')->redact($submission)`.

## Sample plugin: `best_effort_pii_redactor`

`src/Plugin/PIIRedactor/BestEffortPIIRedactor.php` delegates to the utility class
`Drupal\localgov_forms\BestEffortPIIRedactor::redact()`. That class:

- **Fully redacts** (value set to NULL) elements whose `#type` is one of `PII_ELEMENT_TYPES`
  (`address`, `email`, `localgov_forms_dob`, `localgov_webform_uk_address`, `number`, `tel`,
  `webform_name`, `webform_address`, `webform_contact`, `webform_telephone`) **and** elements whose
  machine name matches `GUESSED_PII_ELEM_PATTERN` (`name|mail|phone|contact_number|date_of_birth|
  dob_|nino|address|postcode|post_code|personal_|title|gender|sex|ethnicity|passport|serial_number|
  reg_number|pcn_|driver_`, case-insensitive) among the "potential PII" types (`localgov_forms_date`,
  `checkboxes`, `processed_text`, `radios`, `textfield`).
- **Partly redacts** `textarea` values via `BestEffortPIIRedactorForText::redact()`, which
  `preg_replace`s UK postcodes → `REDACTED_POSTCODE`, emails → `REDACTED_EMAIL`, and any digit run
  → `REDACTED_NUMBER`.
- Appends a note to the submission listing the redacted element keys
  (`addRedactionNote()`, prefixes `Redacted elements: ` / `Partly redacted elements: `).

Element/type mapping comes from `WebformSubmission::getWebform()->getElementsDecodedAndFlattened()`.
It is explicitly "best effort" — regex-based, so uncommon email/number formats can slip through and
legitimate numeric answers in textareas get masked; treat it as a helper, not a guarantee.
