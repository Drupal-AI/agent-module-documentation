<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a rich-text (Twig) editor to menu links so administrators can render custom HTML/Twig markup for a menu item.

---

`hook_form_menu_link_content_form_alter()` (`menu_twig.module`) adds a 'Menu Twig' details group with an `is_override` checkbox and a `menu_twig_text` `text_format` (WYSIWYG) element; a submit handler stores both under the link entity's `options['menu_twig']`. Rendering happens through a replacement Twig `link()` function provided by `MenuTwigExtension` (`src/Twig/MenuTwigExtension.php`, service `menu_twig.twig_extension`): in `getLink()`, when a link carries `menu_twig_text`, it calls `TwigEnvironment::renderInline(html_entity_decode($value))` with `title`/`url`/`attributes` context, then runs the result through `check_markup($html, $format)`; if `is_override` is set it returns the markup instead of the standard link. Two `access content` AJAX routes (`menu_twig.modal`, `menu_twig.examples`) open modals listing available Twig filters/functions and examples (read-only helper content). **Security:** the `menu_twig_text` value is executed as a Twig template (`renderInline`) - this is server-side template execution by design, but it means anyone who can edit menu links (core `administer menu`, a restricted admin permission) can run arbitrary Twig/PHP. Treat `administer menu` as a trusted, admin-only permission on sites using this module; do not grant it to semi-trusted editors.

---

- Render custom HTML markup for a specific menu item (e.g. a badge, icon, or promo).
- Use Twig logic/filters/functions inside a menu link's rendered output.
- Fully override a menu link's markup via the `is_override` option.
- Insert dynamic content into navigation using the `title`, `url` and `attributes` context.
- Provide editors a WYSIWYG field to author menu snippets.
- Browse available Twig filters/functions from an in-form modal helper.
- View sample Twig snippets via the examples modal.
- Add attributes/classes to menu links through Twig.
- Combine with text formats so output is filtered by `check_markup` after rendering.
- Build mega-menu style entries with custom markup.
- Keep the snippet stored in the link entity's `options` (no extra storage).
- Target Drupal 10 (`core_version_requirement: ^10`); requires core `link`.
- Restrict authoring to trusted menu administrators only (SSTI surface).
- Render icons or images inside menu items without theme overrides.
- Conditionally hide/show a menu item using Twig logic.
- Prototype navigation markup without editing templates.
