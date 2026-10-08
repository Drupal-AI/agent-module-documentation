# Configuration

Getting Subscription Manager running is a short sequence: choose a connector,
create your plans, grant the right permissions, and point members at the
self-service links.

## Open the settings form

1. Log in as a user with the **Administer subscription manager** permission (an
   administrator by default).
2. Go to **Configuration → Web services → Subscription Manager**, or navigate
   directly to `/admin/config/services/subscription_manager`.

## Set the default connector

On the admin form, choose the **default connector** — the connector plugin (from
the connector module you installed) that Subscription Manager should use. Each
individual Subscription entity also remembers which connector created it; if that
connector is ever uninstalled, the module falls back to this default so members'
links keep working. This is also where the redirect target for the member-facing
"my subscriptions" link is configured.

## Create subscription plans

Create **Subscription Plan** entities to describe the tiers you offer. A plan is
the local record of a purchasable option that, once subscribed, grants the Drupal
role(s) you associate with it — which in turn grant the permissions that gate your
paid content or features.

## Grant permissions

At **People → Permissions** (`/admin/people/permissions`), grant the permissions
each audience needs. All the administrative ones are marked *restrict access* —
hand them out carefully:

| Permission | Give it to… |
|------------|-------------|
| **Manage own subscriptions** (`manage own subscriptions`) | Regular members, so they can open the hosted billing portal and manage their own plan. |
| **Administer subscriptions** (`administer subscriptions`) | Support staff who need to manage *any* user's subscription. |
| **Administer subscription plans** | Staff who create and edit the plan tiers. |
| **Administer subscription manager** | Administrators configuring the module itself. |

The member-facing routes also require the user to be **logged in**, and the "manage
subscription" route additionally checks that the user owns the subscription they are
trying to manage — so a member cannot reach another member's billing portal.

## The member-facing links

- **`/user/my-subscriptions`** — a member opens this to reach their subscription;
  it redirects to the manage route you configured.
- **`/user/{user}/manage-subscription`** — redirects the (owning) member to the
  provider's hosted billing portal.
- **`/subscription-manager/subscribe`** — redirects a new buyer to the provider's
  checkout.

The subscribe page title changes automatically between an "Upgrade" and a "Join"
style label depending on whether the user already has a subscription.

## JSON API for decoupled front ends

If you run a headless or JavaScript front end, three GET endpoints return JSON:

- `/subscription-manager/api/my-subscription` — the current user's subscription and
  plan.
- `/subscription-manager/api/portal-url` — the provider portal URL (plus whether
  the user has a subscription).
- `/subscription-manager/api/subscribe-url` — the subscribe/checkout URL.

## Views and Drush

Two Views fields are provided for building subscription listings — a **remote
status** column and a **will renew** column. A set of **Drush commands** is also
available to inspect and reconcile subscriptions.

## Writing your own connector

If no existing connector fits your provider, you can write one: create a connector
plugin implementing the portal and subscribe redirects to the provider's hosted
pages. One security rule matters here — if your connector exposes a public
post-purchase return URL keyed by an order id, **never auto-login on a bare order
id**. Use the module's post-purchase token service to mint and verify a signed,
expiring token instead; that is exactly what protects the built-in flow.
