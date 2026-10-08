# Configuration

All of Content Moderation Roles' rules live on a single admin page and are stored
in the `content_moderation_roles.settings` configuration, so they export and
deploy like any other Drupal config.

## Open the settings form

1. Log in as a user with the core **Administer workflows** permission.
2. Go to **Configuration → Workflow → Content Moderation Roles**, or navigate
   directly to `/admin/config/workflow/content-moderation-roles`.

## Full access roles

Choose the roles that should bypass all restrictions and always see **every**
state on **every** content type — typically **Administrator**. Any role selected
here skips the rest of the matrix entirely, so use it for roles you never want to
limit.

## Fallback restricted states

This is the global default applied to any role that has **no explicit entry** in
the per-role configuration below. Set the states that such roles are allowed to
see. It acts as a safety net so an unconfigured role isn't accidentally shown
everything (or nothing).

## Per-role configuration

For each role, set the **default allowed states** — the moderation states that
role may see and set on node forms. Optionally add **per content-type overrides**
so a role behaves differently depending on the content being edited. For example,
an "Editor" role might be allowed to publish Articles but limited to *Draft* on
Events. Where a user holds several roles, they receive the **union** of the
permitted states across all their roles.

The moderation state dropdown on node add/edit forms is automatically trimmed to
match these rules for the current user.

## Views map

Some features work by altering Views queries. Enter `view_id:display_id` pairs,
one per line, to map the Views displays you want affected. Two behaviours use this
map:

- **Content restriction** — content-listing views (for example a "Content For
  Review" view) can be restricted so users only see content types their role has
  elevated access to.
- **Layout Builder sort correction** — corrects the sort order for
  "My Content"-style views when Layout Builder pending revisions are in use, since
  core does not update `node_field_data.changed` for pending revisions. Enable
  this if you use Layout Builder and notice content sorting incorrectly.

## Save

Click **Save configuration**. Because everything is stored as standard config,
remember to export it (`drush cex`) if you deploy configuration between
environments.
