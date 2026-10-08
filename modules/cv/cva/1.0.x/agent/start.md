# cva — agent index

CVA registers Twig's `html_cva` function (from `twig/html-extra`) in Drupal and lets you
call methods on the returned object inside the Twig sandbox. No admin UI, no config, no
permissions, no Drush. You enable it (`drush en cva`) and use the function in templates.

- **Use `html_cva` in a template** (base, variants, default_variant, compound_variants, apply, tailwind_merge): [theming/html-cva.md](theming/html-cva.md)
- **How it works / what it changes** (decorated twig service, sandbox policy, why `.apply()` is allowed): [extend/twig-decoration.md](extend/twig-decoration.md)
