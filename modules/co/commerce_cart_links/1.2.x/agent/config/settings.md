<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & access

## Admin form
- Route `commerce_cart_links.settings` → `/admin/commerce/config/orders/cart-links`
  (menu link under `commerce_order.configuration`), form `CartLinksSettings` (`ConfigFormBase`).
- Permission: `administer commerce_cart_links` (`restrict access: true`).
- Config object: `commerce_cart_links.settings` (schema `commerce_cart_links.schema.yml`).

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `allowlist_urls` | string (one domain per line) | `''` | Referer-host allowlist. Empty = any referer allowed. |
| `require_referer_url` | boolean | `false` | When `true`, requests with **no** referer are rejected. |

(`commerce_cart_links_update_9001` renamed the legacy `whitelist_urls` key to `allowlist_urls`.)

## Access to /cart-links
`CartLinksController::checkAccess` returns allowed only if **all** hold:
1. `validateQueryParams()` — products parse to integer id+quantity; any entity type is a registered
   purchasable type; `existing` (if set) is `new`/`empty`/`delete`.
2. `validateRefererUrl()`:
   - No referer header → allowed **unless** `require_referer_url` is `true`.
   - `allowlist_urls` empty → any referer allowed.
   - Otherwise the referer host (`parse_url(..., PHP_URL_HOST)`) must match the allowlist via
     `path.matcher` (`matchPath`, supports `*`).
3. The user has the **`view commerce cart links`** permission.

Because cart links are meant to be followed from emails, ads, QR codes and partner sites, the
`view commerce cart links` permission is typically granted to the roles that should be able to use
them (e.g. anonymous for a public campaign); by default no non-admin role has it. The referer
allowlist and `require_referer_url` let an operator constrain which referring domains are honored.

## Other permissions
- `generate cart share links` — gates the "Share cart" modal/button (see
  [../extend/share-cart.md](../extend/share-cart.md)).
- `administer commerce_cart_links` — the settings form above.
