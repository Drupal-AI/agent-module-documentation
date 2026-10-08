<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bamboo Twig - Token — agent index

One Twig function to run Drupal **token** replacement from a template. Submodule of **bamboo_twig**;
no config, permissions or Drush.

- **The function, data/options arguments and bracket handling** → [theming/token.md](theming/token.md)

`bamboo_token(token, data = {}, options = {})` — pass the token **without** brackets.
Service `bamboo_twig_token.twig.token`. Enable: `drush en bamboo_twig_token -y`.
