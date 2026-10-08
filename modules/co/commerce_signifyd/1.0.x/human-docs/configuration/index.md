# Configuration

Commerce Signifyd does nothing until you connect it to your Signifyd account, so plan on
working through all of the steps below. You will (1) store your Signifyd API key securely,
(2) set the global decision behavior, (3) add a Signifyd team, (4) register the webhook in
the Signifyd dashboard, and (5) choose which workflow transitions fire automatically.

## Handle the Signifyd API key securely

Your Signifyd API key is a secret — treat it like a password. The recommended way to keep
secrets out of your codebase and exported configuration is to put the value in an
environment variable and, where a module supports it, reference it through a **Key** entity
rather than pasting it into a form that gets exported to config.

With DDEV, store the value in the container's environment:

```bash
ddev dotenv set .ddev/.env --signifyd-api-key=<your-key>
ddev restart
```

Keep `.ddev/.env` out of version control. If you install the
[Key](https://www.drupal.org/project/key) module (`ddev composer require drupal/key`,
`ddev drush en key -y`), you can create a Key backed by that environment variable and,
where the field offers a Key selector, point the Signifyd team at it. If you enter the key
directly into the team entity instead, make sure that entity is not committed to a public
configuration export.

## Global settings

Go to **Commerce → Configuration → Signifyd settings**
(`/admin/commerce/config/signifyd/settings`). Here you set how Signifyd's results drive
your orders:

- **Decision type** — choose what Signifyd signal the module acts on: the numeric **score**,
  the Signifyd **decision** (ACCEPT / REJECT), or the **guarantee** disposition. This
  determines which field is consulted when deciding whether to approve or decline an order.
- **Score threshold** — when the decision type is *score*, this is the cut-off used to
  separate approved from declined orders.
- **Request logging** — turn this on while you are setting things up to record the webhook
  traffic for debugging; turn it off in production once everything works.
- **Per-order-type workflow** — for each order type you can enable a **workflow** and then
  pick the **approved** and **declined** transition IDs. When Signifyd's result comes back,
  the module applies the matching transition (only if that transition is actually allowed
  for the order's current state).

## Add a Signifyd team

Signifyd organises access into "teams", each with its own API key. Create a Signifyd team
configuration entity and enter its API key (see the secret-handling note above). You can
add multiple teams — the webhook URL includes the team ID so Signifyd's callbacks are
matched to the right team.

## Register the webhook in the Signifyd dashboard

In your Signifyd dashboard, add a webhook pointing at:

```
https://your-site.example/webhook/signifyd/{signifyd_team}
```

Replace `{signifyd_team}` with the ID of the team you created. Signifyd signs every webhook
POST, and the module verifies it before changing anything.

**How the webhook is secured.** The endpoint is technically open (`_access: TRUE`), but it
authenticates every request itself: it recomputes an HMAC-SHA256 of the raw request body
using the team's API key and compares it to the `X-SIGNIFYD-SEC-HMAC-SHA256` header. A
request with an empty body, a missing signature, or a signature that does not match is
rejected with an HTTP 400 **before any case is created or any order is transitioned**. The
only exception is Signifyd's documented `cases/test` topic, which is allowed with the
placeholder key `ABCDE`; that topic carries no real case, so it cannot change a live order.
This design is sound — order state is only ever changed on a request that Signifyd could
have signed with your secret key.

## How orders flow through it

Once configured, the module reacts to the order lifecycle: placing an order creates a
Signifyd case, fulfilling an order sends fulfillment data, and cancelling an order is
handled too. Incoming webhooks (`cases/creation`, `cases/rescore`, `cases/review`,
`cases/decision`) update the stored case with the latest score, guarantee, and decision,
and — if you enabled workflow for that order type — move the order via the approved or
declined transition you configured. You can also react to updates programmatically by
subscribing to `SignifydEvents::SIGNIFYD_WEBHOOK`.

## Save and test

After registering the webhook, use Signifyd's `cases/test` webhook to confirm the wiring
end-to-end without touching a real order. Then place a test order and check the Signifyd
cases view to confirm a case was created and scored.
