<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
The Actions UI module provides an admin interface at `/admin/config/system/actions` for viewing "simple" actions and creating, configuring, and deleting "advanced" (configurable) actions — reusable tasks such as unpublishing content that contains a keyword or reassigning a node's author.

---

Actions UI is the contrib continuation of Drupal core's former `action` module, which was removed from core; the underlying `action` config entity type is still defined by core's System module, and this module supplies the missing management UI and the configurable action plugins that used to ship with it. An *action* is a reusable task (publish, unpublish, delete, send email, assign owner, …) that other modules — Views Bulk Operations, ECA, Rules, the content moderation flows — can execute against entities. There are two kinds: *simple* actions, which take no configuration and appear automatically on the actions admin page, and *advanced* actions, which the site builder creates from a plugin and configures individually, producing an `action.action.*` config entity. The module registers the list builder and the add/edit/delete forms on the core `action` entity type via `hook_entity_type_build()`, and adds a "Create an advanced action" form driven by the `plugin.manager.action` plugin manager. It ships three configurable action plugins: `node_assign_owner_action` (change a node's author), `node_unpublish_by_keyword_action` (unpublish a node containing given keywords), and `comment_unpublish_by_keyword_action` (the comment equivalent). Config schema for those three plugins lives in `config/schema/action.schema.yml`, and the module also provides D6/D7 migration mappings for the legacy keyword actions. Access to the whole UI is gated by the core `administer actions` permission; the module itself defines no permissions, services, or Drush commands.

---

- Give site builders a UI to manage the actions other modules execute, without hand-editing config YAML.
- Create an advanced action that unpublishes any node containing a banned keyword (`node_unpublish_by_keyword_action`).
- Create an advanced action that unpublishes any comment containing a banned keyword (`comment_unpublish_by_keyword_action`).
- Create an advanced action that reassigns a node's author to a specific user (`node_assign_owner_action`).
- Define reusable tasks that Views Bulk Operations (VBO) can offer as bulk operations on a view of content.
- Provide named actions that ECA or Rules can invoke as part of an event-condition-action workflow.
- Build a moderation workflow where flagged content is automatically unpublished by keyword.
- Reassign ownership of many nodes to an editor in bulk via a configured "Change the author of content" action.
- Configure several keyword-unpublish actions with different keyword lists for different moderation policies.
- Inspect and audit which actions exist on a site by listing `action` config entities.
- Export configured actions to code as `action.action.*.yml` for deployment across environments.
- Recreate Drupal 6/7 keyword-based unpublish actions when migrating a legacy site to Drupal 11.
- Give each advanced action a descriptive label so it is recognizable in bulk-operation and workflow UIs.
- Delete or reconfigure obsolete advanced actions from a single admin screen.
- Let a custom module ship a configurable Action plugin and rely on this UI to let admins configure instances.
- Restrict who can manage system tasks by granting only trusted roles the `administer actions` permission.
- Provide the "simple" action catalogue (publish/unpublish/delete/save/promote/sticky) view so admins can see everything available.
- Wire a keyword-unpublish action into a scheduled/cron job (via another module) to sweep content for banned terms.
- Set up content governance: automatically unpublish content mentioning competitor names or profanity.
- Standardize author reassignment when an editor leaves, by pointing an assign-owner action at a replacement account.
- Use the configured actions as building blocks for automated content lifecycle policies.
- Document a site's automated tasks by reviewing the actions collection page before an audit.
- Prototype an action plugin's configuration form and confirm it saves to the `action` config entity correctly.
