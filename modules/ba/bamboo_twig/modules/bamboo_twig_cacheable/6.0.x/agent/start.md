<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bamboo Twig - Cacheable — agent index

One Twig function to attach cacheable metadata (cache **tags/contexts/max-age**) to the response
straight from a template. Submodule of **bamboo_twig**; no config, no permissions, no Drush.

- **The function, its argument shape and filtering behaviour** → [theming/cacheable.md](theming/cacheable.md)

Function: `bamboo_attach_cacheable_metadata(cacheable_metadata)`. Service
`bamboo_twig_cacheable.twig.bubble_metadata`. Enable: `drush en bamboo_twig_cacheable -y`.
