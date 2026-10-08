<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Groups, group content and `og.settings`

## Declare a bundle a group

```php
use Drupal\og\Og;

Og::groupTypeManager()->addGroup('node', 'club');   // or Og::addGroup('node', 'club')
Og::groupTypeManager()->removeGroup('node', 'club');
Og::isGroup('node', 'club');                        // bool
```

Effects, all verifiable:

- `og.settings:groups.node` gains `club`
  (`drush cget og.settings groups`).
- Three `OgRole` config entities appear:
  `og.og_role.node-club-member`, `…-non-member` (both `role_type: required`),
  `…-administrator` (`is_admin: true`, `role_type: standard`).
  Default permissions come from the `og.permission` event — out of the box `non-member` gets
  `subscribe`, and everything the administrator needs is implied by `is_admin`.
- Routes are rebuilt so the group's admin tabs (`/group/{entity_type_id}/{group}/admin/…`) exist.

## Declare a bundle group content (attach the audience field)

```php
use Drupal\og\Og;
use Drupal\og\OgGroupAudienceHelperInterface;

Og::createField(OgGroupAudienceHelperInterface::DEFAULT_FIELD, 'node', 'post');
```

`DEFAULT_FIELD` is the string `og_audience` — the field name defaults to the OgFields plugin id.
The call creates, if missing:

| Config | Value |
|---|---|
| `field.storage.node.og_audience` | type `og_standard_reference`, `cardinality: -1`, `settings.target_type: node`, `module: og` |
| `field.field.node.post.og_audience` | label "Groups audience", `settings.handler: 'og:default'` |
| `core.entity_form_display.node.post.default` | component for `og_audience` |
| `core.entity_view_display.node.post.default` | component for `og_audience` |

Pass overrides via the 4th argument
(`['field_name' => 'field_my_groups', 'field_storage_config' => [...], 'field_config' => [...],
'form_display' => [...], 'view_display' => [...]]`) to use a different field name or to point
the audience at another entity type (`settings.target_type`).

`Og::isGroupContent('node', 'post')` returns TRUE once any audience field exists on the bundle;
`\Drupal::service('og.group_audience_helper')->getAllGroupAudienceFields('node', 'post')` lists them.

The second OgFields plugin, `og_access`, adds the group-visibility field and can only be
attached to nodes.

## Membership types

`og_membership_type` is the bundle entity of `og_membership`; OG ships one bundle, `default`
(`og.og_membership_type.default`). Extra bundles are created at
`/admin/structure/membership-types/add` (route `og_membership.type_add`). Per group bundle you
can pick which membership type new memberships get:

```php
$gtm = \Drupal::service('og.group_type_manager');
$gtm->setGroupDefaultMembershipType('node', 'club', 'premium');
$gtm->getGroupDefaultMembershipType('node', 'club');   // 'default' when unset
$gtm->removeGroupDefaultMembershipType('node', 'club');
```

Stored in `og.settings:group_membership_types`.

## `og.settings` reference

```yaml
groups:                       # {entity_type: [bundle, …]} — the group registry
  node:
    - club
group_membership_types: {}    # per group bundle default og_membership_type
group_manager_full_access: true   # the group owner has every permission in their group
node_access_strict: true      # OG access overrides core's global node CRUD permissions
delete_orphans: false         # delete group content when its group is deleted
delete_orphans_plugin_id: simple   # simple | batch | cron  (OgDeleteOrphans plugins)
deny_subscribe_without_approval: true  # joining a private group is always pending
group_resolvers:              # ordered OgGroupResolver plugin ids used for group context
  - route_group
  - route_group_content
  - request_query_argument
  - user_access
auto_add_group_owner_membership: true  # creating a group makes you a member of it
```

Read/write with `drush cget og.settings` / `drush cset og.settings <key> <value> -y`, or through
the `og_ui` settings form at `/admin/config/group/settings`.

Orphan deletion with the `batch`/`cron` plugins pushes items onto the
`og_orphaned_group_content` queue (cron worker id `og_orphaned_group_content_cron`), so
`drush queue:run og_orphaned_group_content` processes them.

## Verifying a setup from the shell

```bash
drush cget og.settings groups
drush php:eval 'print json_encode(array_keys(\Drupal::entityTypeManager()->getStorage("og_role")->loadMultiple()));'
drush php:eval 'print (int) \Drupal\og\Og::isGroup("node", "club");'
drush php:eval 'print (int) \Drupal\og\Og::isGroupContent("node", "post");'
```
