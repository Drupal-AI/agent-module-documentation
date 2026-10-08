# Configuration

Best selling products has no central settings form. You configure it by placing
one (or both) of its blocks and setting the options on each block.

## Place a block

Place either block through **Structure → Block layout**
(`/admin/structure/block`) or in a **Layout Builder** section:

- **Best selling products block** — renders the top products as product entities,
  in a chosen view mode. Use this on the storefront (homepage, category pages) to
  show shoppers your bestsellers.
- **Best Selling Products Statistics** — appears under the *Statistics* block
  category. Renders a table of Product ID, Title, Sales Count and a link to each
  product. Use this admin-side to compare how products sell.

## Block settings

Each block's placement form offers:

| Setting | Applies to | Notes |
|---------|------------|-------|
| **Number of products** | both | How many to show. The statistics block clamps this to 1–100. |
| **Select Store** | both | Shown only if you have Commerce stores. Pick one store, or *all* to count every store. |
| **Select product bundle** | both | *All*, or a specific product type. |
| **Select view mode** | list block only | How each product renders. Default **teaser**. |
| **Cache** | both | A max-age selector controlling how long the block's result is cached. |
| **Strict sequences of products** | both | A deterministic tie-breaker so products with equal sales always order the same way. |

## How ranking works

The block counts only **completed** Commerce orders — pending and draft carts are
ignored — groups the order items by product, and orders by purchase count
descending (optionally scoped to one store and one product type). It then loads
those products, keeps only **published** ones of the chosen type, and stops at the
number you asked for. So drafts and unpublished products never appear.

## Caching — pick a finite lifetime

Use the **Cache** setting to balance freshness against load: a longer cache means
fewer sales queries but staler bestsellers; disable caching for near-real-time
data on a busy shop.

> **Known bug — avoid "Permanent" on the statistics block.** The statistics block
> references a cache constant it does not import, so choosing **Permanent** (the
> `-1` option) can throw an error. Set a **finite** cache lifetime for that block
> instead.

## Verify

After placing a block, view the page it sits on. The list block should show your
top-selling published products; the statistics block should show a table of
products with their sales counts. Only completed orders contribute to the counts,
so on a fresh store with no completed orders the blocks will be empty until sales
come in.
