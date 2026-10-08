# Unified Twig Extensions — agent index

Auto-loads PHP-defined **Twig functions / filters / tags** from the **default theme's**
`_twig-components` folders, so a Pattern Lab theme's Twig extensions also work in Drupal. No config,
no permissions, no Drush, no plugins, no configure route. Enable it and it works.

Core facts:
- One service: `newcity_twig.twig_extension` (class `ExtensionAdapter`, tagged `twig.extension`).
- On Twig init it scans **`<default_theme>/*/_twig-components/{functions,filters,tags}/`**
  (one directory level below the theme, e.g. `<theme>/source/_twig-components/functions/`).
- Default theme comes from `system.theme:default` — the path is hard-coded to the default theme.
- Includes every `*.php` there except names starting with `.`, `_`, or `pl_`.

Docs:
- **File conventions (`$function`/`$filter`/`Project_NAME_TokenParser`), scan path, load rules,
  the service, and gotchas** → [api/mechanism.md](api/mechanism.md)
