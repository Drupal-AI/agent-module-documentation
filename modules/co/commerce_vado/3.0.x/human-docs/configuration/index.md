# Configuration

Commerce Variation Add On is configured through its own admin screens (for add-on
groups) and by using the discount adjustment type it provides. This page covers the
pieces you'll touch.

## Permissions

Grant these to the roles that should manage add-ons:

- **Access vado administration pages** — reach the module's administration screens.
  This is the general "manage Vado" permission for store staff.
- **Administer commerce_vado_group** — a **restricted** permission that gates
  managing the add-on **groups** (the reusable sets of variations). Keep this for
  trusted roles.

Example with Drush:

```bash
drush role:perm:add store_manager 'access vado administration pages'
```

## Add-on groups

Add-on groups are how variations are collected into reusable sets — you define which
variations are offered as add-ons of which base variations. Manage them from the
module's admin screens (reached via the action links Vado adds, and gated by the
permissions above). A variation can participate in several add-on groups, so one
base variation can offer more than one set of extras.

Once a group is set up, the base variation's **Add to Cart form** offers its add-on
variations as a selection. Each add-on the customer chooses is added to the order as
its own item, so pricing, stock, tax and fulfilment all behave as they do for a
normally purchased variation. Vado also prevents the same add-on being added twice
to a single order.

## The `vado_discount` adjustment type

Vado registers a dedicated **`vado_discount`** commerce adjustment type (with its
own UI). Use it to discount a bundle — for example when a parent variation and its
add-on are bought together — as a distinct adjustment on the order. Because it is
its own adjustment type, bundle discounts are **reportable separately** from your
regular promotions, which keeps order reporting clean.

## Views reporting

The module exposes add-on relationships and data in **Views** and formats them for
display, so you can build reports such as add-on attach rates, or list add-on
variations distinctly from the base variation. Add a view of the relevant Commerce
data and use the Vado fields it makes available.

## Notes

- Add-on variations are ordinary purchasable variations — there is nothing
  add-on-specific to configure on their price or inventory.
- After upgrading from a 2.x release, remember to run `drush updatedb` so the
  module's post-update steps apply (see [Installation](../installation/index.md)).
