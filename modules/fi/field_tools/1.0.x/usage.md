Field Tools is a collection of UI utilities layered on top of Field UI for copying fields and display configuration between entity bundles, plus reports that list every field and reference relationship on the site.

---

The module requires core's `field_ui` and adds extra local-task tabs to every fieldable bundle's "Manage fields" area (via a route subscriber that keys off each entity type's `field_ui_base_route`). From those tabs an administrator can clone a single field to another bundle, bulk-clone several fields at once, clone whole form/view displays to another bundle, copy individual field display settings across bundles, and export a bundle's field configuration either as base-field PHP code or as config YAML. It also registers three site-wide reports under `/admin/reports/fields`: a field list, a reference-field list, and (when the optional GraphAPI module is present) a field reference graph. A "Multiple import" config form is added at `/admin/config/development/configuration/multiple/import`, and a delete form/route is attached to `field_storage_config` entities. The heavy lifting lives in four services — `field_tools.field_cloner`, `field_tools.display_cloner`, `field_tools.display_settings_copier`, and `field_tools.references.info` — which agents can call directly instead of driving the UI. When a field is cloned to a bundle, its form- and view-display settings are copied to displays on the destination whose view-mode names match the source. A single permission, `access field tools pages`, gates the reports; the per-bundle clone/export actions are gated by the core `administer <entity_type> fields` permission.

---

- Clone one existing field from Article to Page (or any other bundle) without recreating it by hand.
- Bulk-clone a set of fields from one content type to several other bundles in a single form submission.
- Copy an entire form display or view display from a source bundle to a destination bundle.
- Copy just one field's widget/formatter display settings from one bundle to another.
- Reuse a field on a different entity type entirely (e.g. clone a node field onto a taxonomy term), creating shared field storage when types match.
- Export a bundle's configured fields as base-field PHP code to move them into a custom entity or module.
- Export a bundle's field configuration to YAML for config-based deployment.
- Audit every field instance on the site from the `/admin/reports/fields/tools` field list.
- Review all entity-reference fields and what they point at via `/admin/reports/fields/references`.
- Visualise how entity types reference each other with the field graph (requires GraphAPI).
- Delete an orphaned `field_storage_config` through the dedicated delete form Field Tools adds.
- Import several configuration items at once through the Multiple import form.
- Programmatically clone a field in custom code with the `field_tools.field_cloner` service.
- Programmatically clone a form or view display with the `field_tools.display_cloner` service.
- Programmatically copy a single field's display settings with `field_tools.display_settings_copier`.
- Enumerate all reference fields/storages in code with the `field_tools.references.info` service.
- Roll out a standard set of fields across many content types when building a new site quickly.
- Keep several bundles' displays in sync after changing widgets/formatters on one of them.
- Migrate fields between bundles during a content model refactor.
- Give a field the same teaser/full view-mode formatting on a new bundle automatically during a clone.
- Provide site builders a one-click "Clone" operation link on each field in a bundle's field list.
- Copy display settings only for view modes that exist on both source and destination (matching names).
- Generate starter code for converting configured fields into base fields on a custom content entity.
- Inspect which bundles a given reference field targets before refactoring the content model.
- Speed up creating similar content types that share many fields.
