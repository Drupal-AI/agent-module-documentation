Config Patch produces patches (unified diffs) between a site's active configuration and its sync/export configuration, so changes made in the UI on one environment can be captured as a patch and committed back to source control. Output is pluggable — the bundled Text plugin prints a patch, and contrib submodules push PRs/MRs to Git hosts.

---

The module adds a **Patch** tab to the config synchronization pages (`admin/config/development/configuration/patch`) listing config objects that differ between active and sync storage, with a button whose action is set by the currently selected output plugin. It compares storages via `ConfigCompare` (using `sebastian/diff`'s `StrictUnifiedDiffOutputBuilder`) and respects Config Ignore when present. Output is a plugin type (`Plugin/config_patch/output`, annotation `@ConfigPatchOutput`, base `OutputPluginBase`) with a text fallback; the bundled `Text` plugin (`config_patch_output_text`) streams a plain-text unified diff to the browser or CLI. A global settings form (`config_patch.settings`, route `admin/config/development/config_patch`) stores `config_base_path` (a relative path prefix prepended to config file paths in the patch, so paths match your repo layout) and the default `output_plugin`; the base path can also be set in `settings.php`. A toolbar widget shows the count of differing config items and links to the Patch tab (AJAX controller). Two Drush commands generate patches and list changed files. Web access is gated by core config permissions: the patch/toolbar/clear-cache routes require `export configuration`, the revert form requires `import configuration`, and the settings form requires the module's own `administer config_patch` (all restricted permissions). Extension submodules (config_patch_gitlab, config_patch_github_api, config_patch_gitea, config_patch_azure_api, etc.) add output plugins that submit patches to hosted Git providers.

---

- See exactly which config objects differ between active and sync storage.
- Generate a unified-diff patch of active-vs-sync configuration.
- Capture a quick production UI config change as a patch to commit back to the repo.
- Print a config patch to the browser as plain text.
- Generate a config patch on the CLI with `drush config:patch text`.
- List changed config files with `drush config:patch:list`.
- Pipe a remote site's patch into `patch -p1` to apply config changes locally.
- Prefix patch file paths with a repo-relative base path so patches apply cleanly.
- Configure the config base path per environment via `settings.php`.
- Choose a default output plugin for the Patch tab.
- Monitor config drift at a glance via the toolbar widget's diff count.
- Restrict a single config item's collection when generating a patch (`--collections`).
- Write a generated patch to a file with the `--filename` Drush option.
- Respect Config Ignore rules when computing the diff.
- Revert a specific config object back to sync via the confirm-revert form.
- Build a custom output plugin to submit patches to a bespoke system.
- Push config changes as a GitLab MR (via the config_patch_gitlab submodule).
- Open a GitHub/Gitea PR from a config patch (via the respective API submodule).
- Provide sitebuilders a "make change, click to patch" workflow without shell access.
- Keep automated deployments from silently overwriting production UI config changes.
- Clear the module's cached comparison via the clear-cache route/button.
