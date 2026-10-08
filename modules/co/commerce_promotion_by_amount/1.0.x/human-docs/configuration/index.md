# Configuration

This module has **no global settings form**. Everything is configured on an
individual promotion, by choosing one of its two offers and filling in the options.
So "configuring" the module really means creating a promotion that uses it.

## Create the promotion

1. Log in as a user who can administer Commerce promotions.
2. Go to **Commerce → Promotions → Add promotion** (`/promotion/add`).
3. Fill in the usual fields — name, an optional customer‑facing display name, the
   store(s) it applies to, order type, dates, and status.

## Choose one of the two offers

Scroll to the **Offer** section and pick one:

- **Fixed amount off for cheapest or most expensive matching product** — takes a
  flat money amount off one item (for example £5 off).
- **Percentage off for cheapest or most expensive matching product** — takes a
  percentage off one item (for example 50% off).

The form then shows the amount field followed by three radio options that are the
heart of this module.

## The amount or percentage

- For the **fixed** offer, enter a **money amount** and currency (for example
  `5.00 USD`). This is the most that will be taken off the chosen item; if the item
  is worth less than the amount, the discount is trimmed so the item total never
  goes below zero.
- For the **percentage** offer, enter a **percentage**. Drupal stores this as a
  fraction (0.5 means 50%), but the form accepts a normal percentage entry.

## Cheapest item / most expensive item

This radio (the `type` setting) decides which single item gets the discount:

- **Cheapest** *(default)* — discount the lowest‑priced qualifying item in the cart.
  Use this for "cheapest item free/half price" deals.
- **Most expensive** — discount the highest‑priced qualifying item instead. Use this
  for "money off your priciest product" campaigns.

## Compare by order item or product amount

This radio (the `compare` setting) decides *how* items are ranked when finding the
cheapest or most expensive:

- **Product** *(default)* — rank by each item's **unit price**. A cheap product
  bought in large quantity is still judged on its single‑unit price, so a high
  quantity does not unfairly make it the "most expensive" line.
- **Order item** — rank by each line's **total price** (unit price × quantity), so
  quantity is taken into account when picking the target.

## Apply to all the products / only one product

This radio (the `scope` setting) decides how much of the chosen item is discounted:

- **All the products** — apply the discount across the entire quantity of the chosen
  line item.
- **Only one product** — apply the discount to just one unit of the chosen line
  item. This is how you build "buy one get one free": set the percentage offer to
  100% off, cheapest item, only one product.

## Optional: Conditions

Add **Conditions** to the promotion (for example a specific product category or SKU)
so only matching products count as candidates. The offer then picks the cheapest or
most expensive item *among the ones that satisfy the conditions* — everything else
in the cart is left at full price.

## Save

Click **Save**. The discount now applies automatically to qualifying carts, always
landing on exactly one line item. Because the offer reads each item's
already‑adjusted total, it stacks safely with other promotions and never pushes a
line below zero.
