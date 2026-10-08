# Configure CSS/JS assets

## Where
Admin UI at `/admin/config/development/asset-injector` (route `asset_injector.development`),
with two collections:
- **CSS**: `/admin/config/development/asset-injector/css` (`entity.asset_injector_css.collection`).
- **JS**: `/admin/config/development/asset-injector/js` (`entity.asset_injector_js.collection`).

Each has add / edit / delete / enable / disable / duplicate operations (entity forms in
`src/Form/`).

## Config entities
- `asset_injector_css` (`src/Entity/AssetInjectorCss.php`) — a CSS snippet.
- `asset_injector_js` (`src/Entity/AssetInjectorJs.php`) — a JS snippet.

Both extend `AssetInjectorBase` (implements `AssetInjectorInterface`). Because they are config
entities, they export to YAML via `drush config:export` and deploy across environments/multisite.
Schema: `config/schema/asset_injector.schema.yml`.

## Common per-asset settings
- **Label / machine name** — identify the asset.
- **Code** — the raw CSS or JS.
- **Conditions** — core condition plugins (request path, content type, user role, etc.) to
  scope where the asset loads.
- **CSS media** — media query/type for CSS assets.
- **JS options** — header vs footer placement, `preprocess`, and **library dependencies**
  (e.g. `core/jquery`).

## How it loads
Assets are compiled into a dynamic library and attached to matching pages, so Drupal
aggregation/caching applies. Physical files are managed by `src/AssetFileStorage.php`. Access to
each asset is enforced by `AssetInjectorAccessControlHandler` using the module permissions.
