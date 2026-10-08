<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Snippet Manager (snippet_manager) — agent index

Manages reusable code **snippets** as config entities (`snippet`). A snippet is a **Twig template**
(plus optional CSS, JS, and named **variables**) that renders through Drupal's `inline_template`
render element. Each snippet can be exposed as: a **page** (own path + access rules, added by a route
subscriber), a **block** (`snippet` block deriver), a **display variant** (`snippet_display_variant`),
a **layout** (`snippet_layout`, needs `layout_discovery`), a `[snippet:ID]` **text-format filter**, or
embedded inside another snippet via the `snippet('id', {...})` **Twig function**. Variables are
`SnippetVariable` plugins (render an entity, a view, a block, a menu, formatted text, a file, a nested
"mini snippet", etc.) whose build results become Twig context keys. The full CRUD/editing UI lives at
`/admin/structure/snippet` (entity `configure` route `entity.snippet.collection`).

Snippet templates are compiled as **Twig via core's `inline_template`** (this is the standard,
non-sandboxed Twig environment — the same one theme templates use). Authoring/editing a snippet
therefore requires the **restrict-access** permission **`administer snippets`**; treat it as
equivalent to editing theme templates or running arbitrary PHP, and grant it only to trusted
developers/site builders, **never** to content editors. See [permissions/index.md](permissions/index.md).

- Depends on: `drupal:filter`, `drupal:file`, `codemirror_editor:codemirror_editor`.
- Core: `^10.3 || ^11.0`. PHP: `8.1`. Package: none set. License: GPL-2.0-or-later.
- Config entity type `snippet` (prefix `snippet`, `admin_permission = administer snippets`); provides
  **config schema**, **one permission** (`administer snippets`, restrict access), **no drush**.
- Settings/collection route: `entity.snippet.collection` (`/admin/structure/snippet`).
- Defines **one plugin type**: `SnippetVariable` (manager `plugin.manager.snippet_variable`).

## What you'd do → where

- **Create/configure a snippet — template, page, block, layout, variant, CSS/JS, variables** →
  [configure/snippets.md](configure/snippets.md)
- **Understand the permission, page access model, and trust boundary** →
  [permissions/index.md](permissions/index.md)
- **Render a snippet from code / a Twig template / a text field; hooks; the `SnippetVariable` API** →
  [api/index.md](api/index.md)
- **Add a new variable type (custom `SnippetVariable` plugin) or list the built-in ones** →
  [plugins/snippet-variable.md](plugins/snippet-variable.md)

## Key facts (real machine names)

- Config entity: `snippet` (`Drupal\snippet_manager\Entity\Snippet`). Handlers: view_builder
  `SnippetViewBuilder`, list_builder `SnippetListBuilder`, access `SnippetAccessControlHandler`, forms
  `add`/`edit` (`GeneralForm`), `delete`, `duplicate` (`DuplicateForm`), `template_edit`
  (`TemplateForm`), `css_edit` (`CssForm`), `js_edit` (`JsForm`), `variable_add`/`variable_edit`/
  `variable_delete`.
- Config keys (config_export): `page{status,title,path,display_variant,theme,access{type,permission,role}}`,
  `block{status,name}`, `display_variant{status,admin_label}`, `layout{status,label,default_region}`,
  `template{value,format}`, `css{status,preprocess,value,group}`, `js{status,preprocess,value}`,
  `variables[]{plugin_id,configuration}`.
- Routes (all `_permission: administer snippets`; enable/disable also `_csrf_token: TRUE`):
  `entity.snippet.collection` `/admin/structure/snippet`, `.canonical` `/{snippet}`, `.source`
  `/{snippet}/source`, `.add_form` `/add`, `.edit_form` `/{snippet}/edit`, `.template_edit_form`
  `…/edit/template`, `.css_edit_form` `…/edit/css`, `.js_edit_form` `…/edit/js`, `.delete_form`,
  `.duplicate_form`, `.enable`, `.disable`, `snippet_manager.variable_add_form`/`_edit_form`/
  `_delete_form`, `snippet_manager.path_autocomplete`. Snippet **pages** get dynamic routes named
  `entity.snippet.page.<id>` (see `RouteSubscriber`).
- Services: `plugin.manager.snippet_variable` (`SnippetVariablePluginManager`), `twig.loader.snippet`
  (`SnippetTemplateLoader`, tag `twig.loader` priority `-150`, resolves `@snippet/<id>` templates),
  `snippet_manager.twig_extension` (`SnippetManagerTwigExtension`, adds Twig function `snippet`),
  `theme.negotiator.snippet_manager`, `snippet_manager.route_subscriber` (`RouteSubscriber`),
  `snippet_manager.display_variant_subscriber`, `snippet_manager.snippet_library_builder`
  (`SnippetLibraryBuilder`, writes per-snippet CSS/JS to `public://` and builds
  `snippet_manager/snippet_<id>` libraries), `logger.channel.snippet_manager`.
- Plugin type `SnippetVariable`: annotation `Drupal\snippet_manager\Annotation\SnippetVariable`,
  interface `SnippetVariableInterface`, base `SnippetVariableBase`, dir `Plugin/SnippetVariable`, alter
  hook `snippet_variable_info`, cache key `snippet_variable_plugins`. Built-in ids: `block`,
  `condition`, `display_variant:main_content`, `display_variant:title`, `entity`, `entity_form`,
  `file`, `form`, `layout_region`, `menu`, `mini_snippet`, `text`, `url`, `view`.
- Other plugins: Block `snippet` (deriver `SnippetBlockDeriver`); Filter `snippet_manager_snippet`
  (token `[snippet:ID]`); Layout `snippet_layout` (deriver `SnippetLayoutDeriver`, theme hook
  `snippet_layout`, template `snippet-layout.html.twig`); DisplayVariant `snippet_display_variant`
  (deriver `SnippetDisplayVariantDeriver`); legacy CKEditor 4 plugin `snippet_manager_snippet`
  (config schema `ckeditor.plugin.snippet_manager_snippet`).
- Twig: function `snippet(id, context = {})` renders a snippet (access-checked); template namespace
  `@snippet/<id>` resolvable via `include`/`embed`.
- Hooks implemented: `hook_library_info_build`, `hook_theme` (`snippet_layout`),
  `hook_entity_create`/`_update`/`_delete` (clears variable plugin cache for block/menu/view),
  `hook_codemirror_mode_info_alter`. Hooks provided: `hook_snippet_view_alter`,
  `hook_snippet_variable_info_alter`; deprecated: `hook_snippet_context`, `hook_snippet_context_alter`.
- Libraries: `snippet_manager/editor`, `snippet_manager/listing`, `snippet_manager/html_source`, plus
  dynamic `snippet_manager/snippet_<id>` for snippets with CSS/JS enabled.
