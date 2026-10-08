# Configuration

Commerce Make-to-Order does nothing until you create at least one **MTO order
type**. An MTO order type ties together the production workflow, the numbering,
the Commerce order state that starts production, and how completion flows back to
the Commerce order.

## Create an MTO order type

1. Log in as a user who can administer Commerce (and MTO orders — see
   Permissions below).
2. Go to **Commerce → Configuration → MTO order types**
   (`/admin/commerce/config/mto-order-types`).
3. Add an MTO order type and configure its settings:
   - **Production workflow** — choose the State Machine workflow the production
     orders follow. The bundled workflow runs Draft → Queued → Waiting for
     Materials → In Production → Quality Check → Rework → Completed (with a
     Canceled path).
   - **Number pattern** — pick the Commerce Number Pattern that generates
     production order numbers (for example `MTO-2026-00001`).
   - **Trigger state** — the Commerce order state that causes the module to
     automatically create one production order per order item. When an order
     reaches this state, production begins.
   - **Completion / sync mode** — how a finished production order updates the
     parent Commerce order. There are two modes:
     - **Direct state sync** — the module advances the Commerce order's state
       directly when production completes.
     - **Shipment integration** — (requires Commerce Shipping) production orders
       link to the checkout shipment, and the Commerce order is promoted to a
       ready state only when all of them complete.
   - **Hold states** — optionally list Commerce order states that automatic
     promotion must never override; when the order is in a hold state, the module
     logs a note instead of promoting it.

Save the order type. From then on, qualifying orders will spin up production
orders automatically, and your team works them from the listing at
**Commerce → MTO orders** (`/admin/commerce/mto-orders`), with analytics at
`/admin/commerce/mto-orders/analytics`.

## Permissions

This module ships a rich permission set, and you should grant it carefully at
**People → Permissions** (`/admin/people/permissions`). The permissions separate
day-to-day production work from administration:

- **Administer MTO orders** — full control, including the order-type
  configuration above. Reserve for site administrators.
- **View / create / update / delete — "any" vs "own"** — the "any" variants let a
  user act on every production order, while the "own" variants scope a user to
  their own. Grant "any" only to production staff.
- **Transition MTO orders** — allows moving a production order through the
  workflow (Queued → In Production, and so on). Grant to the team members who run
  the shop floor.
- **Cancel MTO orders**, **view analytics**, and the **notes** permissions round
  out the set.

As a rule, keep the `administer`, `any`, and `transition` permissions limited to
trusted production staff, and give everyone else only the "own" or view
permissions they need.

## Notes and notifications

Each production order supports internal notes, transition notes, and team notes,
and notes can optionally trigger an email notification — useful for keeping the
production team and, where appropriate, the customer informed as work moves
through the workflow.
