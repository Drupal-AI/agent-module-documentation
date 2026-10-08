Custom Publishing Options lets you define extra per-node boolean publishing states (beyond core's Published / Promoted / Sticky) — each a config entity that adds a checkbox to the node form and a filterable/sortable field to Views.

---

The module defines a `custom_publishing_option` config entity (config prefix `custom_pub.custom_publishing_option.<id>`) with an id, label, description, and a `publish_under_promote_options` boolean. When you create an option, its `postSave()` installs a **boolean base field on the `node` entity named after the option's machine id**, so every content type gains that field; it appears as a checkbox grouped under a "Custom Publish Options" (or "Promote options") details section on the node add/edit form. Because the value is a real node base field, Views can use it as a field, filter, and sort — e.g. to build an "Archived" content listing. Access is granular: the module's permission callback generates a `can set node publish state to <id>` permission per option (whether the checkbox is shown), plus an `administer custom publishing options` permission for managing the option entities. It also ships a node Action plugin, `set_custom_publishing_option_value`, for bulk-setting an option on nodes (e.g. from a View or the content overview), and a Rules action and a D7 migrate source. The admin UI lives at `/admin/config/content/custom_publishing_option` (route `entity.custom_publishing_option.collection`). Note: to *also* see core's own status/promote/sticky checkboxes a role still needs `administer nodes` (or the Override Node Options module); custom options themselves are gated only by the per-option permission.

---

- Add an "Archived" publishing state so editors can archive content without unpublishing it.
- Create a "Featured" flag that a View filters on to build a featured-content block.
- Add an "Approved by legal" checkbox to the node form for a review workflow.
- Provide a "Show in newsletter" option that a digest View queries.
- Define a "Members only" boolean used by other logic to gate content.
- Build an editorial "Ready to publish" staging flag separate from the live published status.
- Add a "Breaking news" toggle that a front-page View sorts to the top.
- Restrict who can set a given option using its per-option permission.
- Group a custom option under core's "Promotion options" via publish_under_promote_options.
- Bulk-set a custom option across many nodes with the provided Action plugin.
- Sort a content listing View by a custom publishing option.
- Filter an admin View to show only nodes with a specific custom flag set.
- Add a per-node "Sponsored" marker for advertising content.
- Create a "Do not index" flag consumed by SEO logic.
- Provide a "Pin to dashboard" boolean for an internal tool.
- Add a "Needs translation" editorial flag tracked in Views.
- Define multiple independent publishing states without custom module code.
- Expose a custom flag as a field in a REST/JSON:API node response (it is a base field).
- Migrate legacy Drupal 7 custom publishing options in via the bundled migrate source.
- Bulk-archive selected nodes from the content overview using the action.
- Set a custom flag programmatically on node save (it is a normal boolean field on the node).
- Give different roles permission to set different custom publishing options.
- Track a "Verified" state on user-generated content for moderation.
- Deploy the option definitions as configuration across environments.
