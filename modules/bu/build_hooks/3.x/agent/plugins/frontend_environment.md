<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Implementing a FrontendEnvironment plugin

The one plugin type this module defines. A FrontendEnvironment plugin knows how to turn a stored
environment configuration into an outbound "build hook" request (a `BuildHookDetails`), and optionally
adds fields to the environment config form and the deploy form.

Grounded in `src/Plugin/FrontendEnvironmentManager.php`, `src/Annotation/FrontendEnvironment.php`,
`src/Plugin/FrontendEnvironmentBase.php`, `src/Plugin/FrontendEnvironmentInterface.php`,
`src/Plugin/FrontendEnvironment/GenericFrontendEnvironment.php`, and `src/BuildHookDetails.php`.
The provider submodules are the best real examples (`build_hooks_{netlify,github,circleci,bitbucket}`).

## Discovery

- Manager service: `plugin.manager.frontend_environment`
  (`Drupal\build_hooks\Plugin\FrontendEnvironmentManager`).
- Directory: `src/Plugin/FrontendEnvironment/`. Interface: `FrontendEnvironmentInterface`.
  Annotation: `@FrontendEnvironment`. Alter hook: `build_hooks_frontend_environment_info`.
- Annotation fields: `id`, `label`, `description`.
- Each environment config entity references a plugin by `plugin` id and stores per-instance config in
  `settings`, schema-keyed as `frontend_environment.settings.{plugin_id}` — you MUST add that schema.

## Minimal plugin (mirrors `generic`)

```php
<?php
namespace Drupal\my_provider\Plugin\FrontendEnvironment;

use Drupal\build_hooks\BuildHookDetails;
use Drupal\build_hooks\Plugin\FrontendEnvironmentBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * @FrontendEnvironment(
 *   id = "my_provider",
 *   label = "My Provider",
 *   description = "Deploys via My Provider's API."
 * )
 */
class MyProviderEnvironment extends FrontendEnvironmentBase {

  public function defaultConfiguration() {
    return ['build_hook_url' => ''] + parent::defaultConfiguration();
  }

  // Fields added to the "add/edit environment" form. (Base wraps this in
  // buildConfigurationForm(); do NOT override that — override this.)
  public function frontEndEnvironmentForm($form, FormStateInterface $form_state) {
    $form['build_hook_url'] = [
      '#type' => 'url',
      '#title' => $this->t('Build hook url'),
      '#default_value' => $this->configuration['build_hook_url'] ?? '',
      '#required' => TRUE,
    ];
    return $form;
  }

  public function frontEndEnvironmentSubmit($form, FormStateInterface $form_state) {
    $this->configuration['build_hook_url'] = $form_state->getValue('build_hook_url');
  }

  // The heart of the plugin: build the outbound request.
  public function getBuildHookDetails() {
    $details = new BuildHookDetails();
    $details->setUrl($this->configuration['build_hook_url']);
    $details->setMethod('POST');
    // $details->setOptions(['json' => [...], 'headers' => [...], 'auth' => [...]]);
    return $details;
  }

  // Extra elements shown on the DEPLOY form (e.g. a recent-builds table). Optional.
  public function getAdditionalDeployFormElements(FormStateInterface $form_state) {
    return [];
  }
}
```

Add the settings schema (`config/schema/my_provider.schema.yml`):

```yaml
frontend_environment.settings.my_provider:
  type: build_hooks.frontend_environment.plugin_settings
  mapping:
    build_hook_url:
      type: string
      label: 'Build hook URL'
```

## `BuildHookDetails` (the request DTO)

`Trigger` calls `$this->httpClient->request($details->getMethod(), $details->getUrl(), $details->getOptions())`.
So `getOptions()` is passed straight to Guzzle — use `json`, `headers`, `body`, `auth`, etc.
(`getBody()`/`setBody()` are deprecated; use `getOptions()`/`setOptions()`.)

## The base class gives you

- `label()`, `getConfiguration()`, `setConfiguration()` (deep-merges base + default + stored config),
  `calculateDependencies()` (adds the providing module), `getMachineNameSuggestion()`.
- `buildConfigurationForm()` injects a `provider` value element then calls your `frontEndEnvironmentForm()`;
  `submitConfigurationForm()` saves `label`+`provider` then calls your `frontEndEnvironmentSubmit()`;
  validation dispatches to `frontEndEnvironmentFormValidate()`.
- `deploymentWasTriggered(ResponseInterface $response): bool` — default TRUE for HTTP 200/201. Override
  to match your provider (Bitbucket overrides to 201-only; CircleCI v2 to any 2xx).
- `preDeploymentTrigger(BuildTrigger $trigger): void` — no-op hook to mutate the request or cancel.

## Injecting services

Implement `ContainerFactoryPluginInterface` and add a `create()`; the provider plugins inject
`http_client`, `date.formatter`, a provider manager service, or `config.factory` (to read the
provider credential from its own settings). See `NetlifyFrontendEnvironment`/`GithubFrontendEnvironment`.

## Verify your plugin is discovered

```bash
drush php:eval 'print implode(",", array_keys(
  \Drupal::service("plugin.manager.frontend_environment")->getDefinitions()));'
# expect your id among: generic,my_provider,...
```
