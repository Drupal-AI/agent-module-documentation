# Permissions

From `search_api_decoupled.permissions.yml` (+ dynamic callback
`SearchApiEndpointPermissions::byEndpoint`):

| Permission | Gates |
|---|---|
| `administer search_api_endpoint` | Create/edit/delete endpoints and filters (all `/admin/config/search/search-api/endpoints/*` routes); also acts as a master key to query **any** endpoint. |
| `use search api endpoint` | Static "use decoupled search endpoint" permission (title only in the yml). |
| `use search with <endpoint_id> endpoint` | **Dynamic, one per endpoint** — allows querying that specific `/api/search/<id>` endpoint. Title: "Use search with %label endpoint". |

## Endpoint access check
`SearchApiEndpointAccessCheck` (`_search_api_endpoint` requirement on the search route) grants access
only if **both**:
1. the endpoint's Search API **index is enabled** (`$index->status()`), and
2. the account holds `use search with <id> endpoint` **OR** `administer search_api_endpoint`.

## Guidance
- To make an endpoint public, grant `use search with <id> endpoint` to the **anonymous** role — this
  is an explicit opt-in per endpoint (there is no default-open endpoint).
- Neither `use search…` permission is `restrict access: true`; they are meant to be grantable to
  low-trust roles (that is the point of a decoupled search API).
- Because granting the endpoint permission exposes the indexed data, ensure the index itself is
  access-filtered (see the hardening note in configure/endpoint.md) before opening it to anonymous.
