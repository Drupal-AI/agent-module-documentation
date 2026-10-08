# twig_vardumper — agent index

Twig VarDumper registers a Twig extension (`Drupal\twig_vardumper\TwigExtension`) that adds two
functions, `dump()` and `vardumper()`, both backed by Symfony VarDumper. They render a rich,
collapsible `sf-dump` widget for any variable — **but only when Twig debug is enabled**; with
debug off they return `FALSE` and emit nothing. No admin UI, no config, no permissions, no Drush.
Enable it (`drush en twig_vardumper`), turn on Twig debug, and call the function in a template.

- **Use `dump()` / `vardumper()` in a template** (signatures, the debug requirement, examples): [theming/dump-functions.md](theming/dump-functions.md)
- **How it works / render programmatically** (the extension, VarDumper dependency, `renderInline` from PHP): [api/twig-extension.md](api/twig-extension.md)
