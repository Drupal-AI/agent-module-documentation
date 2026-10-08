# Extend — add a social network + generator API

## Add or override a network
Networks are plain services tagged `social_simple_network`, collected by `social_simple.manager`
(service_collector, `call: addNetwork`). To add a destination:

1. Create a class implementing `Drupal\social_simple\SocialNetwork\SocialNetworkInterface`:
   - `getId(): string` — machine id (used as the network key / checkbox value).
   - `getLabel(): string` — human label.
   - `getShareLink($share_url, $title = '', EntityInterface $entity = NULL, array $additional_options = []): array`
     — return `['url' => Url, 'title' => <render array/markup>, 'attributes' => [...]]`.
   - `getLinkAttributes($network_name): array` — anchor attributes (popup sizing, tooltip, etc.).
2. Register it as a tagged service:
```yaml
services:
  mymodule.mastodon:
    class: Drupal\mymodule\SocialNetwork\Mastodon
    tags:
      - { name: social_simple_network, priority: 0 }
```
Higher `priority` wins when two services share the same `getId()` — so you can **override** a
shipped network (e.g. re-implement `twitter`) by registering a higher-priority service with the same
id. `SocialSimpleManager::getSortedNetworks()` keeps the highest-priority service per id.

Look at `src/SocialNetwork/Twitter.php` (builds `https://twitter.com/intent/tweet/` with `url` +
`text` query and appends hashtags from the entity) or `Mail.php` / `PrintPage.php` /
`EntityPrintPdf.php` (constructor-injected `@module_handler`, and `@config.factory` for PDF) as
templates. Services that need dependencies just declare `arguments:` as usual.

## Generator API (`social_simple.generator`)
`Drupal\social_simple\SocialSimpleGenerator` — build buttons programmatically:
- `buildSocialLinks(array $networks, $title, EntityInterface $entity = NULL, array $options = []): array`
  — returns a `#theme => 'social_simple_buttons'` render array (attaches `social_simple/buttons`).
  `$networks` is a list keyed/valued by network id (e.g. `['twitter' => 'twitter']`); `$options`
  passes per-network extra query params.
- `generateSocialLinks(...)` — the underlying per-network link array.
- `getTitle($entity)` — entity label, else the route title; `getShareUrl($entity)` — entity
  canonical absolute URL, else `<current>`.
- `getNetworks()` — id => label map of all registered networks.

Manager `social_simple.manager` (`SocialSimpleManagerInterface`): `getNetworks()`,
`get($id)`, `getSortedNetworks()`.

## Notes
- No plugin manager / annotation plugin type — extension is purely via the tagged service pattern.
- No `*.api.php` hooks are defined.
