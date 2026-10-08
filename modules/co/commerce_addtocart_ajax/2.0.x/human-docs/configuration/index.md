# Configuration

Commerce Add to Cart Ajax has a single, small setting: the CSS selector that tells
the module where in your theme to display the add‑to‑cart status message after an
AJAX submit. Many themes work with the default, so you may not need to change
anything.

## Open the settings form

1. Log in as a user who can administer Commerce configuration.
2. Go to **Commerce → Configuration → Add to cart Ajax**, or navigate directly to
   `/admin/commerce/config/commerce-addtocart-ajax`.

## Status‑messages selector

- **Selector for status messages** — the CSS selector for the container where
  Drupal's status messages are rendered in your theme. The default is
  **`[data-drupal-messages],[data-drupal-messages-fallback]`**, which matches the
  data attributes core's status-messages markup uses in most modern themes.

  If your custom or contributed theme wraps messages in a different element (for
  example a region with its own class or id), enter that selector here so the
  "added to cart" feedback lands in the right place. Inspect your theme's page
  output to find the correct container if you're unsure.

## Save

Click **Save configuration**. Test by adding a product to the cart on the
storefront and confirming the status message appears where you expect.
