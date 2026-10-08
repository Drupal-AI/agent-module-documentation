HTTP Client Error Status provides a Condition plugin ("HTTP 40x Client error status code") that evaluates whether the current request is a 401, 403, or 404 client-error page — most commonly used as a block visibility condition so a block shows only on those error pages.

---

The module registers one condition plugin, `http_client_error_status` (`ConditionPluginBase`), with three boolean settings — `request_401`, `request_403`, `request_404` — plus the standard `negate`. `evaluate()` reads the current request's `exception` attribute and returns `TRUE` when its status code matches an enabled checkbox (adding the `url.path` cache context). Because it is a generic Condition, any subsystem that consumes conditions can use it, but the primary use is Drupal core's Block system: editing a block shows a "HTTP 40x Client errors" section where you tick the pages to display on. As of 3.1.x the module is positioned as a **migration helper toward core's own `response_status` block condition** (which covers 403/404/200 but not 401): a listing page at `admin/config/development/http-client-error-status` (permission `administer http_client_error_status configuration`, controller `BlockListingController`, themed table `http_client_error_status_table`) lists every block using the plugin and flags "potential conflicts" (a block that already has both this condition and `response_status`). Three Drush commands (`hces:list`, `hces:remove`, `hces:update`) list instances, strip the plugin from all blocks, or convert its 403/404 settings to the core `response_status` condition (preserving 401, which core lacks, on this plugin). The `Main` service holds all the block-scanning/conversion logic; `hook_uninstall()` calls `removePluginInstances()` so uninstalling cleans the condition off blocks rather than deleting the blocks. Note the migration/`convertCondition()` mapping only handles specific 403/404/negate combinations and skips blocks with a pre-existing conflict.

---

- Show a block only on the 404 "Page not found" page (e.g. a search box or sitemap link).
- Show a block only on the 403 "Access denied" page (e.g. a login prompt or contact link).
- Show a block only on the 401 Unauthorized page.
- Show a block on any combination of 401/403/404 error pages.
- Invert the condition (`negate`) to HIDE a block on client-error pages.
- Add "helpful links" or support messaging specifically to error screens.
- Provide a custom, block-driven error page layout without a dedicated 404 controller.
- Reuse the condition anywhere Drupal's Condition/Context system is consumed, not just blocks.
- Cover 401, which core's `response_status` condition does not support.
- Audit which blocks currently rely on this module via `admin/config/development/http-client-error-status`.
- Detect blocks that have both this condition and core `response_status` ("potential conflict").
- List all plugin instances from the CLI with `drush hces:list`.
- Migrate 403/404 visibility to core's `response_status` condition with `drush hces:update`.
- Remove the plugin from every block (keeping the blocks) with `drush hces:remove`.
- Preserve 401 visibility on this plugin while moving 403/404 to core during migration.
- Cleanly uninstall — the condition is stripped from blocks on uninstall, blocks stay put.
- Stage the core-condition migration on a test/dev copy before deploying config (README guidance).
- Keep error-page block visibility in exportable block config.
- Gate the migration/listing UI behind a dedicated permission.
- Combine with theme suggestions to build a richer 404/403 experience from blocks.
