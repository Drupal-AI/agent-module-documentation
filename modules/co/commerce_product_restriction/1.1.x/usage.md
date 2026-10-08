<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Product Restrictions lets you attach pluggable purchase restrictions to products and variations through a dedicated field: allow buying only within a date range, only for certain roles or named users, only after a password is entered, only if the customer already bought (or has not bought) another product, or up to a maximum quantity. Each restriction shows a configurable message explaining why the product cannot be purchased.

---

Install and enable the module (depends on commerce and commerce_cart). Add a 'Product restriction' plugin field to your product or variation types, then configure one or more restriction plugins per product. The module ships restriction plugins (Dates, UserRole, User, Password, PurchaseQuantity, PurchasedProduct/Variation) and a plugin manager so you can add your own. Restrictions are evaluated by an availability checker and surfaced by disabling the add-to-cart / checkout button with the restriction message. Note: the availability-checker service tag is currently commented out, so enforcement is form-level -- review the agent notes before relying on it for hard access control.

---

- Restrict product purchase with pluggable rules.
- Limit sales to a start/end date range.
- Limit purchase to selected user roles.
- Limit purchase to specific named users.
- Require a password to buy a product.
- Restrict by prior purchase of another product.
- Restrict by prior purchase of a variation.
- Cap the purchasable quantity.
- Attach restrictions via a plugin field.
- Configure a custom message per restriction.
- Disable add-to-cart when a rule fails.
- Disable checkout when a cart item is restricted.
- Provide a ProductRestriction plugin type and manager.
- Extend with custom restriction plugins.
- Evaluate restrictions through an availability checker.
- Combine multiple restrictions on one product.
