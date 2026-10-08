# Drush commands

From `src/Drush/Commands/BasicCartCommands.php`.

## `basic-cart:enable-add-to-cart` (alias `baca-en`)
Enables "add to cart" for **all nodes of all enrolled content types**. It loads the eligible node ids
(`BasicCartAssistant::getEnabledTypesNids()`), then in batches of 50 sets each node's `add_to_cart` field
via `enableAddToCartForNode()` and saves. Reports the processed count.

```bash
drush basic-cart:enable-add-to-cart
# or
drush baca-en
```

Use after enabling new content types (or importing content) so existing nodes gain the add-to-cart button
without editing each one. Equivalent to the bulk `EnableAddToCart` node action, but for the whole set.
