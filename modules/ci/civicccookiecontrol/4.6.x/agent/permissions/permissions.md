# Permissions & access checks

## Permission

| Permission | Grants |
|---|---|
| `administer civiccookiecontrol` | Access to the settings form, the IAB v1/v2 forms, and add/edit/delete of all four config entity types. It is the `admin_permission` on every `cookiecategory`/`necessarycookie`/`excludedcountry`/`altlanguage` entity and the requirement on every route in `civiccookiecontrol.routing.yml`. |

That is the only permission the module defines (`civiccookiecontrol.permissions.yml`). The consent widget
itself renders for anonymous/all visitors — no permission is needed to see the banner.

## Custom access checks (services, `civiccookiecontrol.services.yml`)

Some routes use custom access instead of a bare permission. All ultimately still require
`administer civiccookiecontrol`; they add "and the API key is valid" (and IAB state) gating so the extra
config tabs only appear on a working install.

| Applies to / route | Service / callback | Allowed when |
|---|---|---|
| `_custom_access` on entity collections (`necessarycookie`, `excludedcountry`, `altlanguage`) | `CookieControlAccess::checkAccess` | has `administer civiccookiecontrol` **and** `checkApiKey()` is true |
| `_iab1_access_check` (route `cookiecontrol.iab1`) | `civiccookiecontrol.IAB1Access` (`IAB1Access`) | key valid, version 8, and IAB v1 applicable |
| `_iab2_access_check` (route `cookiecontrol.iab2`) | `civiccookiecontrol.IAB2Access` (`IAB2Access`) | key valid, version 9 |
| `_iab2_enabled_access_check` (route `entity.cookiecategory.collection`) | `civiccookiecontrol.IAB2EnabledAccess` (`IAB2EnabledAccess`) | version 8 → delegates to IAB1; version 9 → has permission **and** key valid **and** IAB v2 CMP is **off** (categories are unused when IAB CMP is on) |

`CookieControlAccess::checkApiKey()` re-validates the stored key against Civic
(`https://apikeys.civiccomputing.com`) via `CCCFormHelper::validateApiKey()`, so these checks make a
network call; results are effectively gated on the license being live.
