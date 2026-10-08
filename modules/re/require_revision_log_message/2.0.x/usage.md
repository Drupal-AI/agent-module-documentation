Require Revision Log Message forces content editors to fill in the revision log message when they save a node, configurable per content type.

---

The module implements `hook_form_BASE_FORM_ID_alter()` on the node form (`node_form`). For content types selected on its settings form, it makes the revision log message a required field: it forces the "Create new revision" checkbox on (and disables it so editors cannot uncheck it) and marks the `revision_log` widget `#required` at every level of the render array. Which content types are affected is stored in a single config object, `require_revision_log_message.adminsettings`, under the `content_types` key (a sequence of node-type machine names); a separate boolean `require_for_new_nodes` decides whether the requirement also applies when creating brand-new nodes (by default it only applies to edits of existing nodes). Two permissions gate behavior: `administer require_revision_log_message` controls access to the settings form at `/admin/config/require-revision-log/adminsettings`, and `bypass require_revision_log_message` lets privileged users skip the requirement entirely. The module has no services, plugins, drush commands, or entities of its own — its entire footprint is one form alter, one settings form, one config object, and two permissions. It works only on entities that use core's node form and revision system.

---

- Require a revision log message whenever editors save an Article, so every change is documented.
- Enforce documented edits per content type — e.g. require logs on News and Policy pages but not on Basic pages.
- Make the "Create new revision" checkbox mandatory (and un-uncheckable) on selected content types.
- Also require a log message when *creating* new nodes, not just when editing, via `require_for_new_nodes`.
- Keep an accountable audit trail of who changed what and why across editorial content.
- Grant trusted roles the `bypass require_revision_log_message` permission so admins can save without a log.
- Restrict who can change which content types are affected using `administer require_revision_log_message`.
- Encourage a review culture where every revision carries a human-readable rationale.
- Satisfy compliance or governance rules that mandate change justifications on published content.
- Prevent silent edits to sensitive content by forcing an explanatory note.
- Configure the requirement entirely through exported config (`require_revision_log_message.adminsettings`) for deployment.
- Turn the requirement on or off per environment by overriding the `content_types` config value.
- Combine with core's revision UI so the log messages show up on the node's Revisions tab.
- Ensure moderators leave a reason when transitioning content through an editorial workflow.
- Standardize documentation practices across a large multi-author site.
- Onboard new editors with a hard prompt that teaches them to describe their changes.
- Require logs on high-traffic landing pages where accidental edits are costly.
- Pair with the Diff module so a required log message accompanies each visible revision diff.
- Force a log message on legal or medical content types where traceability matters.
- Roll out mandatory change notes to the whole editorial team by ticking a few checkboxes.
- Exempt automated or migration users by granting them the bypass permission.
- Make the revision log a required part of the publishing checklist for specific bundles.
