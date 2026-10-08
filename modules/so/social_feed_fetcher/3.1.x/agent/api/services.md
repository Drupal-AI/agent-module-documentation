# Pipeline, services, plugin types, routes and Drush (API)

## The import pipeline

`fetch (data provider) → enqueue (ImportSocialFeedService) → per-platform queue → node processor →
social_post node`.

1. **`import_social_feed_service`** (`ImportSocialFeedService`, args `config.factory`, `queue`,
   `plugin.social_data_provider.manager`, `state`, `social_feed_fetcher.logger`, `messenger`).
   `import()` checks the `social_feed_fetcher_interval` throttle against
   `State['social_feed_fetcher.next_execution']`, then `doImport()` calls each enabled platform's
   provider: `createInstance('facebook'|'twitter'|'instagram'|'linkedin')`, `setClient()`,
   `getPosts($count)`, and `createItem()` on the queue `social_posts_<platform>_queue_worker`. Errors
   are caught, logged to the `social_feed_fetcher` channel and shown via messenger; the run logs a
   per-platform new-post count.
2. **Queue workers** (`Plugin/QueueWorker/*`, extend `SocialPostQueueWorkerBase`,
   `@QueueWorker … cron = {"time" = 10}`): each `processItem()` does
   `plugin.manager.node_processor->createInstance('<platform>_processor')->processItem('<platform>',
   $data)`.
3. **Node processors** (`Plugin/NodeProcessor/*`) build and `save()` a `social_post` node.

## Plugin type 1 — `SocialDataProvider` (fetch layer)

- Manager `plugin.social_data_provider.manager` (`SocialDataProviderManager`, extends
  `DefaultPluginManager`), dir `Plugin/SocialDataProvider`, interface `SocialDataProviderInterface`,
  base `SocialDataProviderPluginBase`, annotation `Annotation\SocialDataProvider`, alter hook
  `social_data_provider_info`. `createInstance()` injects the `social_feed_fetcher.settings` config.
- Contract: `setClient()` (build the vendor API client), `getPosts($count)` (return raw items).
- Bundled ids and vendor clients: `facebook` (`Facebook\Facebook`, app token
  `fb_app_id|fb_secret_key`), `twitter` (`Abraham\TwitterOAuth\TwitterOAuth`; honours a
  `Settings::get('http_client_config')['proxy']`), `instagram`
  (`EspressoDev\InstagramBasicDisplay\InstagramBasicDisplay`, token from
  `State['insta_access_token']`), `linkedin` (`LinkedIn\Client` at
  `https://api.linkedin.com/v2/`, token from `State['access_token']`).

## Plugin type 2 — `PluginNodeProcessor` (persist layer)

- Manager `plugin.manager.node_processor` (`PluginNodeProcessorManager`), dir `Plugin/NodeProcessor`,
  interface `PluginNodeProcessorPluginInterface`, base `PluginNodeProcessorPluginBase`, annotation
  `Annotation\PluginNodeProcessor`, alter hook `node_processor_info`. `createInstance()` injects the
  config, the `node` entity storage, the core `http_client`, and `file_system`.
- Contract: `processItem($source, $data_item)` → create a `social_post` node if `field_id` is not
  already present (`isPostIdExist()`), else return FALSE.
- Field mapping (all processors): `field_platform = ucwords($source)`, `field_id` = platform post id,
  `field_post = ['value' => social_feed_fetcher_linkify(html_entity_decode(<text>)), 'format' =>
  formats_post_format]`, `field_posted` = normalized datetime, `field_social_feed_link` = permalink/
  attachment URL, `field_sp_image` = a downloaded image file id via `processImageFile($url, $dir)`
  (`http_client->get($url)` → `file.repository->writeData()` under `public://<platform>`).
- `social_feed_fetcher_linkify()` (`social_feed_fetcher.module`) runs `htmlspecialchars()` over the
  text and then wraps bare http(s)/domain URLs in `<a href>` — so post text is HTML-escaped before it
  is stored and rendered through the chosen text format.

## Routes and controllers

| Route | Path | Access | Handler |
|---|---|---|---|
| `social_feed_fetcher.settings` | `/admin/config/social_feed_fetcher_settings` | `_permission: administer socialpost entity` | `Form\SocialPostSettingsForm` |
| `social_feed_fetcher.authorization_code` | `/oauth/callback` | `_access: TRUE` | `AuthorizationCodeController::getResponse` (LinkedIn) |
| `social_feed_fetcher.instagram.authorization_code` | `/instagram/oauth/callback` | `_access: TRUE` | `AuthorizationInstagramController::getResponse` (Instagram) |

Both callbacks read `?code=`, exchange it for an access token (LinkedIn: `LinkedIn\Client`;
Instagram: a Guzzle POST to `https://api.instagram.com/oauth/access_token` then a long-lived-token
exchange), store the token in State, and redirect back to the settings page with a status message.

## Other services

- `social_feed_fetcher.linkedin.oauth.factory` (`ProviderDataFactory\LinkedinDataProviderFactory`) →
  `social_feed_fetcher.linkedin.client` (`LinkedIn\Client` built from `linkedin_client_id` /
  `linkedin_secret_app`).
- `social_feed_fetcher.instagram.client.factory` (`ProviderDataFactory\InstagramDataProvideFactory`)
  → `social_feed_fetcher.instagram.client` (`InstagramBasicDisplay` built from `in_client_id` /
  `in_client_secret` and the `/instagram/oauth/callback` redirect URI).
- `social_feed_fetcher.logger` — logger channel `social_feed_fetcher`.

## Drush

`Commands\SocialFeedFetcherCommands` (tagged `drush.command`, `drush.services.yml`):
`social_feed_fetcher:import` / alias `sff-import` — runs `import_social_feed_service->import()` then
`runQueues()` over all four `social_posts_*_queue_worker` queues.

## Adding a platform

Add a `Plugin/SocialDataProvider/<X>DataProvider` (`@SocialDataProvider(id="x")`, implement
`setClient()`/`getPosts()`), a matching `Plugin/NodeProcessor/<X>NodeProcessor`
(`@PluginNodeProcessor(id="x_processor")`, implement `processItem()`), a
`Plugin/QueueWorker/SocialPost<X>QueueWorker` (`@QueueWorker id="social_posts_x_queue_worker"`) that
wires them, and enqueue it from a copy of `ImportSocialFeedService::doImport()` (or via the alter
hooks `social_data_provider_info` / `node_processor_info` to alter the bundled set). There is no
`hook_cron` in this module — schedule the fetch via the Drush command.
