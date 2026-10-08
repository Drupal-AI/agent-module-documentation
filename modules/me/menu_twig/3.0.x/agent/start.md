<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Twig - agent index

Attaches a Twig/HTML snippet to a menu link, rendered via a custom Twig `link()` function. Requires core
`link`; targets Drupal 10. No permissions of its own; authoring rides core `administer menu`.

Key files:
- `menu_twig.module` `hook_form_menu_link_content_form_alter()` adds `is_override` + `menu_twig_text`
  (text_format), stored in link `options['menu_twig']`.
- `src/Twig/MenuTwigExtension.php` `getLink()` runs `TwigEnvironment::renderInline(html_entity_decode(value))`
  then `check_markup($html,$format)`; returns raw markup when `is_override`.
- Routes `menu_twig.modal` / `menu_twig.examples` (perm `access content`) = read-only filter/example modals.

SECURITY: `menu_twig_text` is executed as Twig (SSTI by design). Only `administer menu` (restricted admin)
can author it - do not grant to untrusted editors. Version dir `3.0.x`.
