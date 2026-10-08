<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Crowdriff API integrates the CrowdRiff v2 visual content / user-generated-media platform, exposing a service to fetch folders, albums, apps, CTAs and assets (including paged search) for building galleries.

---

The `CrowdriffService` (service id `crowdriff_api.crowdriff_service`) calls the configured API base (default `https://api.crowdriff.com/v2`) with a Bearer token obtained from a Key entity via the `key.repository`; the key name and base URL are stored in `crowdriff_api.settings`. Responses are cached in a dedicated `crowdriff` cache bin with a configurable TTL, and on API errors the service falls back to stale cache. Convenience methods cover folders/albums/apps/CTAs/assets by id, analytics, and POST `search` queries to pull assets from albums, folders or apps, with a `hook_crowdriff_api_alter_assets` alter hook for post-processing. Configuration is at `/admin/config/services/crowdriff` behind the `administer crowdriff` permission (restricted).

Operational notes: the API key is stored as a Key entity (not plaintext config) and read at call time; TLS verification uses Guzzle's secure default and all requests carry a 15s connect/read/timeout. This is an API/service module with no anonymous or mutating routes.

---
- Enable the module (requires the Key module).
- Create a Key holding the CrowdRiff API token.
- Visit /admin/config/services/crowdriff to configure.
- Select the Key that stores the API token.
- Set the API base URL (defaults to the v2 endpoint).
- Enable caching and set the cache length in minutes.
- Fetch all folders or specific folders by id.
- Fetch albums, apps or CTAs by id.
- Retrieve assets by id or their analytics.
- Pull assets from an album with paging.
- Pull assets from a folder or from a CrowdRiff app.
- Run search queries ordered by created_at.
- Implement `hook_crowdriff_api_alter_assets` to adjust asset arrays.
- Rely on stale-cache fallback when the API is unavailable.
- Get the total matched count for a query via getCount().
- Grant `administer crowdriff` only to trusted admins.
