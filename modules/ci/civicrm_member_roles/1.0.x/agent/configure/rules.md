# Association Rules: mapping membership → role

The mapping is a config entity type **`civicrm_member_role_rule`** (label "Association Rule",
class `Entity\CivicrmMemberRoleRule`). Each rule ties one CiviCRM membership **type** to one Drupal
**role**, with two sets of membership **statuses**: statuses that *add* the role and statuses that
*remove* it. Managed through `Form\CivicrmMemberRoleRuleForm` and listed by
`CivicrmMemberRoleRuleListBuilder`.

## Routes (all gated by `access civicrm member role setting`)

Provided by `CivicrmMemberRoleRuleHtmlRouteProvider` (extends `AdminHtmlRouteProvider`; the entity
`admin_permission` is `access civicrm member role setting`).

| Route name | Path |
|------------|------|
| `entity.civicrm_member_role_rule.collection` | `/admin/config/civicrm/civicrm-member-roles` (the `configure` link) |
| `entity.civicrm_member_role_rule.add_form` | `/admin/config/civicrm/civicrm-member-roles/rule/add` |
| `entity.civicrm_member_role_rule.canonical` | `.../rule/{civicrm_member_role_rule}` |
| `entity.civicrm_member_role_rule.edit_form` | `.../rule/{civicrm_member_role_rule}/edit` |
| `entity.civicrm_member_role_rule.delete_form` | `.../rule/{civicrm_member_role_rule}/delete` |

The collection page shows one row per rule: label, machine name, membership type, Drupal role,
"Add When Status Is", "Remove When Status Is".

## Stored fields (config_export)

Config object name: `civicrm_member_roles.civicrm_member_role_rule.<id>`.

| Field | Getter/Setter | Meaning |
|-------|---------------|---------|
| `id` | — (machine name) | Rule id. |
| `label` | `label()` | Human label. |
| `role` | `getRole()` / `setRole()` | Target Drupal role id. |
| `type` | `getType()` / `setType()` | CiviCRM membership type id. |
| `current` | `getCurrentStatuses()` / `setCurrentStatuses()` | Status ids that **add** the role ("Add Statuses", required). |
| `expired` | `getExpiredStatuses()` / `setExpiredStatuses()` | Status ids that **remove** the role ("Removal Statuses", required). |

Form details (`CivicrmMemberRoleRuleForm`): the membership-type `select` is populated from
`CivicrmMemberRoles::getTypes()`; the role `select` lists all roles except `anonymous` and
`authenticated`; both status checkbox sets come from `CivicrmMemberRoles::getStatuses()`. On save,
`current`/`expired` are `array_filter`ed (only checked ids stored) and the user is redirected to the
collection.

## What happens at sync time

`CivicrmMemberRoles::syncContact($cid, $account)` (see [api/services.md](../api/services.md)):
1. Loads all rules and the contact's CiviCRM memberships.
2. If the contact has multiple memberships, inactive ones (statuses `Deceased`, `Cancelled`,
   `Pending`, `Expired`) are dropped unless that status is also listed in a rule's `current` set
   (CRM-16000 handling).
3. If no memberships remain → every role used by any rule is removed from the user.
4. Otherwise → for each membership, rules whose `type` matches are checked: a `status_id` in the
   rule's `expired` list removes the role; a `status_id` in the rule's `current` list adds it
   (adds are applied after removals).
5. The user is saved only if the resulting role set differs.

## Create a rule via PHP

```php
use Drupal\civicrm_member_roles\Entity\CivicrmMemberRoleRule;

CivicrmMemberRoleRule::create([
  'id' => 'gold_member',
  'label' => 'Gold member',
  'type' => 2,            // CiviCRM membership type id
  'role' => 'member',     // Drupal role id
  'current' => [1, 2],    // status ids counting as "current" (add)
  'expired' => [3, 4],    // status ids counting as "expired" (remove)
])->save();
```

To map one membership type to several roles, create one rule per role. Multiple rules can grant a
single user several roles; each rule only ever manages the roles it names.
