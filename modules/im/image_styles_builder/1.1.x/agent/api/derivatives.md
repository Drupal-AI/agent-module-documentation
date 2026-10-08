<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Derivatives, generate/flush, and the Twig helper

## Install & enable

`composer require --dev drupal/image_styles_builder` (or as a root dependency if you use the Twig
function in production), then `drush en image_styles_builder`. Only core `image` is required. Drush is
suggested (`^12 || ^13`) and required to actually generate/flush.

## Declaring styles — the YAML format

Ship one file per module: `MODULE.image_styles_builder_derivatives.yml`. Discovered by `YamlDiscovery`
over every enabled module's directory (`DerivativeManager::getDiscovery()`). Top level is keyed by a
**derivative id**; `label` is translatable (`addTranslatableProperty('label', 'label_context')`).

```yaml
default:                     # derivative id
  id: default
  label: Default             # required
  suffix: dft                # required — prefixes every generated style name
  styles:                    # required
    16_10_128x80:            # style id
      effects:               # required per style
        - type: scale_and_crop   # a core image.effect plugin id
          width: 128             # optional, promoted into effect data['width']
          height: 80             # optional, promoted into effect data['height']
        - type: image_scale
          data:                  # optional, arbitrary effect settings
            width: 64
```

`DerivativeManager::processDefinition()` throws `PluginException` if `label`, `suffix`, or `styles` is
missing, or if any style has empty `effects`. The generated **image-style machine name** is
`suffix_styleid` (e.g. `dft_16_10_128x80`) — see `Plugin/Derivative/ImageStyle::__construct`. Note the
README's top-level example nests `width`/`height` directly under an effect; both that form and a nested
`data:` map work because `ImageStyleGenerator` merges promoted width/height into `data`.

### Value objects

- `Plugin/Derivative/Derivative` (a real `PluginBase`, built by `DerivativeManager::createInstance`):
  `getId()/getLabel()/getSuffix()/getStyles()/getStyle($id)`.
- `Plugin/Derivative/ImageStyle`: holds the final `id` and an array of `ImageEffect`; `getEffects()`,
  `getId()`, `__toString()`.
- `Plugin/Derivative/ImageEffect`: `type`, `width`, `height`, `data`; `__toString()` renders a
  human-readable summary used in the Drush tables.

## Generation — `ImageStyleGenerator::generate()`

`src/ImageStyleGenerator.php` (service `image_styles_builder.manager.image_style_generator`). For a given
`ImageStyle`: if an `image_style` entity with that name already exists it logs
`The image style @machine_name already exists.` and returns `NULL` (idempotent). Otherwise it
`create()`s the entity (`name` and `label` both = the machine name), and for each effect builds
`['uuid'=>NULL,'id'=>type,'data'=>data,'weight'=>weight,'name'=>id]`, instantiates it through the core
`plugin.manager.image.effect` manager, and `addImageEffect()`s it. Effect **weight = array order**.
Finally `$style->save()`. Effect ids and their `data` are whatever the core image module (or other
effect-providing modules) supports — this module does not validate effect settings.

## Flush — `ImageStyleFlusher::flush()`

`src/ImageStyleFlusher.php` (service `image_styles_builder.manager.image_style_flusher`). Loads the
`image_style` entity by name and `delete()`s it; logs `... does not exists.` if absent. Deletes by the
**declared** name, so removing a style from YAML before flushing leaves the orphan behind.

## Drush commands

- **`drush isb:gen`** (`image_styles_builder:generate`, `Commands/GenerateCommand`): loads all
  derivative definitions, `io()->choice()` to pick one or "All", loops styles → `generate()`, prints a
  `Derivative | Label | Effects` table of the created styles (skipped ones are omitted).
- **`drush isb:flush`** (`image_styles_builder:flush`, `Commands/FlushCommand`): same discovery/choice,
  loops → `flush()`, prints a `Derivative | Label` table. Both are non-interactive-unfriendly (they
  prompt). Registered in `drush.services.yml` with the `drush.command` tag.

After `isb:gen`, export the new styles as normal config (`drush cex`) if you want them in your config
sync directory — the module itself ships none.

## Twig — `isb_image_styles()`

`src/TwigExtension/ImageStyle.php` registers `isb_image_styles(derivative_id)`. It reads the derivative
definition from `DerivativeManager` and returns an **array of generated style machine names**
(`suffix_id`) for every style in that derivative, or `[]` if the derivative/styles are undefined. It
returns names only — it does not check whether the styles were actually generated. Example:

```twig
{% set styles = isb_image_styles('default') %}
{{ styles|json_encode }}
```

## Surface summary

No routes, permissions, forms, controllers, hooks, `config/install`, or `config/schema`. Everything runs
from the CLI or from Twig against on-disk YAML in trusted module directories.
