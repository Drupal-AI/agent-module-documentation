Bridges Drupal Commerce and CRM Membership so that placing an order containing a membership product automatically creates or renews a CRM membership for the order customer.

---

CRM Membership Commerce is a small event-driven glue module. It subscribes to the Commerce `commerce_order.place.post_transition` workflow event and, for each order item whose purchased product variation references a CRM Membership Type, creates a new membership (activated immediately) or renews an existing active/expired membership of that type for the customer's CRM contact. Field discovery is dynamic: rather than hardcoding field names, the `MembershipCommerce` service inspects the variation's field definitions to find the first entity-reference field targeting `crm_membership_type` (required) and, optionally, one targeting `crm_contact` (a per-product target-contact override). The member contact is resolved from the order's customer through the CRM user-to-contact mapping, creating a contact for the user if none exists yet. The module ships an optional default Commerce configuration — a "membership" product variation type, order item type, and order type, plus two entity-reference fields (`field_membership_type`, `field_target_contact`) — as a ready-to-use starting point, but any variation bundle with the required reference field works. It provides no routes, permissions, forms, Drush commands, or config schema of its own.

---

- Sell an annual membership as a Commerce product and have the CRM membership created automatically on checkout completion.
- Renew a member's existing membership when they purchase the same membership product again, instead of creating a duplicate.
- Offer multiple membership tiers as separate products/variations, each referencing a different CRM Membership Type.
- Use the shipped "membership" product variation type to get started without building fields manually.
- Attach membership selling to an existing custom product variation bundle by adding an entity-reference field targeting `crm_membership_type`.
- Override the target organization a member joins on a per-product basis via a `crm_contact` reference field on the variation.
- Fall back to the membership type's `default_target_contact` when a product does not specify a target contact override.
- Automatically create a CRM contact for a customer who does not yet have one when they buy a membership.
- Map an authenticated Commerce customer to their existing CRM contact so purchases update the right member record.
- Let non-membership products coexist in the same order — order items without a membership-type reference field are skipped.
- Activate the membership term (start/end dates) immediately on creation via the membership type's term plugin.
- Sell gift or third-party memberships where the buyer differs from the organization/target the membership is attached to.
- Support both rolling and fixed membership terms, since term behavior is delegated to CRM Membership's term plugin `renew()`/`activate()`.
- Trigger membership provisioning only when the order actually reaches the "placed" state, aligning membership start with order completion.
- Combine membership purchases with the rest of a Commerce catalog in a single storefront and checkout flow.
- Programmatically create/renew a membership from an order item by calling `MembershipCommerceInterface::createOrRenewFromOrderItem()` from custom code.
- Process an entire order's membership items in one call via `MembershipCommerceInterface::processOrder()`.
- Diagnose misconfiguration through the module's `crm_membership_commerce` logger channel (empty membership field, missing target contact, anonymous order, unresolvable contact).
- Prefer an existing active membership over an expired one when deciding which record to renew.
- Keep membership provisioning decoupled from payment specifics — any order that transitions to placed drives the logic, regardless of gateway.
