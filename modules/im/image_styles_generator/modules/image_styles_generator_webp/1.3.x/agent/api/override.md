<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: how the WebP override works

There is no new service ID, command or hook. The submodule works entirely by **altering the
parent's warmer service**.

## Service provider

`Drupal\image_styles_generator_webp\ImageStylesGeneratorWebpServiceProvider` extends
`ServiceProviderBase`. Its `alter(ContainerBuilder $container)`:

```php
if ($container->hasDefinition('image_styles_generator.derivative_warmer')) {
  $definition = $container->getDefinition('image_styles_generator.derivative_warmer');
  $definition->setClass('Drupal\image_styles_generator_webp\DerivativeWebpWarmer')
    ->addArgument(new Reference('webp.webp'));
}
```

So the same service ID `image_styles_generator.derivative_warmer` now resolves to
`DerivativeWebpWarmer` with args `[@logger.channel.image_styles_generator, @webp.webp]`.
(The submodule's own `*.services.yml` also declares an
`image_styles_generator_webp.derivative_webp_warmer` definition, but the override of the
parent service is what the Drush command consumes.)

## The subclass

`DerivativeWebpWarmer extends DerivativeWarmer`:

```php
public function regenerateImageStyleDerivativeFromFile($image_style, $file): string {
  $derivative_uri = parent::regenerateImageStyleDerivativeFromFile($image_style, $file);
  $this->webp->createWebpCopy($derivative_uri);   // writes <derivative>.webp
  return $derivative_uri;
}
```

## Consequence for an agent

- Enable the submodule (`drush en image_styles_generator_webp -y`) and rebuild the container.
  From then on `drush image:derive:multiple` writes both the normal derivative and a WebP copy.
- No command flags change; there is nothing to configure.
- Requires the contrib `webp` module (provides the `webp.webp` service); it is a hard
  dependency in `*.info.yml`.
