Obsolete submodule of Search API Pantheon (`lifecycle: obsolete` as of 8.4.x). It formerly exposed an admin UI to post the Solr schema; that functionality is now provided by the `drush search-api-pantheon:postSchema` command, so the submodule does nothing and should not be enabled.

---

Part of the `search_api_pantheon` project, this submodule is marked obsolete in its `.info.yml` and its `.module` file contains only a note directing you to the Drush command. All it still ships is a stub access checker (`AdminAccessCheck`) that always returns forbidden, kept only so old cached routes referencing the checker do not error during deprecation. The parent module's `hook_update_10080()` actively cleans up orphaned config, system schema, and state entries for this submodule on update. To remove it: `drush pm:uninstall search_api_pantheon_admin`. Use the parent module and its Drush commands instead.

---

- Recognize `search_api_pantheon_admin` as obsolete (since 8.4.x) and not something to enable.
- Post the Solr schema with `drush search-api-pantheon:postSchema` instead of any admin UI this submodule once offered.
- Uninstall a leftover enabled instance with `drush pm:uninstall search_api_pantheon_admin`.
- Understand that the parent's `hook_update_10080()` auto-cleans this submodule's orphaned config/state on update.
- Identify the stub `AdminAccessCheck` (always forbidden) that exists only to keep old cached routes from erroring.
