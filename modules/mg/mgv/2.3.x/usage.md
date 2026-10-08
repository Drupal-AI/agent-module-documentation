<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
More Global Variables (mgv) exposes a set of ready-made values — current path, page title, language, site info, social-sharing URLs — as a `global_variables` object printable in **any** Twig template without writing a preprocess function.

---

The module implements `hook_template_preprocess_default_variables_alter()` to add a single `global_variables` variable to every template, populated by a custom plugin type. Each value is a **GlobalVariable plugin** (attribute `#[Variable('id')]`, discovered in `Plugin/GlobalVariable`, managed by `MgvPluginManager`) that returns its value from `getValue()`. Plugin ids containing a backslash (e.g. `social_sharing\facebook`) become nested keys, so `{{ global_variables.social_sharing.facebook }}` works. Plugins can declare `variableDependencies` on other variables (their resolved values are injected), implement `ContextAwarePluginInterface` for route/entity context (e.g. current node), and return a `CacheableMetadata` from `getCacheMetadata()` so cache contexts/tags/max-age bubble correctly during rendering (e.g. `current_path` adds the `url` context). The module has no configuration, no permissions, and no services beyond the plugin manager and hook classes. It is easily extended: add your own `#[Variable]` plugin class in any module. Requires no contrib dependencies (Drupal 10.3+/11/12).

---

- Print the current page title in `breadcrumb.html.twig` as the last crumb.
- Show the site name in a footer copyright line (`{{ global_variables.site_name }}`).
- Output the site slogan or site mail in a template.
- Render the site logo URL (`{{ global_variables.logo }}`).
- Get the current path for a form `?destination={{ global_variables.current_path }}`.
- Get the current path alias (`{{ global_variables.current_path_alias }}`).
- Print the site base URL (`{{ global_variables.base_url }}`).
- Show the current interface langcode (`{{ global_variables.current_langcode }}`).
- Show the current language's human name (`{{ global_variables.current_langname }}`).
- Build a Facebook share link for the current page.
- Build an X/Twitter share link for the current page.
- Build a LinkedIn share link for the current page.
- Build a WhatsApp share link for the current page.
- Build a mailto: share link with the page title as subject.
- Print the raw (unrendered) page title via `raw_current_page_title` when you need the title object.
- Avoid writing preprocess hooks just to expose a common value to Twig.
- Use a global variable inside any template — html, page, node, field, region, block.
- Add a custom global variable (e.g. current node title) by writing a `#[Variable]` plugin.
- Chain variables with `variableDependencies` (e.g. a share URL built from base_url + path + title).
- Provide correct cache metadata for a custom variable so render cache stays valid.
- Access route/entity context in a variable via `ContextAwarePluginInterface`.
- Give themers site-info values without granting config access.
- Reuse the same variable across many templates consistently.
- Compose share buttons in a theme without a social-sharing contrib module.
