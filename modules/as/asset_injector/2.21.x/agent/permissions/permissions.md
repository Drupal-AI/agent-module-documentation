# Asset Injector permissions

From `asset_injector.permissions.yml`. Both are **restricted** (marked `restrict access: true`)
because injecting CSS/JS can introduce XSS or break pages — grant only to fully trusted admins.

| Permission | Gates |
|---|---|
| `administer css assets injector` | Create/edit/delete CSS assets and add CSS to pages. |
| `administer js assets injector` | Create/edit/delete JS assets and add JS to pages. |

Per-asset access is enforced by `Drupal\asset_injector\AssetInjectorAccessControlHandler`, which
maps CSS entities to the CSS permission and JS entities to the JS permission.
