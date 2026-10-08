<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Basic Augment Action (`augmentator_eca_basic`)

## Install & enable

```bash
drush en augmentor_eca -y   # requires augmentor + eca (>=2.1)
```

No UI of its own — the action appears in the ECA modeller's action list once ECA and this submodule
are enabled. Configure augmentor instances first at `/admin/config/augmentors`.

## The action

- **Id:** `augmentator_eca_basic` (note the spelling), label *"Basic Augment Action"*, description
  *"Run text through Augmentor."*
- **Class:** `AugmentorBasic` (`src/Plugin/Action/AugmentorBasic.php`) → `AugmentorBase`
  (`src/Plugin/Action/AugmentorBase.php`) → `Drupal\eca\Plugin\Action\ConfigurableActionBase`.
- The base's `create()` injects the Augmentor manager
  (`plugin.manager.augmentor.augmentors`) onto `$this->augmentorManager`.

## Configuration form (`AugmentorBase::buildConfigurationForm`)

| Key | Element | Default | Meaning |
|---|---|---|---|
| `augmentor` | select (required) | `''` | Which saved augmentor to run; options are `getAugmentors()` labels keyed by UUID. |
| `response_key` | textfield (token ref) | `default` | Which key to pull from the augmentor's result array. |
| `token_input` | textfield (token ref, required) | `''` | Token holding the input text for the augmentor. |
| `token_result` | textfield (token ref, required) | `''` | Token name to store the augmentor's response into. |

`response_key`/`token_input`/`token_result` carry `#eca_token_reference => TRUE`.
`submitConfigurationForm()` writes all four back to `$this->configuration`.

## Execute flow (`AugmentorBasic::execute`)

```php
$augmentor  = $this->augmentorManager->getAugmentor($this->configuration['augmentor']);
$tokenValue = $this->tokenService->getTokenData($this->configuration['token_input'])?->getValue() ?? '';
if (!$augmentor || !$tokenValue) { return; }              // no augmentor or empty input → no-op
$result = $augmentor->execute($tokenValue);
$response_key = $this->configuration['response_key'] ?? NULL;
$this->tokenService->addTokenData(
  $this->configuration['token_result'],
  $response_key ? $result[$response_key] : $result        // one key, or the whole array
);
```

So: read the input token → run the augmentor → store either the single `response_key` value or the
entire result array into the result token, for later ECA steps to consume (set a field, branch, send
mail, etc.).

## Operating notes

- The `tokenService` comes from ECA's `ConfigurableActionBase`; token resolution and action
  access/gating are ECA's responsibility — this submodule adds no permission or route.
- Empty input or an unknown augmentor UUID makes the step a silent no-op (early `return`).
- Provider augmentors execute here exactly as elsewhere (same Key-based credentials, same external
  calls) — this path calls the plugin's `execute()` directly and does **not** fire the parent's
  `pre_execute`/`post_execute` HTTP hooks (those only run on the field-widget execute controller).
