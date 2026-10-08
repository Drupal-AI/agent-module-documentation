<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SupportIntegration plugin type, toolbar & redirect flow

The whole module is a thin plugin dispatcher. A **SupportIntegration** plugin's only job is to
return a redirect response; the toolbar tab points at `/client-support`, and that route asks the
selected plugin where to send the user.

## Plugin type definition

- **Annotation** `Drupal\client_support\Annotation\SupportIntegration` (`@Annotation`): properties
  `id`, `title` (`@Translation`), `description` (`@Translation`).
- **Interface** `Drupal\client_support\Component\SupportIntegrationInterface`: one method
  `redirect()` returning a `TrustedRedirectResponse` or `RedirectResponse`.
- **Base class** `Drupal\client_support\Component\SupportIntegrationBase` (abstract, implements the
  interface, empty body). Plugins **should extend this base**, not just implement the interface.
- **Manager** `Drupal\client_support\Component\SupportIntegrationManager` (service
  `plugin.manager.support_integration`, `parent: default_plugin_manager`): discovery subdir
  `Plugin/SupportIntegration`, interface `SupportIntegrationInterface`, annotation
  `SupportIntegration`. Cache backend keyed `support_integration_plugins`; alter hook
  `support_integration_info`.

## Toolbar handler (`Handler/ToolbarHandler`)

`client_support_toolbar()` (in `client_support.module`) bridges `hook_toolbar()` to
`ToolbarHandler::toolbar()` via `class_resolver`. `toolbar()` returns an empty array unless
`access()` is TRUE:

```php
protected function access() {
  $plugins = $this->supportPluginManager->getDefinitions();
  $currentPlugin = $this->supportSettings->get('settings.integration_plugin');
  return !(empty($plugins) || NULL === $currentPlugin)
    && $this->account->hasPermission('access client support');
}
```

So the tab appears only when a plugin exists, a plugin is selected, and the user holds
`access client support`. The render array is a `toolbar_item` (`#weight` 999, right-floated via
`css/toolbar.css`) linking to route `client_support.toolbar`, cache context `user.permissions`,
attaching library `client_support/toolbar`. `lazyBuilder()` exists but is unused ("Not yet used").

## Redirect controller (`Controller/RedirectController`)

Route `client_support.toolbar` (`GET /client-support`, `_permission: access client support`):

```php
public function redirectHandler() {
  $plugins = $this->supportPluginManager->getDefinitions();
  $pluginId = $this->supportSettings->get('settings.integration_plugin');
  $pluginInstance = $this->classResolver
    ->getInstanceFromDefinition($plugins[$pluginId]['class']);
  return $pluginInstance->redirect();
}
```

It instantiates the plugin's **class** through `class_resolver` (not the plugin manager's
`createInstance`), then returns whatever `redirect()` produces. No null check on `$pluginId` — see
the caveat in the agent index. The access control on the *destination* is the plugin/route's own
responsibility; the permission text notes "users must have access for the target route as well."

## Writing your own integration

1. Create `Drupal\your_module\Plugin\SupportIntegration\MyIntegration` extending
   `SupportIntegrationBase`, annotated:
   ```php
   /**
    * @SupportIntegration(
    *   id = "my_integration",
    *   title = @Translation("My integration"),
    *   description = @Translation("...")
    * )
    */
   ```
2. Implement `redirect()` to return a `TrustedRedirectResponse` (for external/generated URLs) or a
   `RedirectResponse`/`Url`-derived response to an internal route.
3. Clear caches, then select the plugin at
   `/admin/config/client-support/client-support-settings`.

The `client_support_contact_form` submodule is the reference implementation: its `contact_form`
plugin returns `new TrustedRedirectResponse(Url::fromRoute('entity.contact_form.canonical',
['contact_form' => 'support_form'])->toString(TRUE)->getGeneratedUrl())`.
