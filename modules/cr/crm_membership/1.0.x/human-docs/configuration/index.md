# Configuration

Setting up CRM Membership follows a natural order: create the membership types your
organization offers (each with a term rule), then add memberships against them from the
CRM portal, and finally rely on cron and the renew form to keep them current.

## Create membership types

1. Log in as an administrator (or a user with the membership-type permissions).
2. Go to **Structure → CRM → Membership Types**
   (`entity.crm_membership_type.collection`).
3. Add a membership type. Each type is a config bundle where you choose a **term
   plugin** and its settings, and optionally set a **default target contact** — the
   organization or household applied to new memberships that do not specify their own
   target.

### Choosing a term plugin

Three term plugins ship with the module:

- **Fixed Duration** — a fixed calendar term (for example one year, `P1Y`). May allow
  overriding the start/end dates and a time gap.
- **Rolling Duration** — each new period starts from the end of the previous active
  period, so renewals stack on rather than resetting to "now".
- **Lifetime** — never expires; renewal and expiry are effectively disabled.

Common plugin settings include the **duration** (an ISO-8601 period such as `P1Y`) and
a **grace period** (extra days past a period's end during which the member still counts
as active). Developers can add custom term plugins for project-specific rules.

## Add and manage memberships

Add memberships from the CRM portal's **Memberships** page (`/crm/membership`). On each
membership you set the member **contacts** and the **target contact** (whom they are a
member of). Status — active, future, or expired — is managed automatically as periods
are added and expired, so you generally do not set it by hand.

## Renewal

Renewal is a **manual** action. Each membership has a renew form at
`/crm/membership/{id}/renew`, gated by the **Renew memberships** permission. Renewing
adds a new membership period using the type's term plugin. Grant the renew permission
to whichever role handles renewals.

## Automatic expiration

Expiration is handled by **cron**. A cron job finds active memberships whose periods
have all lapsed (or which have no current period) and queues them; a queue worker then
marks each expired via its term plugin. Make sure cron runs regularly, or memberships
will not expire on schedule.

## Viewing periods

You can review all the periods recorded for a membership at
`/admin/content/crm/membership/{id}/all-periods` (this listing uses Views and requires
the **View memberships** permission).

## Permissions

The module enforces access through granular permissions — **view**, **edit**,
**renew**, and **delete** memberships, plus permissions to manage membership types —
with **Administer CRM membership** as an admin override. Unpublished memberships are
visible only to administrators. Grant these permissions to match who in your
organization should see and manage membership data.
