<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Better Product Variation Label improves Drupal Commerce product variation labels/titles.

---

Commerce Better Product Variation Label **improves Commerce product variation labels/titles**. Its
one shipped feature: for the product-variation types you choose, it **prefixes each variation's label
with the parent product's label** (when the two differ), so variations read more clearly in carts,
orders and admin lists. It also provides a `:label` token for `commerce_product_variation`. It
depends on Commerce Product and changes only how variation titles are generated — no content or
access role.

Note: it does not build titles from attribute values or a custom pattern; the only transformation is
the parent-product-label prefix, with a configurable separator.

---

- Improve variation labels/titles.
- Prefix the variation label with the parent product label.
- Apply it per product-variation type.
- Configure the prefix separator (default a space).
- Provide a `:label` token for commerce_product_variation.
- Clarify carts, orders and admin lists.
- Depend on Commerce Product.
- Serve e-commerce.
- Override the variation entity label() only.
- Have no content or access role.
- Fall back to the default label when not enabled.
- Skip the prefix when parent and variation labels match.
- Store settings as variation-type third-party settings.
- Add no settings page of its own.
- Add no permissions of its own.
- Configure it on the product variation type form.
