# Configuration

Commerce Product Quantity is configured from two small forms under
**Commerce → Configuration → Product** — one at
`/admin/config/system/commerce_product_quantity` (per product) and one at
`/admin/config/system/commerce_product_type_quantity` (per product type). Both
pages require the **`administer commerce_product_quantity configuration`**
permission, so reach them as an administrator.

## Product Quantity (per individual product)

Use this form to cap a specific product.

1. Go to **Commerce → Configuration → Product → Product Quantity**.
2. Select the product you want to limit.
3. Enter the quantity you want to allow per order for that product.
4. Save.

From then on, a customer cannot add more than that number of the product to a
single order.

## Product Type Quantity (per product type)

Use this form to apply a limit to every product of a given type at once, which
saves setting the same cap on each product individually.

1. Go to **Commerce → Configuration → Product → Product Type Quantity**.
2. Select the product type you want to limit.
3. Enter the allowed quantity per order for products of that type.
4. Save.

## Which limit applies

If a product is covered by **both** a per-product limit and a per-product-type
limit, the **per-product limit takes precedence**. Set a broad ceiling on the
product type and then override individual products as exceptions.

## After saving

The limits are enforced when items are added to the cart, and quantities continue
to pass through Commerce's normal order handling. Test on the storefront with a
role that shops (not just an administrator) to confirm the caps behave as you
expect, especially where product and product-type limits overlap.
