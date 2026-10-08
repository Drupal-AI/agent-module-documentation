<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — render snippets, hooks, services

## Render a snippet from code

```php
$snippet = \Drupal::entityTypeManager()->getStorage('snippet')->load('my_id');
$build = \Drupal::entityTypeManager()->getViewBuilder('snippet')->view($snippet);
// Optional signature: ->view($snippet, $view_mode = 'full', $langcode = NULL, array $context = []);
$html = \Drupal::service('renderer')->render($build);
```

`SnippetViewBuilder::view()` (`src/SnippetViewBuilder.php`) is the single render entry point. It only
implements `view()`; `viewMultiple()`, `viewField()`, `viewFieldItem()`, `buildComponents()` all throw
`\LogicException`. View mode `source` returns the rendered HTML inside a read-only CodeMirror textarea
plus a render-time readout. `$context` passed in takes precedence over the snippet's own variables and
the default context keys.

## Render from a Twig template

- Function: `{{ snippet('my_id', { key: value }) }}` — `SnippetManagerTwigExtension` loads the snippet,
  checks `->access('view')` (throws `RuntimeException` if denied), and renders it with the extra
  context merged in.
- Namespace: `{% include '@snippet/my_id' %}` / `{% embed %}` — `SnippetTemplateLoader` (Twig loader,
  priority `-150`) resolves `@snippet/<id>` to `check_markup(template.value, template.format)`, gated by
  `$snippet->access('view')`.

## Render from a text field

Enable the **Snippet** filter (`snippet_manager_snippet`, `src/Plugin/Filter/Snippet.php`) on a text
format. Then `[snippet:ID]` tokens in that field are replaced by the rendered snippet
(`preg_replace_callback('/\[snippet:([a-z0-9_]+)\]/', …)`). A missing snippet is logged and replaced
with an empty string.

## Hooks

Current (`snippet_manager.api.php`):

- `hook_snippet_view_alter(array &$build, SnippetInterface $snippet, $view_mode)` — alter the render
  array. Invoked as the `snippet_view` alter in `SnippetViewBuilder::view()`.
- `hook_snippet_variable_info_alter(array &$info)` — alter `SnippetVariable` plugin definitions
  (`plugin.manager.snippet_variable` alter id `snippet_variable_info`).

Deprecated (still invoked): `hook_snippet_context(SnippetInterface $snippet)` and
`hook_snippet_context_alter(array &$context, SnippetInterface $snippet)` — replaced by
`hook_snippet_view_alter()`.

## The `SnippetVariable` plugin API

See [../plugins/snippet-variable.md](../plugins/snippet-variable.md). Manager
`plugin.manager.snippet_variable`; a snippet's active plugins are iterated via
`$snippet->getPluginCollection()` (returns a `SnippetVariableCollection`). Each plugin's `build()`
render array becomes the Twig context entry named after the variable; cacheable plugins have their
metadata bubbled onto the snippet build.

## Services (machine names)

- `plugin.manager.snippet_variable` — `SnippetVariablePluginManager`.
- `twig.loader.snippet` — `SnippetTemplateLoader` (`@snippet/<id>` templates).
- `snippet_manager.twig_extension` — `SnippetManagerTwigExtension` (Twig function `snippet`).
- `snippet_manager.snippet_library_builder` — `SnippetLibraryBuilder` (per-snippet CSS/JS libraries via
  `hook_library_info_build`, files under `public://snippet/`).
- `snippet_manager.route_subscriber` — `RouteSubscriber` (builds `entity.snippet.page.<id>` routes).
- `snippet_manager.display_variant_subscriber` — `DisplayVariantSubscriber`.
- `theme.negotiator.snippet_manager` — `Theme\Negotiator` (applies a snippet page's chosen theme).
- `logger.channel.snippet_manager` — logger channel.

## Entity API notes

`Snippet` (`ConfigEntityBase`) exposes `getVariable/setVariable/removeVariable/variableExists`,
`getLayoutRegions()`, `getPluginCollection()`. `postSave()` rebuilds the router and clears block /
layout / display-variant caches when the relevant config changed, and calls
`SnippetLibraryBuilder::updateAssets()`. `calculateDependencies()` adds the template's filter format,
the page theme, and each variable plugin's dependencies.
