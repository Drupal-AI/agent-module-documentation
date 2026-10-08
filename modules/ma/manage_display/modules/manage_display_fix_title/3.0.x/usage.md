<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
**Obsolete.** A retired submodule of Manage Display that once worked around core bugs in entity title display; in 3.0.x it ships as a metadata-only stub that cannot be installed on Drupal 10 or 11, and the parent module actively uninstalls it.

---

`manage_display_fix_title` contains **no code** — the whole submodule is a single
`manage_display_fix_title.info.yml`. That file declares `lifecycle: obsolete` with
`lifecycle_link` pointing at issue 3291074, and `core_version_requirement: ^8.8 || ^9`, so on a
Drupal 11 site `drush en manage_display_fix_title` fails with *"module 'manage_display_fix_title'
is incompatible with this version of Drupal core"*. Its historical job was to patch core bugs
where an entity title was printed twice (once by the page-title block, once by the display) back
when core had no `enable_page_title_template` / `enable_base_field_custom_preprocess_skipping`
entity-type flags. Those flags now exist in core, and the parent `manage_display` module sets
them directly in `manage_display_entity_type_build()`, which is why the workaround was retired.
`manage_display_update_9201()` in the parent module explicitly uninstalls this submodule if it is
still enabled from an older site. The correct action on any current site is simply: do not enable
it; enable `manage_display` alone. It is retained in the package only so that update path can run
and so existing sites' `core.extension` entries resolve.

---

- Recognise a legacy `core.extension` entry for `manage_display_fix_title` as safe to drop.
- Understand why `drush en manage_display_fix_title` fails on Drupal 10/11 (core requirement `^8.8 || ^9`).
- Confirm the double-printed-title workaround is now handled by the parent module instead.
- Audit a Drupal 9 → 11 upgrade for obsolete submodules that must be uninstalled first.
- Explain to a site builder that no configuration is lost by removing this submodule.
- Trace the retirement decision through `lifecycle_link` issue 3291074.
- Verify `manage_display_update_9201()` ran and uninstalled the submodule.
- Check a `composer.lock`/module list report that still flags this submodule as present on disk.
- Decide against enabling it when following an old tutorial that references it.
- Map its former behaviour onto core's `enable_page_title_template` entity-type flag.
- Map its former behaviour onto core's `enable_base_field_custom_preprocess_skipping` flag.
- Answer a security/maintenance review asking which bundled submodules are unsupported.
- Document that the submodule provides no permissions, routes, services, plugins or schema.
- Confirm no `config/install` or `config/schema` files ship with it, so uninstalling changes no config.
- Keep upgrade checklists accurate by listing it as obsolete rather than optional.
- Explain why the directory still exists in the downloaded project despite being unusable.
- Avoid adding it to a site's `enabled_modules` in a deployment recipe or profile.
- Detect it in `drush pm:list` output as Disabled and leave it that way.
