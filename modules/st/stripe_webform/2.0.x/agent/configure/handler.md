# The `stripe` Webform handler

Source: `src/Plugin/WebformHandler/StripeWebformHandler.php` — `@WebformHandler(id = "stripe")`,
cardinality SINGLE. Add it to a webform under *Settings → Emails / Handlers → Add handler → Stripe*.

## Configuration form fields (`buildConfigurationForm`)

| Setting | Widget | Notes |
|---|---|---|
| `amount` | textfield (required) | Amount to charge. Tokens allowed. |
| `price_id` | textfield | Stripe subscription **Price ID**; presence triggers a subscription instead of a one-off charge. Tokens allowed. |
| `quantity` | textfield | Subscription quantity (defaults to 1). Tokens allowed. |
| `metadata` | codemirror (YAML) | Extra Stripe metadata (`key: value` per line). Tokens allowed. |
| `stripe_customer_create` | codemirror (YAML) | Extra fields merged into the Stripe `customers->create` call (cannot override keys set by the handler). |
| `stripe_subscription_create` | codemirror (YAML) | Extra fields merged into the `subscriptions->create` call. |

`currency` also exists in `defaultConfiguration()` (default `usd`). All handler config requires the
Webform *administer* / *configure* permission — i.e. a trusted form builder.

## Runtime flow (`postSave`, only on new submissions)

1. Skips if `$update` is TRUE (edits) or if no Stripe element reported `processed` data.
2. Reads the site uuid (`system.site`) and the **secret key**
   `stripe.settings: apikey.<environment>.secret` (owned/configured by the base `stripe` module).
3. Replaces tokens across the handler config (`webform.token_manager`).
4. `new StripeClient($secret)` → retrieves the PaymentIntent and PaymentMethod from the submitted
   `payment_intent` id.
5. Creates a **Customer** with billing name/email/address from the PaymentMethod + metadata
   `{uuid, webform, webform_id, webform_submission_id}` (+ any YAML metadata / customer-create fields).
6. If the element enabled subscriptions and a `price_id` is set: retrieves the Price, computes the
   billing-cycle anchor, and creates a **Subscription** (`proration_behavior: none`).
7. Stripe SDK exceptions are caught and shown as a form error message.

## Notes for agents

- The handler never stores the API key itself; it reads it from `stripe.settings`. Manage keys in the
  base Stripe module (its config / a Key entity), not here.
- Because the charge/PaymentIntent is created client-side, the handler's job is post-charge object
  creation (Customer/Subscription), not the charge itself.
- The template `templates/webform-handler-stripe-summary.html.twig` renders the handler summary in the
  handlers list.
