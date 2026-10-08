# Configuration

To get the Siteimprove overlay working you enter a token, grant permissions,
decide which pages load the overlay, and — if your public and editing domains
differ — choose a frontend‑domain plugin.

## Open the settings form

1. Log in as a user with the **`administer siteimprove`** permission.
2. Go to **Configuration → System → Siteimprove.ai**, or navigate directly to
   `/admin/config/system/siteimprove`.

## Enter (or regenerate) the token

On the settings form, enter — or regenerate — the **Siteimprove auth token**. The
token is requested server‑side from
`https://my2.siteimprove.com/auth/token` over HTTPS with certificate verification
left on (it is not disabled), so the exchange is secure.

## Grant the permissions

The module ships three permissions. Grant them on the People → Permissions page:

| Permission | What it grants |
|---|---|
| **Administer Siteimprove** (`administer siteimprove`) | Access to this settings form. |
| **Use Siteimprove** (`use siteimprove`) | See and use the overlay and its features. By default only administrators have this — grant it to your editor roles. |
| **Use Siteimprove prepublish** (`use siteimprove prepublish`) | Use the pre‑publish content check. |

## Choose which pages load the overlay

Which routes get the Siteimprove integration is controlled by service
**parameters**, which you can override in a `*.services.yml` file if you need to:

- `siteimprove.recheck_enabled_routes` — routes that get the *recheck* action.
- `siteimprove.prepublish_check_enabled_routes` — routes offered the *prepublish*
  check.
- `siteimprove.other_enabled_routes` — other routes that load the integration.

By default these cover node, taxonomy term and group pages — their canonical,
edit and latest‑version routes. Most sites never need to touch these.

## Set the frontend domain

If your public (frontend) domain differs from the editing (backend) domain, pick a
**Frontend Domain plugin** on the settings form:

- the **default** same‑domain option, for when the frontend and backend share a
  domain;
- a **single distinct frontend domain** option, when the site is served from one
  other domain and needs no advanced configuration; or
- a **Domain Access‑aware** option — install the companion
  `siteimprove_domain_access` module for this; it needs no configuration of its
  own, just enable it and it notifies Siteimprove with the correct URL(s) for each
  entity.

Developers can also add their own plugin using the `@SiteimproveDomain`
annotation — see the module's `Simple` and `Single` plugins for examples.

## Save

Click **Save configuration**. Once the token is set and the `use siteimprove`
permission is granted, editors will see the Siteimprove overlay on the configured
pages, and can run the recheck and prepublish actions as they work.
