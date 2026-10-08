<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# External Links In New Tab (external_links_new_tab) — agent index

Adds `target="_blank"` + `rel="noopener"` to every external link Drupal renders. Zero configuration, no permissions, no config, no dependencies. The entire module is one hook (`link_alter`) plus a `help` page. Core `^10.1 || ^11 || ^12`, package unset.

Key facts:
- Implements `hook_link_alter()` in `src/Hook/ExternalLinksNewTabHooks.php` (`#[Hook('link_alter')]`, autowired service).
- Logic: `if ($variables['url']->isExternal()) { $variables['options']['attributes']['target'] = '_blank'; $variables['options']['attributes']['rel'] = 'noopener'; }`.
- Applies to links passing through Drupal's link/theme layer: menu links, `#type => 'link'` elements, rendered link fields, `Link::toString()`. Does NOT touch raw `<a>` tags in body HTML, block markup, or Twig templates.
- `configure` is null — nothing to set up. Just enable it.
- To change the behavior (e.g. also add `noreferrer`, or exclude some domains), implement your own `hook_link_alter()` in a custom module; alter hooks run in module-weight order so you can adjust `$variables['options']['attributes']` after this module.
- Also implements `hook_help()` (`help.page.external_links_new_tab`). No routes, no forms, no services beyond the autowired hook class, no drush, no plugin types. **No security surface** — no user input, no routes, no output beyond an attribute on already-sanitized link markup.
