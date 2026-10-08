<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `commerce_recurring.permissions.yml` (all `restrict access: TRUE`, i.e. security-
sensitive admin permissions):

| Permission | Gates |
|---|---|
| `administer commerce_billing_schedule` | Full CRUD of billing schedule config entities (`/admin/commerce/config/billing-schedules`); also the `admin_permission` of the `commerce_billing_schedule` entity. |
| `administer commerce_subscription` | Full administration of subscriptions; guards the Subscriptions config hub route (`commerce_recurring.configuration`, `/admin/commerce/config/subscriptions`) and is the subscription entity `admin_permission`. |
| `administer commerce_subscription_type` | Manage subscription types (bundles), including the per-type admin overview route. |

In addition, the `commerce_subscription` entity uses the `entity` module's
`EntityPermissionProvider` / a `SubscriptionPermissionProvider`, which generates the usual
granular per-operation permissions (view/update/delete own/any subscription) beyond the blanket
`administer commerce_subscription`. Check the live permissions list
(`drush role:perm:list` or `/admin/people/permissions`) for the generated set on a given site.
