# Stripe examples — agent index

A **demo/reference** submodule for the Stripe module: a working checkout form, a block that
renders it, and an event subscriber that sets the amount. Read it to learn the patterns; it
has no configuration of its own.

- **The example form, block, route, and the PAYMENT event subscriber (copyable patterns)** →
  [api/example-flow.md](api/example-flow.md)

Key facts:
- Form `stripe_examples_simple_checkout` (`SimpleCheckoutForm`) at
  `/stripe_examples/form/simple_checkout`.
- Block id `stripe_example_checkout` (`SimpleCheckoutBlock`) renders that form.
- `StripeExamplesEventSubscriber` subscribes to `StripeEvents::PAYMENT` and calls
  `setTotal(2500, …)` for the example form.
- Depends on `stripe`. Enable with test keys to try a full payment flow.
