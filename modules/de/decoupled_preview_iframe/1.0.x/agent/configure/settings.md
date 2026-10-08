# Configure Decoupled Preview Iframe

One settings form drives everything. There are no permissions or Drush commands of the module's own.

- Route/form id: `decoupled_preview_iframe.settings` — `/admin/config/decoupled_preview_iframe/settings`
- Form class: `Drupal\decoupled_preview_iframe\Form\SettingsForm` (extends `ConfigFormBase`,
  form id `decoupled_preview_iframe_settings`)
- Permission: `administer site configuration` (core)
- Config object: `decoupled_preview_iframe.settings`
- Menu link `decoupled_preview_iframe.settings` under `system.admin_config_services`

## Config keys (schema `config/schema/decoupled_preview_iframe.schema.yml`)

| Key | Type | Form field | Meaning |
|-----|------|-----------|---------|
| `preview_url` | uri | URL, "Preview URL" | Base URL of the front end, e.g. `http://localhost:8080`. Iframe `src` is this + the page path (+ token). Empty = disabled. |
| `preview_types` | sequence `entity_type → { bundle: bundle }` | "Preview enabled types" checkboxes | Which entity-type bundles get the iframe. |
| `route_sync` | string | textfield, "Route Syncing" | The `window.postMessage` `type` the JS listens for. Default `DECOUPLED_PREVIEW_IFRAME_ROUTE_SYNC`; use `NEXT_DRUPAL_ROUTE_SYNC` with the Next.js module. |
| `draft_provider` | string | select, "Preview Provider" | `none`, or `graphql_compose_preview` (offered only when that module is enabled). Controls draft-token forwarding. |
| `redirect_anonymous` | boolean | checkbox, "Enable Anonymous redirects" | Turn on the anonymous-redirect subscriber (see below). |
| `redirect_url` | uri | URL, "Redirect URL" (visible only when the checkbox is on) | Front-end base to send anonymous visitors to. |

Config-install defaults (`config/install/decoupled_preview_iframe.settings.yml`): `redirect_anonymous: false`,
`redirect_url: ''`, `preview_url: ''`, `preview_types: []`,
`route_sync: 'DECOUPLED_PREVIEW_IFRAME_ROUTE_SYNC'`, `draft_provider: 'none'`.

### Enabled entity types / bundles

`supportedEntityTypes()` returns `node`, `media`, `taxonomy_term`, but the option builder
(`getPreviewTypeOptions()`) skips `media` and only lists bundleable types that have bundles — in
practice `node` and `taxonomy_term`. `submitForm()` stores only the checked (non-empty) bundles, so
`preview_types` looks like `{ node: { article: article, page: page } }`.

## Set via Drush / PHP

```bash
drush cset decoupled_preview_iframe.settings preview_url 'https://front.example.com' -y
# enable one bundle (nested key = entity_type.bundle : bundle)
drush cset decoupled_preview_iframe.settings preview_types.node.article article -y
drush cset decoupled_preview_iframe.settings route_sync 'NEXT_DRUPAL_ROUTE_SYNC' -y
drush cset decoupled_preview_iframe.settings draft_provider graphql_compose_preview -y
drush cr
```

```php
\Drupal::configFactory()->getEditable('decoupled_preview_iframe.settings')
  ->set('preview_url', 'https://front.example.com')
  ->set('preview_types', ['node' => ['article' => 'article']])
  ->set('route_sync', 'DECOUPLED_PREVIEW_IFRAME_ROUTE_SYNC')
  ->set('draft_provider', 'none')
  ->save();
```

## What happens at runtime

### Iframe injection — `decoupled_preview_iframe_entity_view_alter()`

Fires on every entity view. It acts only when the entity's bundle is listed in
`preview_types[$entityTypeId]` **and** the view mode is `default` or `full`. It then replaces the
whole render array with an `iframe` element themed by `preview_iframe`, attaches the
`decoupled_preview_iframe/site` library and `drupalSettings`, and sets `#cache max-age = 0`.

The iframe URL is built by string concatenation of three parts:

```
preview_iframe_url = preview_url  +  <path>  +  <token>
```

- `<path>` is normally `\Drupal::service('path.current')` → `path_alias.manager` alias of the
  current page (e.g. `/node/1` or `/my-article`).
- On the `entity.node.latest_version` route it is instead the `entity.node.revision` URL for the
  node's current revision.
- If the viewed entity is **not** the latest revision and you are not already on a revision route,
  it fetches the latest revision id and uses the `entity.node.revision` URL as a "draft" path; this
  also sets `showPublishedToggle = TRUE` and emits both `publishedUrl` and `draftUrl` in
  `drupalSettings` so the front-end toggle (see theme doc) can switch the iframe between them.
- `<token>` is empty unless `draft_provider === 'graphql_compose_preview'` and a `node_preview`
  route parameter is present, in which case it appends `?token=<node_preview->preview_token>` — that
  is core's own node-preview token, forwarded to the front end (this module does not mint a token).

`drupalSettings.decoupled_preview_iframe` carries `selector` (`iframe.decoupled_preview_iframe`),
`routeSyncType` (= `route_sync`), `publishedUrl` and `draftUrl`.

### Core preview form — `decoupled_preview_iframe_form_node_preview_form_select_alter()`

On `entity.node.preview`, for a bundle whose `node_types.<bundle>` flag is set it hides core's
`view_mode` select (`#access = FALSE`) so the preview bar stays clean inside the iframe.

### Anonymous redirect — `EventSubscriber\RedirectAnonymousSubscriber`

Service `decoupled_preview_iframe.event_subscriber`, subscribed to `KernelEvents::REQUEST`
(priority 30). When `redirect_anonymous` is on it 302-redirects anonymous, non-CLI requests to
`redirect_url` + current path-alias + query string (via `TrustedRedirectResponse`), so a headless
site sends visitors to the front end instead of the Drupal page. It is skipped for:

- routes `user.login`, `user.login.http`, `user.pass`, `user.reset`, `user.reset.login`,
  `oauth2_token.token`;
- paths matching `/graphql?*` or `/sites/default/files/*`;
- aliases ending in `.php`, and CLI (`PHP_SAPI === 'cli'`).

It logs each redirect to the `decoupled_preview_iframe` logger channel. Note there is a `@todo` to
also exclude JSON:API routes — with this on, anonymous JSON:API/REST requests are redirected too, so
enable it only on fully headless/editorial-only Drupal instances.

## Upgrade note

`decoupled_preview_iframe_update_10001` migrates pre-1.0.5 config: legacy `node_types` →
`preview_types['node'][<bundle>]`, `route_sync.type` → `route_sync`, `draft.provider` →
`draft_provider`; it clears the old `node_types` and `draft` keys.
