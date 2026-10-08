<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Shipping Best Rate groups configured shipping services into one checkout option priced at the cheapest of them.

---

Commerce Shipping Best Rate adds a Drupal Commerce shipping method plugin, **`best_rate`**, that
**groups several configured shipping services into a single checkout option and prices it at the cheapest
of them**. For example "UPS Ground", "FedEx Ground" and "USPS Ground" collapse into one line — "Ground
3–5 days" — priced at whichever is lowest. The lowest amount is chosen **server-side** from the rates the
source shipping methods computed; an event subscriber removes the grouped source rates from the customer's
list and fills the best-rate option's price. It depends on Commerce Shipping, in the Commerce (shipping)
package.

Use it to simplify shipping choices at checkout and reduce choice overload. Configure it as a shipping
method (the **Best rate** plugin) at `/admin/commerce/shipping-methods`: set a rate label, pick the
services to group, and optionally show the winning rate's own label (`reference_real_rate`). Grouping can
be **disabled per role** (`excluded_roles`) so, e.g., a "Sales" role sees the full individual rate list,
and excluded roles can optionally see both the best rate and the raw rates. Each best-rate method must be
ordered **after** the shipping methods whose services it groups.

---

- Group configured shipping services into one option.
- Price the option at the cheapest grouped rate.
- Choose the lowest rate server-side from computed rates.
- Show one friendly label instead of a long list.
- Depend on Commerce Shipping.
- Add a `best_rate` shipping method plugin.
- Remove grouped source rates via an event subscriber.
- Configure a rate label and description.
- Show the winning rate's own label (reference_real_rate).
- Disable grouping per role (excluded_roles).
- Show both best rate and raw rates for excluded roles.
- Order best-rate methods after their source methods.
- Simplify checkout choices.
- Configure grouped shipping.
- Handle shipping-rate grouping.
- Group shipping methods.
- Set the best rate.
- Configure the group.
- Reduce rate options.
- Simplify rates.
