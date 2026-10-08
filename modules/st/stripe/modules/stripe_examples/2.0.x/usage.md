Stripe examples is a demonstration submodule showing a complete Stripe checkout in Drupal: a simple checkout form, a block that renders it, and an event subscriber that sets the amount.

---

This submodule is a reference implementation for the parent Stripe module, meant to be read
and copied rather than run in production. It provides a `SimpleCheckoutForm`
(`stripe_examples_simple_checkout`) at `/stripe_examples/form/simple_checkout` that embeds a
Stripe payment element and walks through creating and confirming a PaymentIntent. A
`SimpleCheckoutBlock` (block id `stripe_example_checkout`) renders that form so it can be placed
in any region, and a menu link exposes the form page. Its `StripeExamplesEventSubscriber`
listens on `StripeEvents::PAYMENT` and, for the example form, calls `$event->setTotal(2500, …)`
to demonstrate server-side control of the charge amount. It ships a small CSS/JS library and a
Twig template (`stripe-examples-simple-checkout.html.twig`). Enable it on a test site with test
API keys to see an end-to-end Stripe payment flow, then use the same patterns (element, block,
PAYMENT/WEBHOOK subscribers) in your own module.

---

- See a working Stripe checkout form end to end on a test site.
- Learn how to embed the `stripe` payment element in a custom Form API form.
- Copy the pattern for creating and confirming a PaymentIntent from Drupal.
- Learn how to set the charge amount server-side via a StripeEvents::PAYMENT subscriber.
- Place a ready-made checkout block (`stripe_example_checkout`) on a page to test payments.
- Use `/stripe_examples/form/simple_checkout` to verify your Stripe test keys work.
- Reference the Twig template for styling a Stripe checkout form.
- Study the CSS/JS wiring for the client-side Stripe.js confirmation.
- Bootstrap a proof-of-concept payment page without writing checkout code first.
- Demonstrate Apple/Google Pay by swapping in the payment-request element.
- Test webhook handling by completing a real test-mode payment.
- Show stakeholders a live Stripe payment demo inside Drupal.
- Validate the parent module's configuration (keys, environment) is correct.
- Use as a template for a donation or one-off-payment form.
- Understand how the block plugin renders an embedded form.
- Compare your own checkout implementation against a known-good example.
- Teach new developers the Stripe module's moving parts in one place.
- Verify the PAYMENT event overrides the amount as expected (fixed 2500).
- Provide a quick manual QA path for the Stripe integration after upgrades.
- Scaffold a custom checkout by cloning and renaming the example form/block.
