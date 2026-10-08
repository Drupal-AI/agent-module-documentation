<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap language-switcher block

Class `Drupal\bootstrap_flag_icons\Plugin\Block\BootstrapFlagIconsBlock` (block id `bootstrap_flag_icons_block`), which **extends core `Drupal\language\Plugin\Block\LanguageBlock`**. It reuses core's language-link generation and only re-themes the output as a Bootstrap 5 dropdown with flags.

## Enable and place

1. Enable the module (`drush en bootstrap_flag_icons`) — core **language** must be enabled and more than one language configured, or the block produces no links.
2. Place the **"Bootstrap Language switcher"** block via Block Layout (`admin/structure/block`). A derivative exists per configurable language type (interface / content / URL), labelled `Bootstrap Language switcher (<type>)`; when only one type is configurable it is simply "Bootstrap Language switcher" (see `src/Plugin/Derivative/BootstrapFlagIconsBlock.php`, which builds derivatives from `LanguageManagerInterface::getLanguageTypes()`).

## Block configuration

`blockForm()` adds a **"Bootstrap settings"** details group with one select, `dropdown_style`:
- `all` — "Icons and text" (default)
- `icons` — "Only icons"

Saved into `$this->configuration['bootstrap_language']['dropdown_style']` by `blockSubmit()`.

## Rendering

`build()` calls `parent::build()` (core language links), then:
- sets `#theme` to `links__bootstrap_flag_icons_block`;
- stamps each link's `attributes['data-mode']` with the chosen `dropdown_style`;
- adds classes `dropdown` and `<style>-dropdown-style` (e.g. `icons-dropdown-style`) to the wrapper;
- attaches library `bootstrap_flag_icons/bootstrap_flag_icons` (which pulls in `bootstrap_flag_icons/flag-icons`, the CDN CSS from `//cdn.jsdelivr.net/gh/lipis/flag-icons/...`).

`bootstrap_flag_icons_preprocess_links__bootstrap_flag_icons_block()` in the `.module` file sets `current_language` and builds a `languages` array; when a link's `data-mode` is not `icons` it keeps the language title text (via `t('@link', …)`), so icon-only mode drops the labels.

## Template

`templates/links--bootstrap-flag-icons-block.html.twig` renders a `<button class="btn dropdown-toggle" data-bs-toggle="dropdown">` showing `<i class="fi fil-{{ current_language }}">` (or `<i class="bi bi-globe2">` as fallback), and a `<ul class="dropdown-menu">` of `<a class="dropdown-item" href="{{ language.url.toString }}"><i class="fi fil-{{ key }}"> {{ language.title }}</i></a>`. All values pass through Twig auto-escaping; flag classes use the `fil-<langcode>` naming from the flag-icons CSS.

## Notes

- The button expects Bootstrap 5 JS (`data-bs-toggle="dropdown"`) present in the theme; the module does not ship Bootstrap itself. `data-toggle` is also emitted for Bootstrap 4 compatibility.
- Flag CSS is loaded from the CDN by the `flag-icons` library; a self-hosted `flags/` SVG set also ships with the module for the CKEditor feature.
