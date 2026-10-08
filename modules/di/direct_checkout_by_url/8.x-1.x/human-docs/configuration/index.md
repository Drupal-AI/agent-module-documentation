# Configuration

Most of the "configuration" for Direct checkout by URL is really about **who is
allowed to use it** and **how you build the links you hand out**. The module
exposes a settings form (route `direct_checkout_by_url.settings`) behind the
**Administer direct checkout by URL** permission, and the endpoint itself behind a
separate use permission.

## Grant the permissions

Go to **People → Permissions** (`/admin/people/permissions`) and set two
permissions:

- **Use direct checkout** (`use direct checkout`) — grant this to the roles whose
  members should be able to open a direct-checkout link and have their cart built.
  For public campaign links this typically includes the **Anonymous user** role.
- **Administer direct checkout by URL** (`administer direct checkout by url`) —
  grant this only to trusted administrators who manage the module's settings.

> **Note on the permission definition.** The administrative permission is declared
> in a way that means Drupal does not flag it with the usual "restricted" warning
> on the permissions page. The effect is cosmetic — the permission still has to be
> granted deliberately — but do not read the absence of a warning as a sign that
> the permission is harmless. Treat it as a sensitive administrative permission.

## Build links safely

The real design work is in the links themselves. Two rules keep you out of
trouble:

- **Never trust the link for price or discount.** A URL that fills a cart is a URL
  anyone can copy, edit, and share. Prices, quantities, and any promotion must be
  resolved server-side from the product and from Commerce's own promotion rules —
  never taken from values embedded in the link.
- **Assume every link is permanent and public.** Campaign links get forwarded,
  screenshotted, and archived. A link that grants a discount is a discount code
  with no expiry unless you build the expiry in (for example with a time-limited
  Commerce promotion rather than something encoded in the URL).

## Redirect target

By default the endpoint forwards to the checkout page. To send visitors somewhere
else, append Drupal's standard `destination` query parameter to the link — for
example `?products=123&destination=cart` lands them on the cart page instead of
checkout.
