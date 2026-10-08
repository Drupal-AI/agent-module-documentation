# Configuration

Commerce Registration is configured **per product** rather than through one central
settings form. You turn a Commerce product into a registration host and then manage
that product's registration settings and its registrations.

## Make a product sell registrations

1. Create or edit the Commerce **product** that represents the event, course, or
   workshop.
2. Go to that product's registration **settings** at
   `/product/{commerce_product}/registrations/settings` (replace
   `{commerce_product}` with the product's ID).
3. Configure the registration settings for the product — for example the
   registration type, capacity, and whether/when registration is open. These
   settings come from the base Registration module; consult its README for the full
   list and for the recommended way to configure it alongside Commerce.
4. Save.

## Manage registrations for a product

View and manage the registrations taken against a product at
`/product/{commerce_product}/registrations`. Access to these pages is decided by a
**custom access check** that considers both the product and the user — the right
model when the decision depends on which product is involved, not just a flat
site-wide permission.

## The purchase-to-registration lifecycle

Understanding the lifecycle helps avoid surprises with capacity:

- **Adding the product to the cart creates a registration.**
- **Completing checkout confirms it.**

Because a registration is created at add-to-cart, an **abandoned cart holds
capacity** until it expires. If capacity seems to "leak", check Commerce's **cart
expiry** settings — that is usually the cause.

## Waitlist and changing host (submodules)

If you enabled the submodules:

- **Waitlist** (`commerce_registration_waitlist`) — when an event reaches capacity,
  attendees can be placed on a waitlist and promoted automatically when a place
  opens up. Configure its behaviour on the product's registration settings.
- **Change Host** (`commerce_registration_change_host`) — lets an existing
  registration be moved to a different event/session without refunding and
  rebooking. Useful for anything with multiple sittings.

## Test before selling

Run a full purchase of a registration product, confirm the registration is created
at add-to-cart and confirmed at checkout, and verify capacity, waitlisting (if
enabled), and any per-attendee pricing behave as expected before opening sales.
