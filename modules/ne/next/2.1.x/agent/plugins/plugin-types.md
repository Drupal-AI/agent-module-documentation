<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Next.js — plugin types

The module **defines four plugin types**, each with a manager service, an interface, a base class, an
annotation, and a `Plugin/Next/<Type>` discovery directory. All are annotation-based (`@SiteResolver`,
etc.).

| Plugin type id | Manager service | Annotation | Directory | Built-in plugins |
|---|---|---|---|---|
| `site_resolver` | `plugin.manager.next.site_resolver` | `@SiteResolver` | `Plugin/Next/SiteResolver` | `site_selector`, `entity_reference_field` |
| `site_previewer` | `plugin.manager.next.site_previewer` | `@SitePreviewer` | `Plugin/Next/SitePreviewer` | `iframe` |
| `preview_url_generator` | `plugin.manager.next.preview_url_generator` | `@PreviewUrlGenerator` | `Plugin/Next/PreviewUrlGenerator` | `simple_oauth` (`jwt` in next_jwt) |
| `revalidator` | `plugin.manager.next.revalidator` | `@Revalidator` | `Plugin/Next/Revalidator` | `path`, `cache_tag` |

Alter hooks: `hook_next_site_resolver_info_alter`, `hook_next_site_previewer_info_alter`,
`hook_next_preview_url_generator_info_alter`, `hook_next_revalidator_info_alter`.

## site_resolver — which Next.js site(s) an entity belongs to

Interface `SiteResolverInterface::getSitesForEntity(EntityInterface): NextSiteInterface[]`.
Base: `SiteResolverBase` / `ConfigurableSiteResolverBase`.

- **`site_selector`** — you pick the sites manually; config `{ sites: [<next_site id>, …] }`.
- **`entity_reference_field`** — resolves the site from an entity reference field; config
  `{ field_name: <field> }`.

Configured per `next_entity_type_config` (`site_resolver` + `configuration`).

## site_previewer — how Drupal renders the decoupled preview

Interface `SitePreviewerInterface::render($sites, $entity, ...)`. Base
`ConfigurableSitePreviewerBase`.

- **`iframe`** — embeds the front end in an iframe on the entity page; config `{ width, sync_route,
  sync_route_skip_routes }`. Emits `hook_next_site_preview_alter` (see
  [../hooks/preview-alter.md](../hooks/preview-alter.md)). Global choice in `next.settings.site_previewer`.

## preview_url_generator — builds the secure preview URL

Interface `PreviewUrlGeneratorInterface` (`generate()`, `validate()`, `getScopes()`). Base
`ConfigurablePreviewUrlGeneratorBase`.

- **`simple_oauth`** — role-based access via OAuth scopes; config `{ secret_expiration: <minutes> }`.
- **`jwt`** (next_jwt submodule) — user-based access via JSON Web Tokens.

Global choice in `next.settings.preview_url_generator`. Used by
`NextSite::getPreviewUrlForEntity()`.

## revalidator — tells the front end to rebuild (ISR)

Interface `RevalidatorInterface::revalidate(EntityActionEvent): bool`. Base
`ConfigurableRevalidatorBase`. Configured per `next_entity_type_config` (`revalidator` +
`revalidator_configuration`); stored via a plugin collection.

- **`path`** — path-based on-demand revalidation; config `{ revalidate_page: bool, additional_paths:
  string }` (one path per line, e.g. `/blog`).
- **`cache_tag`** — cache-tag-based revalidation; config `{ entity_tag: bool, entity_list_tag: bool,
  additional_tags: string }`.

Run automatically by `EntityActionEventRevalidateSubscriber` on entity insert/update/delete.

## Implementing a plugin

Create a class in your module's `Plugin/Next/<Type>/` dir, annotate it, extend the matching base:

```php
namespace Drupal\my_module\Plugin\Next\Revalidator;

use Drupal\next\Plugin\ConfigurableRevalidatorBase;
use Drupal\next\Plugin\RevalidatorInterface;
use Drupal\next\Event\EntityActionEvent;

/**
 * @Revalidator(
 *   id = "my_revalidator",
 *   label = "My revalidator",
 *   description = "Notify my CDN."
 * )
 */
class MyRevalidator extends ConfigurableRevalidatorBase implements RevalidatorInterface {
  public function revalidate(EntityActionEvent $event): bool { /* call your endpoint */ return TRUE; }
}
```

The same shape applies to the other three types (extend `ConfigurableSiteResolverBase` /
`ConfigurableSitePreviewerBase` / `ConfigurablePreviewUrlGeneratorBase` and implement their
interface). It then appears in the relevant admin select.
