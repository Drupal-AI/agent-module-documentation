# Configuration

Commerce Store Domain has no admin settings page. All the "configuration" is a
**Domain** field the module adds to each Commerce store, plus some automatic
behavior if you also run the contrib Domain module.

## Assign a domain to each store

1. Go to **Commerce → Configuration → Stores → Stores**
   (`/admin/commerce/config/stores`).
2. Edit the store you want to place on a domain.
3. In the **Domain** field, enter the hostname the store should answer on, for
   example `shopa.com`. Enter it as a bare host (no `https://`, no path).
4. Because the field is **multi‑value**, you can add more than one host to the
   same store — useful for aliases or subdomains such as `eu.example.com` and
   `us.example.com`. Add one host per value.
5. Save the store. Repeat for each store, giving each its own distinct domain(s).

From now on, on every request the module reads the visitor's hostname and makes
the store whose Domain field matches the **current store**. If no store matches,
Commerce falls back to its normal store resolution (for example the configured
default store), so nothing breaks on hosts you haven't mapped.

You still need to make those domains actually reach this site — point their DNS
and your web server / virtual host configuration at the same Drupal installation.

## Separate carts per store

Each domain's shopping cart is kept separate, so a cart started on one store's
domain does not carry over to another. This happens automatically; there is
nothing to configure.

## If you also use the contrib Domain module

When the **Domain** module (`drupal/domain`) is enabled, Commerce Store Domain
changes how it works, automatically:

- It adds a **Domain record** reference field (`domain_entity`) to the store, and
  the plain text Domain field is hidden on the form. Instead of typing a hostname,
  you **reference the Domain record** you have already set up in the Domain module.
- The current store is then resolved from Domain's own **active‑domain
  negotiation** rather than a raw hostname match, so store selection lines up with
  however you've configured Domain.
- The cart provider is swapped for a domain‑aware one so carts stay scoped to the
  current store.

To use this path: set up your domains in the Domain module first, then edit each
store and pick the matching Domain record in the reference field.

If you later uninstall the Domain module, the module cleans up after itself — the
`domain_entity` values are cleared and the field is removed, leaving the plain
Domain field in place again.

## Extending

There is no UI for advanced matching (wildcards, ports, and the like). A developer
can subclass the domain resolver to add custom matching rules — see the sibling
[`agent/`](../agent/start.md) docs for the resolver classes.
