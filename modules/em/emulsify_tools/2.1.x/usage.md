<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Emulsify Tools is a toolset for Emulsify-based Drupal theming: Twig helper functions (`bem()`, `add_attributes()`, and a `switch`/`case` tag), theme-defined Twig namespaces, Drush commands to generate Emulsify child themes, and Drush commands to deploy Emulsify 7.x generated favicon packages.

---

The module registers three Twig extensions: `bem()` builds BEM class names/attribute objects (`bem('title', ['small','red'], 'card')` → `card__title card__title--small card__title--red`), `add_attributes()` merges an attribute map into the current template attributes without leaking into child includes, and a `{% switch %}/{% case %}/{% default %}` tag for Twig. It adds a high-priority Twig loader (`ThemeNamespaceLoader` + `ThemeNamespaceRegistry`) that resolves Symfony-style namespaces declared in a theme's `.info.yml` under `components.namespaces` (same structure as the Components module), searched across the active theme, its base themes, and the default frontend theme, so templates can be referenced as `@atoms/button/button.twig`. Its Drush commands (Drush 13+) include `emulsify_tools:bake` (alias `emulsify`) to generate an Emulsify child theme under `themes/custom/<name>`, plus favicon deployment commands `emulsify_tools:favicon-generate`, `emulsify_tools:favicon-status`, `emulsify_tools:favicon-reset` (regenerate/inspect/reset a theme's generated favicon package from saved Emulsify 7.x theme settings) and `emulsify_tools:repair-favicon-config` (backfill favicon install/schema files in older Emulsify child themes). It stores one config object, `emulsify_tools.settings`, with `admin_theme_favicon_themes` — the list of themes whose generated favicon package should also apply on admin pages (a `hook_form_system_theme_settings_alter` toggle + `page_attachments_alter`). It has no configure route, no permissions of its own, and no plugin types. The favicon features pair with the Emulsify Drupal 7.x companion theme; the Twig helpers and child-theme generator are useful on their own.

---

- Generate an Emulsify child theme with `drush emulsify_tools:bake MyTheme` (or `drush emulsify MyTheme`).
- Print BEM class names in a template with `{{ bem('title') }}` → `class="title"`.
- Add BEM modifiers: `{{ bem('title', ['small','red']) }}` → `title title--small title--red`.
- Build element-scoped BEM classes: `{{ bem('title', [], 'card') }}` → `card__title`.
- Append non-BEM utility classes: `{{ bem('title', '', '', ['js-click']) }}`.
- Merge extra attributes safely with `{{ add_attributes({class: ['foo','bar'], 'data-x': 'y'}) }}`.
- Combine `bem()` output into `add_attributes()` for one attribute object on an element.
- Use `{% switch field.value %}{% case 'image' %}…{% default %}…{% endswitch %}` inside Twig.
- Register component Twig namespaces in a theme's info.yml under `components.namespaces` (e.g. `atoms: components/01-atoms`).
- Reference component templates as `@atoms/button/button.twig` across active/base/default themes.
- Resolve a namespaced template by basename, e.g. `@atoms/button.twig` when uniquely named.
- Point a namespace at an app-root path (leading `/`) or a theme-relative path.
- Deploy a generated favicon package after config import with `drush emulsify_tools:favicon-generate my_theme`.
- Check favicon package/dependency/source status with `drush emulsify_tools:favicon-status my_theme`.
- Remove generated favicon package state with `drush emulsify_tools:favicon-reset my_theme`.
- Backfill favicon install/schema files in older Emulsify child themes with `drush emulsify_tools:repair-favicon-config`.
- Also apply a theme's generated favicon on admin pages by adding it to `admin_theme_favicon_themes`.
- Backfill new favicon theme-setting keys on existing Emulsify themes via the module's post-update + `drush updatedb`.
- Keep favicon package files consistent across environments by regenerating from saved portable SVG config.
- Standardise BEM class output across an Emulsify design system without hand-writing class strings.
- Share component libraries between themes via namespaces instead of copying templates.
- Scaffold a new Emulsify 6.x child theme quickly for a new project.
