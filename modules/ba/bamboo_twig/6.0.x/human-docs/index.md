# Bamboo Twig — manual setup guide

**Bamboo Twig** (`bamboo_twig`) is a collection of Twig extensions that add handy
functions and filters you can call directly from your `.html.twig` templates —
rendering blocks, regions, entities, fields, forms, menus and views; reading
config, state and `settings.php`; checking permissions and roles; formatting
dates; and working with files, paths and tokens. It is a theming and developer
tool, not something with an end-user interface.

The project is deliberately split into a lightweight **parent module** plus
**nine topic submodules** that you enable à la carte. The parent module on its own
registers **no** Twig function — its only job is a shared base service that lazily
resolves Drupal services, so a service is only instantiated when a template
actually calls a function that needs it. Each submodule adds one group of
functions. Enable just the groups you use to keep the Twig runtime lean.

There is **no configuration UI, no permissions, and no Drush** — once a submodule
is enabled its functions are available in any template. For example, with the
*Loader* submodule enabled you can drop `{{ bamboo_render_block('mymodule_hello')
}}` into a template, or with the *Security* submodule check
`{% if bamboo_has_role('editor') %}`.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the full catalogue of
every function and its signature — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable only the submodules whose functions you need.

## How to use it

Bamboo Twig is used from templates, so the workflow is: enable the submodule that
provides the function you want, then call the function in a `.html.twig` file. The
submodules and the functions they add are:

| Submodule | Machine name | Adds (examples) |
|-----------|--------------|-----------------|
| **Loader** | `bamboo_twig_loader` | `bamboo_render_block`, `bamboo_render_region`, `bamboo_render_entity`, `bamboo_render_field`, `bamboo_render_form`, `bamboo_render_menu`, `bamboo_render_views`, `bamboo_render_image(_style)`, and `bamboo_load_*` loaders |
| **Config** | `bamboo_twig_config` | `bamboo_config_get`, `bamboo_settings_get`, `bamboo_state_get` |
| **Security** | `bamboo_twig_security` | `bamboo_has_permission(s)`, `bamboo_has_role(s)` |
| **i18n** | `bamboo_twig_i18n` | `bamboo_i18n_current_lang`, `bamboo_i18n_format_date`, `bamboo_i18n_get_translation` |
| **Token** | `bamboo_twig_token` | `bamboo_token` |
| **File** | `bamboo_twig_file` | `bamboo_file_url_absolute`, `bamboo_file_extension_guesser` |
| **Path** | `bamboo_twig_path` | `bamboo_path_system` |
| **Cacheable** | `bamboo_twig_cacheable` | `bamboo_attach_cacheable_metadata` |
| **Extensions** | `bamboo_twig_extensions` | Twig-Extensions Text/Date/Array filters (truncate, time diff, shuffle) |

For example, to render a block by its plugin id from a template, enable the Loader
submodule and write:

```twig
{{ bamboo_render_block('mymodule_hello') }}
```

The full list of functions, arguments, and return values for each submodule is in
the [`agent/`](../agent/theming/functions.md) catalogue.

## Where it lives in the admin menu

Nowhere — Bamboo Twig has no admin pages, no settings form, and no permissions.
You manage it only through which modules are enabled (**Extend**,
`/admin/modules`) and use it entirely from your templates.
