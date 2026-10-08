<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "demo" Augmentor plugin (blueprint)

## Install & enable

```bash
drush en augmentor_demo -y
```

Depends only on the parent **`augmentor`** module. No permissions, routes, config schema or Drush of
its own. Its purpose is to be a **minimal, copyable template** for writing custom augmentors and to
give an **offline** augmentor for testing the framework.

## Create and use the augmentor

1. Go to **`/admin/config/augmentors`** (parent UI, needs `administer augmentor`) → **Add** →
   **Demo Augmentor**.
2. Choose an **Output format** (`Content` or `Tags`) and save. (No API key field — it is removed.)
3. Attach the resulting augmentor to an Augmentor field widget, or expose it in the CKEditor 4/5
   augmentor button, to run it. Running still goes through the parent execute flow / permission
   `execute augmentor` where applicable.

## Plugin class (`src/Plugin/Augmentor/Demo.php`)

Id **`demo`**, label *"Demo Augmentor"*, description *"Split text into sentences separated by a
dot."*. Declared **twice** for D10→D11 compatibility:

```php
/** @Augmentor(id = "demo", label = @Translation("Demo Augmentor"), description = …) */
#[Augmentor(
  id: 'demo',
  label: new TranslatableMarkup('Demo Augmentor'),
  description: new TranslatableMarkup('Split text into sentences separated by a dot.'),
)]
class Demo extends AugmentorBase implements ContainerFactoryPluginInterface { … }
```

`Drupal\augmentor\Attribute\Augmentor` is the plugin attribute; `AugmentorBase` is the parent base
class that new augmentors extend.

### Configuration form

- `defaultConfiguration()` → `parent::defaultConfiguration() + ['output' => NULL]`.
- `buildConfigurationForm()` → parent form, then **`unset($form['key'])`** (this augmentor needs no
  provider API key), then adds:

  ```php
  $form['output'] = [
    '#type' => 'select',
    '#title' => $this->t('Output format'),
    '#options' => ['content' => $this->t('Content'), 'tags' => $this->t('Tags')],
    '#default_value' => $this->configuration['output'],
  ];
  ```

- `submitConfigurationForm()` → parent submit, then
  `$this->configuration['output'] = $form_state->getValue('output')`.

### `execute($input)` — the required method

Purely local text processing, **no HTTP/API call**:

```php
$input = str_replace([',', ';', ':', ',', "'"], '', strip_tags($input));
$parts = explode('.', $input);           // split on the period
if ($this->configuration['output'] == 'content') {
  $output = [$parts[0]];                  // first sentence
}
else {
  $output = array_unique(explode(' ', $parts[0])); // unique words of first sentence
}
return ['default' => $output];
```

The `['default' => …]` return shape is what the framework (field widgets, CKEditor integration)
consumes — the same key the CKEditor JS reads as `output.default`.

## Help hook (`src/Hook/AugmentorDemoHooks.php`)

`AugmentorDemoHooks::help()` (attribute `#[Hook('help')]`, `StringTranslationTrait`) returns a short
`<h3>Augmentor Demo</h3>` blurb for route `help.page.augmentor`. `augmentor_demo.module` wires it
via the `#[LegacyHook]` `augmentor_demo_help()` shim. `augmentor_demo.services.yml` registers the
hook class as an autowired service.

## Using it as a blueprint

To write a real augmentor, copy this class, keep the `#[Augmentor(...)]` attribute, extend
`AugmentorBase`, keep (do **not** unset) the `key` form element if you call an external provider,
and implement `execute($input)` to call your API and return `['default' => …]` (plus any extra
result keys your widgets map). The parent `augmentor` module handles the routing, permissions,
Key/secret handling and result dispatch.
