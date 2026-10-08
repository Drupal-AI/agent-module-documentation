# Working with invitations

## The invitation entity

An invitation is a `group_relationship` entity whose plugin is `group_invitation`. Relevant data:

- `gid` — the group id.
- `entity_id` — the invited **user** id (the relation's target entity type is `user`).
- `invitee_mail` — the invited email address (for not-yet-registered invitees).
- `invitation_status` — integer state, constants on
  `Drupal\ginvite\Plugin\Group\Relation\GroupInvitation`:
  - `INVITATION_PENDING = 0`
  - `INVITATION_ACCEPTED = 1`
  - `INVITATION_REJECTED = 2`
  - `INVITATION_EXPIRED = 3`

## Routes

| Route | Path | Purpose |
|---|---|---|
| `ginvite.invitation.bulk` | `/group/{group}/invite-members` | bulk invite form |
| `ginvite.invitation.bulk.confirm` | `/group/{group}/invite-members/confirm` | confirm bulk |
| `ginvite.invitation.accept` | `/ginvite/{group_relationship}/accept` | accept → membership |
| `ginvite.invitation.decline` | `/ginvite/{group_relationship}/decline` | decline |

The bulk routes require one of `bulk invite users to group` / `administer members` /
`administer group invitations` and the `group_invitation` content to be installed.

## Loader service

`ginvite.invitation_loader` (`Drupal\ginvite\GroupInvitationLoader`) wraps invitation relationships
in `Drupal\ginvite\GroupInvitation` objects:

```php
$loader = \Drupal::service('ginvite.invitation_loader');
$loader->load($group, $account);                 // the invitation for a user in a group, or FALSE
$loader->loadByGroup($group, $roles = NULL, $mail = NULL, $status = 0);  // pending by default
$loader->loadByProperties(['gid' => $group->id(), 'invitation_status' => 0]);
```

`ginvite.group_invitation_manager` and `ginvite.invitation_handler` (mail) are the other services.

## Create an invitation programmatically

An invitation is just a `group_relationship` of the `group_invitation` plugin. The robust way is via
the group's content enabler / relationship storage:

```php
$storage = \Drupal::entityTypeManager()->getStorage('group_relationship');
$invitation = $storage->create([
  'type'   => \Drupal\group\Entity\Storage\GroupRelationshipTypeStorageInterface::class
              ? $group_relationship_type_id : $group_relationship_type_id, // e.g. 'my_type-group_invitation'
  'gid'    => $group->id(),
  'entity_id' => $invited_user->id(),      // the target user
  'invitee_mail' => $invited_user->getEmail(),
  'invitation_status' => 0,                // pending
  'uid' => \Drupal::currentUser()->id(),   // inviter
]);
$invitation->save();
```

(The UI bulk form `BulkGroupInvitation` builds these for you and sends the emails.)

## Events

- `Drupal\ginvite\Event\UserRegisteredFromInvitationEvent`
- `Drupal\ginvite\Event\UserLoginWithInvitationEvent`

Dispatched by `GinviteSubscriber` during registration/login so other modules can react (e.g. custom
auto-accept or redirect logic).

## Duplicate prevention

`PreventDuplicatedConstraint` (validation) stops creating a second pending invitation for the same
group + invitee.
