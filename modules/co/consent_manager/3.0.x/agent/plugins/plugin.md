# consent_manager — the `consent_manager` plugin type, block, and settings base

## Plugin type
- Manager: `src/ConsentManagerPluginManager.php` (service `plugin.manager.consent_manager`), extends
  `DefaultPluginManager`, discovery dir `Plugin/ConsentManager`, alter hook `consent_manager_info`,
  cache key `consent_manager_plugins`.
- Attribute: `src/Attribute/ConsentManager.php` — `#[ConsentManager(id, ?label, ?description,
  ?deriver, ?bool has_block = TRUE)]`. Note: the `id` must equal the plugin group or be
  `group:derivative`.
- Interface: `ConsentManagerPluginInterface` — `label(): string`, `getCode(): string|false`.
- Base class: `ConsentManagerPluginPluginBase` — implements `label()`, `getConfiguration()`, and a
  default `getCode()` that renders `static::CODE` with placeholders. Consts `DEFAULT_HOST =
  delivery.consentmanager.net`, `DEFAULT_CDN = cdn.consentmanager.net`.

### Config auto-loading
`createInstance($plugin_id, $configuration = [])` — when no configuration is passed, it loads
`(array) \Drupal::config('consent_manager_' . $plugin_id . '.settings')->get()`. So each plugin's
runtime config is its submodule's own config object (e.g. `consent_manager_cmp.settings`).

### `getCode()` (base)
```php
if ($code_id = $this->configuration['codeid'] ?? NULL) {
  $code = new FormattableMarkup(static::CODE, [
    '@codeid' => $code_id,
    '@host'   => $this->configuration['host'] ?? static::DEFAULT_HOST,
  ]);
}
```
Returns FALSE if no Code-ID configured. `@`-placeholders are escaped by `FormattableMarkup`
(`Html::escape`). Subclasses set a `CODE` template constant (a `<script>`/`<div>` snippet).

### Implementing a plugin
```php
#[ConsentManager(id: 'myproduct', label: new TranslatableMarkup('My product'), has_block: TRUE)]
final class MyProduct extends ConsentManagerPluginPluginBase {
  protected const CODE = '<script src="https://@host/delivery/@codeid.js" async></script>';
}
```
Provide a `consent_manager_myproduct.settings` config object with at least `codeid` (and optionally
`host`). If `has_block` is TRUE the generic block exposes it as a placeable derivative; if FALSE the
submodule typically injects the code itself via `hook_page_attachments` / `hook_preprocess_html`
(as cmp and analytics do).

## Generic block
`src/Plugin/Block/ConsentManagerBlock.php` (id `consent_manager`, deriver
`src/Plugin/Derivative/ConsentManagerBlock.php`). The deriver creates one block derivative per plugin
returned by `ConsentManagerPluginManager::getBlockDefinitions()` (i.e. plugins with `has_block =
TRUE`). `build()` instantiates the plugin and renders `#markup => $plugin->getCode()` with cache tag
`consent_manager_<id>`.

## Settings base form
`src/Form/SettingsBaseForm.php` (abstract, extends `ConfigFormBase`). Subclasses implement
`getPluginType()` (returns the plugin id). It supplies:
- An "Install now" button that attaches `consent_manager/settings` (`js/settings.js`) and
  `drupalSettings.consent_manager = {type, domain, lang}`; clicking opens
  `https://app.consentmanager.net/clientv2/onboarding` in a popup. On completion the popup posts a
  message back; `settings.js` verifies `e.origin === 'https://app.consentmanager.net'`, then fills
  the matching form fields by `name` and submits.
- `validateForm()` validates `host`/`cdn` with `FILTER_VALIDATE_DOMAIN | FILTER_FLAG_HOSTNAME`.
- `submitForm()` invalidates cache tag `consent_manager_<type>`.

## Rendering & hardening (security-relevant, by design)
- Submodule code is emitted as **raw markup** into every non-admin page (cmp via
  `hook_page_attachments`/`hook_preprocess_html`; analytics via `hook_preprocess_html`; block-based
  products via the block). This is intentional — the module's whole purpose is to inject the vendor
  `<script>`.
- The cmp submodule additionally prepends a free-form `custom_code` textarea value **unescaped** (it
  is the `FormattableMarkup` template string, not a placeholder), so any HTML/JS entered there is
  output verbatim in the page head.
- All of the above is editable only via the settings forms gated by `administer consent manager
  settings`, which is `restrict access: true` (trusted admin). So this is not a privilege-crossing
  vulnerability — but treat that permission as highly sensitive and grant it only to trusted admins.
