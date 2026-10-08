<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `commerce_stripe.permissions.yml`:

- **`administer commerce stripe`** (`restrict access: true`) — access the global Stripe settings
  form (`/admin/commerce/config/stripe`) and the Stripe Connect connect/disconnect forms.
- **`view stripe dashboard links`** — see links that open the related object in the Stripe
  dashboard (works together with the `link_payments_remote_id` setting).

Creating/editing the payment **gateway** entities themselves is gated by Commerce's own
`administer commerce_payment_gateway` permission (used by the Stripe Connect OAuth return route).
