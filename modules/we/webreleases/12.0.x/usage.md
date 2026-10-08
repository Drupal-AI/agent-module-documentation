Web Releases adds "product" and "release" content types (a release references a product) with ready-made Views, pretty URLs, and a menu link for publishing product release/changelog pages.

---

Web Releases is a config-bundle / recipe module from the Webship (`web*`) suite. On install it applies its bundled recipe (`recipes/default`), which pulls in the Webpage and Web Assets recipes and provisions two node types — Product and Release — where each release references its parent product through `field_product`. It ships the fields (body, product image, release image, release link), Display-Builder view modes and displays, two Views (`products` and `releases`) with page and block displays, Pathauto patterns for both bundles, and a "Products" main-menu link. A small path processor lets the releases page be reached by a product's alias (`/products/<product>/releases`) instead of only by numeric node ID. There is no settings form and no permissions of its own; the provisioned content follows normal node access and the standard editorial (content moderation) workflow inherited from the Webpage recipe.

---

- Publish a catalogue of products, each with its own image, body/description and teaser.
- Publish release/changelog entries and tie each one to the product it belongs to via `field_product`.
- Give every release an optional external "Release Link" (download page, tag, notes) and a release image.
- Expose a "/products" landing page (Views grid, 9 per page, published products only) linked from the main menu.
- Show a product's releases at a human-friendly URL such as `/products/drupal-cms/releases`.
- Render each product's own releases list on its product page via the releases block/page displays.
- Drop a "Products block" or "Latest releases" block into a region for a home page or sidebar.
- Provide a compact "Title releases" HTML-list block (archive view mode) with an "All releases" link.
- Auto-generate SEO-friendly aliases: `products/<title>` for products, `products/<product>/releases/<title>` for releases.
- Move products and releases through the editorial workflow (draft/published) before they appear in the Views.
- Keep node CSS classes on Display-Builder-rendered product/release output so themes can target them.
- Stand up a full product-and-release section on a fresh site in one recipe apply.
- Reference a Media (Image) item for release imagery via `field_release_image`.
- Reference a Media (Image) item for product imagery via `field_image` (from the Web Assets stack).
- Sort products and releases newest-first by creation date on their listing pages.
- Serve dashed, underscored, or spaced product titles in the releases URL without extra configuration.
- Reuse the products and releases blocks in layouts built with Display Builder.
- Build a marketing/docs "releases" area on top of Drupal without hand-building content types and Views.
- Extend the shipped node types with additional fields through the normal Field UI.
- Combine with the rest of the Webship suite (webpage, webassets, webdev) for a consistent editorial stack.
