Azure CDN Purger plugs Drupal's Purge framework into Azure CDN and Azure Front Door, invalidating cached paths so edited content goes live without waiting for TTL expiry.

---

The module ships a Purge purger (`azurecdn`), a queuer (`path_queuer`), and a processor (`azure_processor`) plus a manual purge form. On node update it queues the node's path-alias for invalidation; on cron (or on-demand) the queued paths are chunked and POSTed to the Azure CDN/Front Door purge REST endpoint. Authentication is Azure AD OAuth 2.0 client-credentials (tenant/client/secret/scope), exchanged for a bearer token against `login.microsoftonline.com`, then used against `management.azure.com`. All Azure connection parameters (endpoint type, endpoint/profile/resource-group names, subscription id, API version) plus chunk size and inter-request delay are set on the module's settings form. It supports both the classic `endpoints` (Azure CDN) and `afdEndpoints` (Azure Front Door) endpoint types, and wildcard paths (e.g. `/news/*`).

---

- Purge Azure CDN cache automatically when a node is saved (via `hook_node_update` → Purge queue).
- Purge Azure Front Door cache using the same module (select the "Azure FrontDoor" endpoint type).
- Send a manual, ad-hoc purge of specific paths from the admin UI.
- Purge wildcard paths such as `/news/*` or `/products/*` to invalidate whole sections.
- Invalidate individual node aliases after an editorial update so CDN visitors see fresh content.
- Drive purges on cron by pairing the Path queuer with Purge's Cron processor.
- Batch many invalidations into chunked REST calls with a configurable "purges per request" size.
- Throttle purge requests with a configurable delay (seconds) between chunks to avoid Azure rate-limit errors.
- Authenticate to Azure with an Azure AD app registration using the OAuth 2.0 client-credentials grant.
- Use least-privilege Contributor role scoped to a single CDN/Front Door profile for purge authorization.
- Integrate with Purge UI to add and configure the Azure purger from the performance settings page.
- Restrict who can configure the integration via the `administer azure cdn purge` permission.
- Enable debug mode temporarily to log Azure responses when diagnosing connection problems.
- Bulk-invalidate a list of paths pasted into the manual purge textarea (one per line).
- Combine with the `purge_queues` database_unique plugin to de-duplicate queued paths during bulk edits.
- Keep CDN-cached pages consistent with the origin after content migrations or bulk imports (via manual purge).
- Support multi-environment CDN setups by pointing each site's config at its own endpoint/profile/resource group.
- Serve static and page content through Azure's edge network while retaining editorial control over freshness.
- Trigger purges from custom code by adding invalidations to the Purge queue with the `path_queuer` queuer.
- Purge content deployed behind Azure Front Door for global multi-region cache invalidation.
- Reduce stale-content support tickets by wiring node saves straight to CDN invalidation.
