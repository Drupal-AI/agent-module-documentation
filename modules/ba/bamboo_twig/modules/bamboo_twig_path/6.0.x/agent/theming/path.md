<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# bamboo_path_system

`bamboo_path_system(type, name = null)` — class `Path`, service `bamboo_twig_path.twig.path`.
Wraps `extension.path.resolver->getPath(type, name)`.

`type` is one of `core`, `profile`, `module`, `theme`, `theme_engine`. `name` is the machine name
of the item (ignored for `core`). Returns the path relative to the Drupal root, or an empty string
if not found.

```twig
{{ bamboo_path_system('module', 'bamboo_twig') }}   {# modules/contrib/bamboo_twig #}
<img src="/{{ bamboo_path_system('theme', 'olivero') }}/logo.svg">
{{ bamboo_path_system('core') }}                    {# core #}
```

Handy for referencing a shipped asset (image, JS) by module/theme path from a template.
