BEE Hotel Add to Cart offers helpers and a route for adding Bee Hotel units to the Commerce cart programmatically.

---

This submodule provides an /add/product/{productId} route whose controller loads the product, ensures a Commerce cart exists for its store and redirects to the cart page, plus an AddToCart service scaffold for programmatic cart building. It also implements a status-messages preprocessor that suppresses the default 'added to cart' message when the add originated from one of Bee Hotel's own forms (tracked via the session 'beehotel_data.from' key), for a cleaner booking UX.

---

- Ensure a Commerce cart exists for a product's store from a simple URL.
- Redirect visitors to the cart page after triggering an add.
- Provide a service scaffold for programmatic add-to-cart logic.
- Suppress the default 'added to cart' message on Bee Hotel booking flows.
- Keep the booking UX clean by hiding redundant status messages.
- Reuse Commerce cart provider/manager wiring across Bee Hotel.
