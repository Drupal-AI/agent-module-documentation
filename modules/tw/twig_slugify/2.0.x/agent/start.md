# Twig Slugify — agent index

Adds one `slugify` Twig filter backed by `cocur/slugify`. No config UI, permissions, schema, or Drush.
Requires the `cocur/slugify` `^4.0` library.

- **The `slugify` filter, its options, and how it's registered** → [theming/filter.md](theming/filter.md)

Key facts:
- Twig extension `Drupal\twig_slugify\SlugifyTwigExtension` (service `twig_slugify.slugify`, tag
  `twig.extension`) in `twig_slugify.services.yml`.
- Usage: `{{ 'Some Title'|slugify }}` -> `some-title`; optional options array as the 2nd arg.
