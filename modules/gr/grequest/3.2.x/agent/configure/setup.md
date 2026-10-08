<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install & configure the membership-request relation

There is **no module settings form** (`configure: null`). You configure the feature by installing
the `group_membership_request` relation plugin on each group type, exactly like the core
"Group membership" relation.

## Via the UI

1. Go to *Administration › Groups › Group types* → your group type → **Set up content**
   (`/admin/group/types/manage/{group_type}/content`).
2. Install **"Group membership request"**.
3. On its config form the only extra option is **"Remove a group membership request, when user
   joins the group"** (config key `remove_group_membership_request`, default `FALSE`). Entity
   cardinality is forced to 1 and disabled.
4. Give the **outsider** role the `request group membership` permission and moderators the
   `administer membership requests` permission on the group type's *Permissions* page
   (see [permissions/group-permissions.md](../permissions/group-permissions.md)).

Outsiders then see a "Request membership" link on the group; admins moderate at
`/group/{group}/members-pending`.

## Via code / drush php:eval

```php
use Drupal\group\Entity\GroupType;
$gt = GroupType::load('my_group_type');
$storage = \Drupal::entityTypeManager()->getStorage('group_relationship_type');
$rt = $storage->createFromPlugin($gt, 'group_membership_request', [
  'remove_group_membership_request' => TRUE,   // optional
]);
$rt->save();
```

The created config entity is a `group_relationship_type` whose id is **not** a plain
concatenation — it is computed (and hashed if long). Get it with:

```php
$rtid = \Drupal::entityTypeManager()->getStorage('group_relationship_type')
  ->getRelationshipTypeId('my_group_type', 'group_membership_request');
// -> e.g. "my_group_type-<hash>"; load with GroupRelationshipType::load($rtid)
```

To read the remove option back:

```php
$rt->get('remove_group_membership_request'); // bool, stored under the plugin config
```

## Requirements

The group type also needs the core **`group_membership`** relation installed, so approved
requests can be turned into real memberships. The optional view
`views.view.group_pending_members` provides the pending queue page.
