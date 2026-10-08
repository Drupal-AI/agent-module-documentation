<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Demo Augmentor (augmentor_demo) — agent index

Submodule of **augmentor**. A **blueprint augmentor plugin for developers**: one offline example
Augmentor (`demo`) that splits text into sentences. Package `Augmentor`. Core
`^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.2.x. Depends only on **`augmentor`**.

- **The `demo` Augmentor plugin — annotation, config form, `execute()`, and how to copy it** →
  [plugins/demo-augmentor.md](plugins/demo-augmentor.md)

## What it actually is

- One Augmentor plugin: `Demo` (id **`demo`**, label *"Demo Augmentor"*), in
  `src/Plugin/Augmentor/Demo.php`, extending the parent's `AugmentorBase` and implementing
  `ContainerFactoryPluginInterface`. Declared with both the legacy `@Augmentor` annotation and the
  `#[Augmentor(...)]` attribute (`Drupal\augmentor\Attribute\Augmentor`).
- One hook class `src/Hook/AugmentorDemoHooks.php` (autowired service) implementing
  `hook_help()` for `help.page.augmentor`; legacy shim in `augmentor_demo.module`.
- **No routes, no permissions, no config schema, no config/install, no Drush, no libraries** of its
  own. `augmentor_demo.services.yml` only registers the hook class.

## Mechanism (from source)

- `execute($input)` is **fully local — no external/API call**. It runs
  `strip_tags($input)`, removes `, ; : '` characters, `explode('.', …)` on the period, and returns
  `['default' => …]`:
  - output `content` → `[first sentence]`;
  - output `tags` → `array_unique(explode(' ', first sentence))` (unique words).
- `defaultConfiguration()` adds `output => NULL` on top of `AugmentorBase::defaultConfiguration()`.
- `buildConfigurationForm()` calls the parent form, **`unset($form['key'])`** (no API key needed),
  and adds an `output` select (`content` / `tags`). `submitConfigurationForm()` saves `output`.

## Enable & use

```bash
drush en augmentor_demo -y
```
Create a *Demo Augmentor* at **`/admin/config/augmentors`** (add → *Demo Augmentor*), pick an output
format, then attach it to a field widget or the CKEditor augmentor button to test the framework
without an AI provider. Details in [plugins/demo-augmentor.md](plugins/demo-augmentor.md).
