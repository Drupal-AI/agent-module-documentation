<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `checkout_type` plugin type

A checkout type is a pluggable checkout UI. `arch_onepage` provides the default `onepage` plugin;
you can add alternatives (multi-step, express, etc.).

## Wiring

- Manager: **`plugin.manager.checkout_type`**, class `CheckoutType\CheckoutTypeManager` (extends
  `DefaultPluginManager`, `CategorizingPluginManagerTrait` + `FilteredPluginManagerTrait`,
  `FallbackPluginManagerInterface`). Constructor args include `logger.factory` and `config.factory`.
- Discovery dir `Plugin/CheckoutType`, annotation `@CheckoutType`
  (`CheckoutType\Annotation\CheckoutType`), interface
  `CheckoutType\CheckoutTypePluginInterface`, base `CheckoutType\CheckoutType`, fallback id
  **`broken`** (hidden from lists). Cache bin `checkout_type_plugins`.
- Plugin-type declaration: `arch_checkout.plugin_type.yml` (`arch_checkout_type`, decorated by
  `\Drupal\plugin\PluginDefinition\ArrayPluginDefinitionDecorator`).

## Annotation

```php
/**
 * @CheckoutType(
 *   id = "onepage",
 *   label = @Translation("Onepage Checkout"),
 *   admin_label = @Translation("Onepage Checkout"),
 *   description = @Translation("…"),
 *   form_class = "Drupal\arch_onepage\Form\OnepageCheckoutForm"
 * )
 */
```

## What a plugin implements

- `build()` — render array for `/checkout` (the `onepage` plugin wraps its `form_class` form in
  `arch_checkout_op` + summary themes).
- `buildConfigurationForm()` / `submitConfigurationForm()` — settings shown on
  `CheckoutSettingsForm`.
- Manager selection: `CheckoutTypeManager::getDefaultCheckoutType()` returns the plugin whose id
  matches `arch_checkout.settings:plugin_id` (else the first sorted definition). The `broken`
  fallback is excluded from the settings radios and from the default lookup.

## Related

- `arch_checkout.settings:plugin_id` chooses the active plugin.
- `hook_checkout_type_alter(&$definitions)` and `hook_checkout_plugin_alter()` let you change the
  definition list / the selected plugin per request.
