<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GetSitemap tool plugin

Source: `src/Plugin/tool/Tool/GetSitemap.php`. The module's only code.

## Definition (the `#[Tool(...)]` attribute)

- `id: 'ai_tool_get_sitemap'`
- `label: 'Get Sitemap'`, `description: 'Returns the sitemap of the website.'`
- `operation: ToolOperation::Read` — a read-only tool.
- `output_definitions`: one output `sitemap`, a `ContextDefinition(data_type: 'map', ...)`.
- **No input context definitions** — the tool accepts no parameters from the agent.

Class `GetSitemap extends ToolBase implements ContainerFactoryPluginInterface`.

## Install / enable

1. `composer require drupal/ai_tool_get_sitemap` (pulls `drupal/tool` and `drupal/simple_sitemap`).
2. Ensure `ai`, `tool`, and `simple_sitemap` are enabled and Simple XML Sitemap has a configured,
   generated default sitemap (`drush pm:install ai tool simple_sitemap ai_tool_get_sitemap`).
3. The tool then appears to AI agents / the Tool framework as `ai_tool_get_sitemap`. Test it via
   the agent explorer (see the project README).

There is nothing to configure in this module itself — no settings form, route, or config object.

## Dependency injection — `create()`

Builds the instance with `current_user`, then:

```
if ($container->has('simple_sitemap.generator')) {
  $instance->simpleSitemapGenerator = $container->get('simple_sitemap.generator');
} else {
  $instance->simpleSitemapGenerator = NULL;
}
```

So the Simple Sitemap `Generator` is a soft dependency resolved from the container.

## Behavior — `doExecute(array $values)`

- Ignores `$values` (no inputs).
- `$defaultSitemap = $this->simpleSitemapGenerator->getDefaultSitemap();`
- `$variant = $defaultSitemap?->id();` then `setSitemaps($variant === NULL ? NULL : (string) $variant)`.
- `$xmlContent = $sitemap->getContent();` — the XML the Simple Sitemap generator produced for the
  site. `$xmlContentCount = $sitemap->getDefaultSitemap()->getLinkCount();`
- If `$xmlContentCount` is truthy → `ExecutableResult::success('Success retrieving the sitemap.', ['sitemap' => [$xmlContent], 'result' => [$xmlContent]])`.
- Else → `ExecutableResult::failure('Cannot get the sitemap. @error', ...)` with the message
  *"No sitemap available. Please install the Simple XML Sitemap module."*

The returned data is the site's **own locally generated** sitemap XML. The plugin performs no
outbound HTTP request and no XML parsing of remote input.

## Access — `checkAccess()`

```
protected function checkAccess(array $values, ?AccountInterface $account = NULL, $return_as_object = FALSE): bool|AccessResultInterface {
  return $return_as_object ? AccessResult::allowed() : TRUE;
}
```

Access is unconditionally allowed at the plugin level; whether an agent may invoke the tool is
governed by the AI/Tool framework that hosts it. The payload is the public sitemap.

## Operating notes

- **Simple XML Sitemap is effectively required.** If it is absent, the injected generator is NULL
  and the first call in `doExecute()` errors; install and configure `drupal/simple_sitemap` (^4)
  and generate the default sitemap first.
- Only the **default** sitemap variant is returned.
- Output shape: both `sitemap` and `result` keys hold a one-element array containing the XML string.
