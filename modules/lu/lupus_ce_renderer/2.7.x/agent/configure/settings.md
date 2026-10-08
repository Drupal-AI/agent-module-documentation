# Configuration (no UI): config object + settings.php globals

There is **no settings form** and no `configure` route. Behaviour is controlled by one config object
plus several `settings.php` globals.

## Config object `lupus_ce_renderer.settings`

Schema: `config/schema/lupus_ce_renderer.schema.yml`. Install defaults: `config/install/…settings.yml`.
Edit with drush (`drush config:set …`) or config import — no admin page.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `redirect_response.add_drupal_messages` | boolean | `false` | When `true`, drupal-messages are included in the JSON `redirect` response. Default (`false`) matches SSR behaviour (messages delivered with the next request). Enable for SSG/CSR. `lupus_ce_renderer_update_8001` sets this `TRUE` for installs that predate the setting, preserving old behaviour. |
| `route_layouts` | sequence(layout → [patterns]) | `{}` | Maps a `page_layout` value to route-name patterns. First match wins; a pattern may end in a single `*` wildcard (prefix match). Applied by `RouteLayoutSubscriber` as the route option `_lupus_ce_renderer_layout`, then emitted as the response `page_layout`. Code (or the alter hook) can still override. |

```sh
# Include messages in redirect API responses (SSG/CSR friendly):
drush config:set lupus_ce_renderer.settings redirect_response.add_drupal_messages true
```

```yaml
# route_layouts example — canvas pages render "full":
route_layouts:
  full:
    - 'entity.canvas_page.canonical'
    - 'canvas.editor.*'
```

## settings.php globals

Read via `Settings::get(...)`. All optional.

| Global | Read in | Purpose |
|---|---|---|
| `lupus_ce_renderer_enable` | `CustomElementsRequestSubscriber`, others | **Legacy.** Force the renderer on for the whole site-directory. When set, also add cache context `url.site` to `renderer.config.required_cache_contexts` so cache varies by site. Prefer `?_format=custom_elements` or the request attribute instead. |
| `lupus_ce_renderer_default_format` | `ContentFormatCacheContext` | Default content serialization, `markup` (default) or `json`. Overridden per request by `?_content_format` or the `lupus_ce_renderer.content_format` attribute. |
| `lupus_ce_renderer_redirect_base_url` | `CustomElementsFormatSubscriber` | **Legacy.** Rewrite issued redirect URLs to keep this base URL (for `/api` sub-path setups). |
| `blacklisted_metatags` | `CustomElementsMetatagsGenerator` | **Legacy/undocumented.** Map of `#tag` → attribute-values to suppress from emitted metatags. |

## Enabling per site with a varying cache (from README)

```yaml
# services.yml — required when using $settings['lupus_ce_renderer_enable']:
renderer.config:
  required_cache_contexts: ['languages:language_interface', 'theme', 'user.permissions', 'url.site']
```

The `required_cache_contexts` apply to both regular Drupal rendering and the `custom_elements`
render, which is what keeps per-user/per-context variations cached safely.
