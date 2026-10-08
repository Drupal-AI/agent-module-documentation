<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Stripe Webform Payment adds a Webform element that takes a Stripe payment as part of a form submission, built on the Stripe base module.

---

Collecting a payment inside a form — a donation, a registration fee, an order — is a common need, and Webform is where many sites build such forms. This module adds a Stripe payment element to Webform: drop it into a form, and the submission collects a card payment through Stripe, using Stripe.js so card data goes directly to Stripe and never touches the Drupal server.

It builds on the contrib **Stripe** base module, and that division of responsibility matters for security. This module provides the Webform element and reads the configured keys — publishable, secret, and webhook secret; the actual Stripe API interaction and, critically, the **webhook signature verification** are handled by the Stripe base module's infrastructure, which is the correct place for them. That the module carries a webhook-secret getter confirms it is wired for signed webhooks rather than trusting unverified callbacks.

The security responsibilities that fall to the operator are the usual payment ones: the Stripe secret and webhook-signing secret are credentials that must be kept out of plain configuration and version control (a Key entity or environment), and the webhook endpoint (provided by the Stripe base module) must have its signing secret configured so forged payment-confirmation callbacks are rejected. Using Stripe.js means the site stays out of most PCI scope because card numbers never reach it — a genuine benefit worth preserving by not adding server-side card handling around it.

For taking payments on a Webform, it is the direct integration. Keep the keys secure, confirm the webhook is signature-verified, and let Stripe.js keep card data off the server.

---

- Take a payment on a webform.
- Collect a donation via Stripe.
- Charge a registration fee.
- Add a Stripe element to Webform.
- Process a card payment on submit.
- Keep card data off the server.
- Use Stripe.js for PCI scope.
- Configure Stripe keys securely.
- Verify Stripe webhooks.
- Keep the webhook secret out of git.
- Build a payment form.
- Reject forged payment callbacks.
- Take one-off payments.
- Integrate Webform and Stripe.
- Collect an order payment.
- Use the Stripe base module.
- Keep secrets in a Key entity.
- Charge a fee at submission.
- Confirm webhook signature verification.
- Accept card payments.
- Handle donations.
- Reduce PCI scope.