# Configuration

Membership Manager needs a little setup before it does anything useful: create
at least one plan, grant the right permissions, and then decide which routes (or
features) a membership unlocks.

## Create your first plan

1. Log in as a user with the **Administer membership plans** permission (an
   administrator by default).
2. Go to **`/admin/membership`** and create a new plan.
3. Plans come in three flavours — **free**, **paid**, and **trial**. Plans are
   stored as configuration entities, so they can be exported with your site's
   configuration and moved between environments.

Because the module is payment-agnostic, a "paid" plan does not itself collect
money. Payment happens in whatever system you use (Drupal Commerce, Stripe,
PayPal, or a custom backend); after a successful payment you assign the
membership to the user (see "Assigning memberships" below).

## The membership lifecycle

A user's membership is a content entity that moves through a lifecycle:

- **Pending** — created but not yet active.
- **Trial** — an active trial period.
- **Active** — a current, valid membership.
- **Expired** — past its end date (after any grace period).
- **Canceled** — ended deliberately.

Expiration is time-based with a **configurable grace period**, and expiries are
processed by Drupal's cron via the Queue API — so make sure cron runs regularly
on your site. As memberships activate and expire, the module can **synchronise
Drupal roles**, so you can keep a "Member" role in step with active membership.

## Permissions

Grant these under **People → Permissions** (`/admin/people/permissions`). Keep
the administer permissions to trusted staff only:

- **Administer membership plans** (`administer membership plans`) — create and
  manage the plans themselves.
- **Administer memberships** (`administer memberships`) and **Administer
  Membership Manager** (`administer membership manager`) — manage individual
  users' memberships and the module overall.
- **View own membership** (`view own membership`) — a self-service permission so
  members can see their own status. Grant this to your authenticated/member
  roles.

## Protecting routes by membership

The core of the module's access control is a route requirement you add to any
route:

- `_membership_active: 'TRUE'` — the route is available only to users with an
  active membership.
- `_membership_active: 'feature:api_access'` — scope access to a named
  feature/entitlement key defined on the plan, so different plans can unlock
  different features.

Access decisions are cacheable and respect Drupal cache contexts. Note that
this requirement is set in a module's or subtheme's `*.routing.yml` (or via a
route subscriber), not through a UI form — it is the mechanism a developer uses
to gate custom routes.

## Assigning memberships from your payment flow

When a payment succeeds in your billing system, assign or renew the membership
by calling the module's service, `MembershipManagerService::assign()`, from your
integration code (a Commerce order event, a Stripe webhook handler, an ECA/Rules
action, and so on). The module also fires lifecycle **events** — activated,
expired, canceled, renewed — that other modules can subscribe to, so you can
trigger emails or downstream actions without patching the module.
