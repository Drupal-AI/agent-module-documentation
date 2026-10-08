# Extend — add your own AI ECA action

To expose another AI operation type as an ECA action, subclass one of the base classes in
`src/Plugin/Action/`.

## Base classes

- **`AiActionBase`** (extends `eca`'s `ConfigurableActionBase`): gives you the `model`,
  `token_input`, `token_result` config + form, model validation, `calculateDependencies()` (adds
  the provider module), and helpers `getModelData()` / `loadModelProvider()`. You must implement:
  - `getOperationType(): string` — the AI operation id (`chat`, `embeddings`, `moderation`,
    `speech_to_text`, `text_to_speech`, …). It feeds the Model select and the validator.
  - `execute(): void` — read `$this->tokenService->getTokenData($this->configuration['token_input'])`,
    call the provider, write with `$this->tokenService->addTokenData($this->configuration['token_result'], …)`.
- **`AiConfigActionBase`** (extends `AiActionBase`): adds the YAML **`config`** textarea, parses it
  with `eca.service.yaml_parser`, and validates it in both `validateConfigurationForm()` and
  `access()` against the provider. Override `getExtraConstraints()` to add Symfony constraints for
  your custom config keys (Chat uses this for optional `system_name`/`system_prompt` string
  constraints). Use `getModelConfig()` to get the parsed, token-ready config array in `execute()`.

Minimal example:

```php
/**
 * @Action(
 *   id = "mymodule_ai_translate",
 *   label = @Translation("AI translate"),
 *   description = @Translation("Translate text via AI.")
 * )
 */
class Translate extends AiConfigActionBase {
  protected function getOperationType(): string { return 'chat'; }
  public function execute(): void {
    $provider = $this->loadModelProvider();
    $in = $this->tokenService->getTokenData($this->configuration['token_input']);
    $provider->setConfiguration($this->getModelConfig());
    // ... call $provider->chat(...) with $in ...
    $this->tokenService->addTokenData($this->configuration['token_result'], $result);
  }
}
```

## The provider validator service

`ai_integration_eca.provider_validator` → `Drupal\ai_integration_eca\Service\AiProviderValidator`
(interface `AiProviderValidatorInterface`, arg `@validation.basic_recursive_validator_factory`).

```php
$violations = \Drupal::service('ai_integration_eca.provider_validator')
  ->addConstraints($extraConstraints)                 // optional per-key Symfony constraints
  ->validate($providerProxy, $modelId, $operationType, $configArray);
```

It reads `$provider->getAvailableConfiguration($operationType, $model)` and builds a Symfony
`Collection` (with `Range`/`Choice`/`Type`/`NotBlank`/`Required`/`Optional` per the provider's
schema), returning a `ConstraintViolationList`. Empty schema ⇒ no violations. This is how the
config-YAML actions reject invalid model parameters before running.
