<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `config.rewriter` service

Service id **`config_rewrite.config_rewriter`**, interface
`Drupal\config_rewrite\ConfigRewriterInterface`. Two public methods.

```php
/** @var \Drupal\config_rewrite\ConfigRewriterInterface $rewriter */
$rewriter = \Drupal::service('config_rewrite.config_rewriter');
```

## `rewriteModuleConfig($module)`

Applies a module's whole `config/rewrite/` folder to active config **and saves it** —
exactly what runs on that module's `hook_module_preinstall`. Call it to re-apply the
rewrites (e.g. after they changed) without reinstalling:

```php
$rewriter->rewriteModuleConfig('mymodule');   // reads mymodule/config/rewrite/*.yml, saves
```

It also walks each enabled language's `config/rewrite/language/<langcode>/` subfolder.

## `rewriteConfig($original_config, $rewrite, $config_name, $extensionName)`

The pure merge engine. Given the **existing** config array and a **rewrite** array, it
returns the merged array. It does **not** save — you save the result yourself. This is
the method to call when you want to rewrite an arbitrary config object from code:

```php
$config   = \Drupal::configFactory()->getEditable('system.site');
$original = $config->getRawData();                    // must be non-empty

$merged = $rewriter->rewriteConfig(
  $original,
  ['slogan' => 'Rewritten in code'],                  // your rewrite (may carry config_rewrite:)
  'system.site',                                       // config name (for logging/errors)
  'mymodule'                                            // extension name (for logging/errors)
);

$config->setData($merged)->save();                     // persist the rewrite
```

Behavior:

- **Deep-merges** the rewrite onto the original (`NestedArray::mergeDeep`) unless a
  `config_rewrite:` control key is present.
- `config_rewrite: 'replace'` → the rewrite replaces the whole object.
- `config_rewrite: { replace: [key.path, …] }` → only those dot-paths are replaced;
  a listed path missing from the rewrite is **unset** from the result.
- If `$original_config` is **empty** it logs an error and throws
  `Drupal\config_rewrite\Exception\NonexistentInitialConfigException` — you can only
  rewrite config that already exists.
- Note: `rewriteConfig()` returns the merged array **with** any `config_rewrite` /
  `config_rewrite_uuids` control keys still present; `rewriteModuleConfig()` strips them
  (and re-injects the original `uuid`/`_core`) before saving. When you call
  `rewriteConfig()` directly, unset a leftover `config_rewrite` key before saving.

## Service definition

```yaml
# config_rewrite.services.yml
config_rewrite.config_rewriter:
  class: Drupal\config_rewrite\ConfigRewriter
  arguments: ['@config.factory', '@module_handler', '@logger.channel.config_rewrite', '@file_system', '@?language.config_factory_override']
```

The last argument (`@?language.config_factory_override`) is optional — the service works
without the `language` module (multilingual rewrites are simply skipped).
