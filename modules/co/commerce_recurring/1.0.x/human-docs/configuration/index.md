# Configuration

Setting up recurring billing has three parts: create one or more **billing
schedules**, wire a **product** to subscriptions, and make sure **cron and the
queue** are running so renewals happen. There's also a set of admin permissions.

## Where the settings live

- **Subscriptions hub**: **Commerce → Configuration → Subscriptions**
  (`/admin/commerce/config/subscriptions`) — the landing page for subscription
  administration.
- **Billing schedules**: **Commerce → Configuration → Billing schedules**
  (`/admin/commerce/config/billing-schedules`) — add and edit schedules here.

## Create a billing schedule

A billing schedule is the reusable definition of *when and how* a subscription is
billed. Go to **Billing schedules → Add billing schedule** and fill in:

- **Label / machine name** — the admin name, plus a **display label** shown to
  customers.
- **Billing type**:
  - **Prepaid** *(default)* — charge for the *coming* period (pay now for the month
    ahead).
  - **Postpaid** — charge for the period that just *elapsed*.
- **Schedule plugin** — how the billing dates are calculated:
  - **Rolling** — the interval counts from each customer's own start date (sign up
    on the 12th, billed on the 12th).
  - **Fixed** — the interval is aligned to a calendar anchor. A fixed *monthly*
    schedule bills everyone on the same **day of the month**; a fixed *yearly* one
    uses a **start month** and **start day**.
- **Interval** — a number plus a unit (**day / week / month / year**), e.g. `1
  month`.
- **Trial interval** — optional. Set a non-empty trial (e.g. `14 days`) and new
  subscriptions begin in a **trial** state before the first charge; leave it empty
  for no trial.
- **Prorater** — how partial periods are priced:
  - **Proportional** — charge pro rata (half a month = half the price).
  - **None (always charge the full price)** — never prorate.
- **Retry schedule (dunning)** — the days after a failed payment on which to retry,
  as a sequence; the default is **1, 3, 5**.
- **Unpaid subscription state** — the state a subscription drops to once all
  retries are exhausted; the default is **canceled** (you can choose **expired**).
- **Combine subscriptions** — an option to bill multiple subscriptions that share a
  cycle on a single recurring order.

You can also create a schedule in code (it's a `commerce_billing_schedule` config
entity, so it exports and deploys with your config). The agent docs have a
`drush php:eval` example:
[`agent/configure/billing-schedules.md`](../../agent/configure/billing-schedules.md).

## Wire a product to subscriptions

A billing schedule on its own doesn't sell anything — you attach subscriptions to a
product. On the relevant **product variation type**'s edit form, enable the
subscription option and choose a **subscription type** (e.g. *product variation*)
and a **billing schedule**. Purchases of that product then use Commerce's recurring
order type, and buying it starts a subscription for the customer.

For subscriptions not backed by a catalog product, use the **standalone**
subscription type.

## The subscription lifecycle (what happens automatically)

Once customers have subscriptions, the module runs the billing cycle for you:

- **Cron** finds subscriptions and orders that are due and enqueues jobs into the
  `commerce_recurring` **Advanced Queue**.
- Those jobs **close** a recurring order at the end of its period (place it and
  attempt payment), **renew** it into the next period, and **activate**
  subscriptions when a trial ends.
- On a **declined** renewal payment, a "payment declined" email is sent and the
  schedule's **retry schedule** governs further attempts; once exhausted, the
  subscription moves to the **unpaid subscription state** you configured.

Subscriptions move through the states `pending → trial → active →
expired/canceled`. Because this all hangs off cron and the queue, **billing only
happens if cron runs and the queue is processed** — there are no Drush commands to
trigger it.

## Permissions

The module defines three administrative permissions (all security-sensitive):

| Permission | What it controls |
|---|---|
| **Administer commerce_billing_schedule** | Full create/edit/delete of billing schedules. |
| **Administer commerce_subscription** | Full administration of subscriptions; also guards the Subscriptions config hub. |
| **Administer commerce_subscription_type** | Manage subscription types (the subscription bundles). |

In addition, because subscriptions are content entities, Drupal generates the usual
per-operation permissions (view/update/delete own/any subscription). Check
**People → Permissions** (`/admin/people/permissions`) for the full generated set
on your site, and grant staff only what they need.
