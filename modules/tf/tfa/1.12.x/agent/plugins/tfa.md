# Plugin types — extend TFA

TFA defines four annotation-based plugin types, each with a manager service. Discovery is by
annotation (`src/Annotation/`) under the matching `Plugin/` namespace.

| Type | Annotation / Interface | Namespace | Manager service | Role |
|---|---|---|---|---|
| Validation | `@TfaValidation` / `TfaValidationInterface` | `Drupal\tfa\Plugin\TfaValidation` | `plugin.manager.tfa.validation` | Render the code-entry form and validate the submitted code during login |
| Setup | `@TfaSetup` / `TfaSetupInterface` | `Drupal\tfa\Plugin\TfaSetup` | `plugin.manager.tfa.setup` | Per-user enrollment (setup form, help links, overview) for a validation method |
| Login | `@TfaLogin` / `TfaLoginInterface` | `Drupal\tfa\Plugin\TfaLogin` | `plugin.manager.tfa.login` | Decide whether the TFA step may be skipped (`loginAllowed()`), e.g. trusted browser |
| Send | `@TfaSend` / `TfaSendInterface` | `Drupal\tfa\Plugin\TfaSend` | `plugin.manager.tfa.send` | Deliver a code at the start of the TFA process (`begin()`), e.g. SMS/email |

Shipped plugins:

- Validation: `tfa_totp` (TOTP), `tfa_hotp` (HOTP), `tfa_recovery_code` (recovery codes).
- Setup: `tfa_totp_setup`, `tfa_hotp_setup`, `tfa_recovery_code_setup`, `tfa_trusted_browser_setup`.
- Login: `tfa_trusted_browser`.

Most base logic lives in `Drupal\tfa\Plugin\TfaBasePlugin` (encrypted secret storage via the
`encrypt`/`key` encryption profile).

## Add a validation plugin

`TfaValidationInterface` requires three methods:

```php
namespace Drupal\my_module\Plugin\TfaValidation;

use Drupal\Core\Form\FormStateInterface;
use Drupal\tfa\Plugin\TfaBasePlugin;
use Drupal\tfa\Plugin\TfaValidationInterface;

/**
 * @TfaValidation(
 *   id = "my_sms",
 *   title = @Translation("SMS code"),
 *   description = @Translation("Verify a code sent by SMS."),
 *   setupPluginId = "my_sms_setup"
 * )
 */
class MySms extends TfaBasePlugin implements TfaValidationInterface {

  public function getForm(array $form, FormStateInterface $form_state) { /* code field */ }

  public function validateForm(array $form, FormStateInterface $form_state) { /* return bool */ }

  public function ready() { /* has the user set this up? return bool */ }

}
```

The annotation's `setupPluginId` points to a matching `@TfaSetup` plugin
(implement `TfaSetupInterface`: `getSetupForm()`, `validateSetupForm()`, `submitSetupForm()`,
`getHelpLinks()`, `getSetupMessages()`, `getErrorMessages()`, `getOverview()`) so users can
enroll. Then add the new plugin id to `allowed_validation_plugins` in `tfa.settings`.

A validation plugin that also delivers a code should additionally implement `TfaSendInterface`
(`begin()`); a bypass rule is a `@TfaLogin` plugin implementing `loginAllowed()`.
