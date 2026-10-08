<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Navigation + Entity Workflow is a **deprecated** submodule of Navigation +; its functionality moved into the main module and it now ships only a self-uninstall update hook.

---

The info file states it plainly: *"Deprecated. This functionality has been moved into the main module so Navigation + Entity Workflow will be deleted soon."* There is no runtime code — no `src/`, no routes, no services, no permissions, no config. The only behaviour is `navigation_plus_entity_workflow.install.php`, whose single update hook `navigation_plus_entity_workflow_update_10001()` uninstalls the module itself on the next `drush updatedb`.

If it is enabled on an inherited site, that indicates the site predates the consolidation rather than that the submodule does anything the parent cannot. Run database updates (it self-uninstalls) or uninstall it manually and rely on `navigation_plus`. Do not add it to a new site or carry it in a composer file. It carries no `lifecycle: deprecated` info-file key, so automated lifecycle checks will not flag it — the deprecation lives only in the description.

---

- Recognise a deprecated submodule on an inherited site.
- Let its update hook uninstall it during `drush updatedb`.
- Uninstall it manually and rely on Navigation + itself.
- Remove it from a composer file.
- Confirm the functionality now lives in the parent module.
- Avoid installing it on a new site.
- Audit a site still carrying it.
- Plan a Navigation + upgrade that clears it.
- Explain why a lifecycle scanner does not flag it (no `lifecycle` key).
