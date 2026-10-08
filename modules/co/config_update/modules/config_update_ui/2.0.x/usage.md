Configuration Update Reports adds a UI and Drush commands to Drupal's configuration management that show, per module/theme/profile or per config type, which config items are missing, added, or changed relative to the defaults the extensions ship — and lets you import missing items, view diffs, and revert changed items back to their provided defaults.

---

The core Configuration Manager can import a whole config set but gives you no visibility into how a single item drifted from the default a module originally shipped. This submodule (part of the Configuration Update project, requiring Configuration Update Base) builds a report at **Admin → Configuration → Development → Configuration → Update report**. You run the report scoped to a configuration type (Views, Blocks, Actions, …), to an installed module/theme/profile, or across everything. The report has three sections: **Missing** items (defaults an extension provides that aren't in active storage — importable), **Added** items (config on your site not provided by any extension — exportable), and **Changed** items (active config that differs from the current shipped default — you can diff, export, or revert them). The same operations are available as Drush commands (`config-different-report`/`crd`, `config-missing-report`/`crm`, `config-added-report`/`cra`, `config-inactive-report`/`cri`, `config-diff`/`cfd`, `config-revert`/`cfr`, `config-revert-multiple`/`cfrm`, `config-import-missing`/`cfi`, `config-list-types`/`clt`). Reverting overwrites the active item with the module/theme/profile default; importing installs a currently-missing default. All comparisons use base configuration, ignoring `settings.php` overrides and translations. Access is gated by dedicated permissions, with revert and delete flagged as restricted.

---

- See which config items changed after updating a module.
- Import new default configuration a module added in an update.
- Revert an accidentally-edited View back to the module's shipped default.
- Restore a modified Block, Action, or Tour to its provided default.
- Diff a single config item's active value against the extension default in the UI.
- Run a report scoped to one module to audit only its configuration.
- Run a report scoped to a config type (e.g. all Views) across the site.
- Run an all-configuration report to survey total drift.
- Identify "added" config your site has that no extension provides.
- Export site-added config for placing under version control.
- Detect "inactive" config — provided but not yet installed.
- Bulk-revert every changed item of one type with `config-revert-multiple`.
- Bulk-revert all changed items from a single module to defaults.
- Import a missing config item from the command line with `cfi`.
- Script a drift audit in CI using the Drush report commands.
- List all configuration types on the system with `config-list-types`.
- Show a normalized diff of one item with `drush config-diff`.
- Reset a customized email/Action config after debugging.
- Review differences before deciding whether to keep or discard a change.
- Clean up leftover configuration from a removed feature.
- Give site builders a self-service "reset to default" for selected config.
- Verify a deployment matches shipped defaults for critical config.
- Delete stray configuration items (restricted permission).
- Gate report viewing to trusted roles via the view permission.
- Recover config that was overwritten by manual edits without a full config import.
