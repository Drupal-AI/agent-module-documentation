<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ElasticsearchAuth` plugin type

Pluggable authentication methods for the connection. The settings form lists every method and
renders its sub-form; the selected method's plugin configures the client at build time.

- Manager service: `plugin.manager.elasticsearch_auth`
  (`Drupal\elasticsearch_helper\Plugin\ElasticsearchAuthPluginManager`, parent
  `default_plugin_manager`).
- Discovery: `src/Plugin/ElasticsearchAuth/`.
- Annotation: `Drupal\elasticsearch_helper\Annotation\ElasticsearchAuth` (keys `id`, `label`,
  `description`, `weight`).
- Interface: `ElasticsearchAuthInterface` (extends `ConfigurableInterface`, `PluginFormInterface`);
  base: `ElasticsearchAuthPluginBase`.
- Alter hook: `elasticsearch_helper_elasticsearch_auth_info`.

The single interface method is `authenticate(\Elastic\Elasticsearch\ClientBuilder $client_builder)`,
called from `ElasticsearchClientBuilder::build()` when `authentication.method` matches the plugin id.
Configuration comes from `authentication.configuration.<method>` in `elasticsearch_helper.settings`.

## Built-in methods

| id | Class | Config keys | Client call |
|----|-------|-------------|-------------|
| `basic_auth` | `Plugin/ElasticsearchAuth/BasicAuth` | `user`, `password` | `setBasicAuthentication($user, $password)` |
| `api_key` | `Plugin/ElasticsearchAuth/ApiKey` | `id`, `api_key` | `setApiKey($id, $api_key)` |

Both store their values in `elasticsearch_helper.settings` under
`authentication.configuration.<id>` (schema:
`elasticsearch_helper.authentication_configuration.basic_auth` / `...api_key`).

## Add a custom method

```php
namespace Drupal\my_module\Plugin\ElasticsearchAuth;

use Drupal\Core\Form\FormStateInterface;
use Drupal\elasticsearch_helper\Plugin\ElasticsearchAuthPluginBase;
use Elastic\Elasticsearch\ClientBuilder;

/**
 * @ElasticsearchAuth(
 *   id = "my_token",
 *   label = @Translation("Bearer token"),
 *   weight = 2
 * )
 */
class MyToken extends ElasticsearchAuthPluginBase {

  public function defaultConfiguration() {
    return ['token' => ''];
  }

  public function buildConfigurationForm(array $form, FormStateInterface $form_state) {
    $form['token'] = ['#type' => 'textfield', '#title' => $this->t('Token'),
      '#default_value' => $this->configuration['token']];
    return $form;
  }

  public function submitConfigurationForm(&$form, FormStateInterface $form_state) {
    $this->configuration['token'] = $form_state->getValue('token');
  }

  public function authenticate(ClientBuilder $client_builder) {
    // Apply your credential to the client builder here.
  }
}
```

The base class merges `defaultConfiguration()` with stored config on construct; the settings form
calls `buildConfigurationForm()`/`submitConfigurationForm()` inside a per-method subform and saves
the plugin's `getConfiguration()` back into `authentication.configuration.<id>`.

For where these credentials are stored and read, see
[configure/settings.md](../configure/settings.md).
