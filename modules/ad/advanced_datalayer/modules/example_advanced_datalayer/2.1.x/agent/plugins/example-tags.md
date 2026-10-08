# Example tags & groups

Concrete plugins for `advanced_datalayer`. Discovered by the base module's managers
(`plugin.manager.advanced_datalayer.tag` / `.group`) from
`src/Plugin/AdvancedDatalayer/{Tag,Group}/`.

## Groups (`@AdvancedDatalayerGroup`)

| Group id | Label |
|---|---|
| `site_Information` | Site Information Group |
| `page_Information` | Page Information Group |

(The core `root` group is provided by the base module.)

## Tags (`@AdvancedDatalayerTag`)

| Tag id | Group | Notes |
|---|---|---|
| `event` | `root` | Top-level `event` variable (`global`, `required`, `show_empty` true). |
| `site_Name` | `site_Information` | Global site name. |
| `site_Category` | `site_Information` | Global site category. |
| `ga_client_id` | `site_Information` | GA client id (filled client-side via the example JS). |
| `page_Name` | `page_Information` | Per-page name (often a token like `[node:title]`). |
| `page_Category` | `page_Information` | Per-page category. |
| `response_Code` | `page_Information` | HTTP status (200/403/404). |

All tag classes extend `\Drupal\advanced_datalayer\Plugin\AdvancedDatalayer\Tag\DatalayerNameBase`
and are essentially metadata-only placeholders — the runtime value comes from
`advanced_datalayer_defaults` config (or an entity field), not the class.

## Using them

Assign values by tag id in a page context, e.g. the `node` context:

```php
$d = \Drupal::entityTypeManager()->getStorage('advanced_datalayer_defaults')->load('node');
$d->set('tags', ['page_Name' => '[node:title]', 'event' => 'pageview'])->save();
```

See `modules/advanced_datalayer/2.1.x/agent/configure/defaults.md` for the full config model.

## As a template

Copy a class like `Tag/PageCategory.php` (annotation `id`, `label`, `group`, `weight`, flags)
into your own module's `Plugin/AdvancedDatalayer/Tag/` to define a bespoke variable; copy a
`Group/*.php` for a new group. Then `drush cr`. Authoring detail:
`modules/advanced_datalayer/2.1.x/agent/plugins/tags-and-groups.md`.

## Client-side values

`example_advanced_datalayer_page_attachments()` attaches `js/example_advanced_datalayer.js`
(weight -95) when `getGlobalDatalayerTags()` is non-empty and the route is supported, so values
that only exist in the browser (device type, GA client id) can be added to the dataLayer.
