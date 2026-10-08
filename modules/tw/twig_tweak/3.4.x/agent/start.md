# twig_tweak — agent start

Registers one Twig extension (`Drupal\twig_tweak\TwigTweakExtension`, tagged `twig.extension`)
adding ~20 functions and ~18 filters for rendering Drupal content inline in templates. No config
UI, no permissions, no config schema. Just enable and use in any `*.html.twig`.

- Twig functions (drupal_view, drupal_block, drupal_entity, drupal_field, …) → [theming/functions.md](theming/functions.md)
- Twig filters (image_style, token_replace, view, with, file_url, …) → [theming/filters.md](theming/filters.md)
- Add your own functions/filters/tests via alter hooks → [hooks/hooks.md](hooks/hooks.md)
- Drush commands to debug/validate Twig → [drush/commands.md](drush/commands.md)
- View-builder services behind the functions → [api/services.md](api/services.md)
