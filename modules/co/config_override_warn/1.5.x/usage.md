<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Override Warn prints a warning message on Drupal configuration forms whenever a value on that form is currently being overridden (by `settings.php` `$config[…]` lines or by a module implementing `ConfigFactoryOverrideInterface`), so an admin does not silently "save" a setting that the override will keep winning over.

---

The module has no admin UI, no permissions, no routes and no plugins: it is a single `hook_form_alter()` plus one service. On every form build it asks `config_override_warn.form_overrides` which configuration objects that form edits — for a `ConfigFormBase` it reflects into the protected `getEditableConfigNames()`, and for an `EntityForm` editing an existing config entity it uses that entity's config dependency name. For each of those config names it checks `Config::hasOverrides()`, then reflects into the `Config` object's protected `moduleOverrides` and `settingsOverrides` properties to learn exactly which keys are overridden. Each overridden key is diffed (`getOriginal($key, FALSE)` versus `get($key)`); identical values are skipped, and arrays are reduced with `DiffArray::diffAssocRecursive()` so only the differing sub-keys are reported. The result is rendered through the `config_override_warn_overrides` theme hook (template `templates/config-override-warn-overrides.html.twig`) and pushed to the messenger as a warning. Its one setting, `config_override_warn.settings:show_values` (default `true`), decides whether the message shows the original and overridden values or merely names the overridden keys — useful when overridden values are secrets. There is no settings form for it, so it is changed with `drush config:set` or a config import.

---

- Warn an administrator that the site name they are about to edit is pinned by a `$config['system.site']['name']` line in `settings.php`.
- Stop editors from repeatedly "fixing" a mail setting that a per-environment override keeps reverting.
- Surface environment-specific overrides (dev/stage/prod) on the very form where they matter.
- Make Config Split / Config Override / environment-indicator style setups self-documenting for site builders.
- Debug "I saved it but nothing changed" reports on any core config form.
- Show which exact keys of `system.performance` are overridden on a hosting platform that pins caching settings.
- Reveal that a contrib module implements `ConfigFactoryOverrideInterface` and is silently changing a form's values.
- Hide the overridden values (`show_values: false`) when the overrides contain API keys or credentials.
- Keep the warning value-less on production while showing full diffs on local development via a per-environment override of the module's own setting.
- Audit a config entity form (a view, an image style, a text format) for overrides before exporting configuration.
- Prevent an accidental `drush config:export` that captures a value the developer thought they had changed.
- Give a new team member immediate feedback that a config value is environment-managed rather than site-managed.
- Confirm that a `$config` override you just added to `settings.php` is actually being picked up by Drupal.
- Warn on the "Basic site settings" form when the slogan or e-mail address is overridden by a deployment tool.
- Check overrides for a specific config object programmatically via `getConfigOverrideDiffs('system.site')`.
- Build a custom status report that lists every overridden key for a set of config names using the module's service.
- Detect overrides on a config entity edit form (e.g. a Views view) that a module injects at runtime.
- Document a multisite setup where shared `settings.php` code pins some settings for all sites.
- Verify after a platform migration that the expected set of config overrides is still in place.
- Reduce support tickets on sites where CI pins settings such as `system.logging:error_level`.
- Train site builders on the difference between stored (active) configuration and the overridden runtime value.
- Spot a stale override left behind after a module that used to provide it was removed.
- Combine with `drush config:get --include-overridden` to compare the stored value with the effective value.
- Provide a clear reason why a form field appears "read only in effect" without disabling the field.
