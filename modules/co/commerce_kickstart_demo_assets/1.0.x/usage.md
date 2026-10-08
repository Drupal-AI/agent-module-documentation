<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Kickstart Demo Assets provides the code assets the Commerce Kickstart Demo recipe needs but a recipe cannot ship on its own: a Layout Builder "Slideshow" layout with a slick carousel (template plus JS/CSS libraries), and glue code that makes the recipe's imported default content work. It is a demo/asset support module that arrives as part of the Commerce Kickstart demo rather than something you install for its own sake.

---

Commerce Kickstart was a full distribution in Drupal 7; in Drupal 11 the demo is delivered as a core recipe that applies configuration and content to an existing site. A recipe can carry config and default content but cannot ship a Twig template, a JavaScript file, a Layout Builder layout plugin, or an event subscriber — those must come from a module, and that is what this package is. It contributes a `cklb_slideshow` Layout Builder layout (class `SlideshowLayout`, extending `bootstrap_layout_builder`'s `BootstrapLayout`) whose region turns each placed block into a carousel slide, backed by the `cklb-slideshow` and `slick` asset libraries and the `Drupal.behaviors.slickSlider` behavior that pulls slick-carousel from a CDN. It also carries the plumbing that makes the recipe's default content land correctly: a `node_presave` hook that rewrites Layout Builder references (block and background-media UUIDs) to the local entity IDs the Default Content API and `bootstrap_styles` leave unresolved, and a `DefaultContentSubscriber` that re-indexes the `products` Search API index once the import is applied. It has no settings page, no routes, and no permissions; core requirement is `^11` (Drupal 11 only), and although its info.yml declares no module dependencies, its code needs `bootstrap_layout_builder`, `search_api`, `layout_builder`, `media`, and `block_content` from the surrounding demo environment. Because it exists to support a demonstration, it belongs on evaluation, training, and sandbox sites rather than a production storefront, and — since a recipe does not uninstall — plan for the fact that removing the demo content it helps import is manual work.

---

- Support the Commerce Kickstart demo recipe.
- Supply a Layout Builder slideshow layout to the demo.
- Turn Layout Builder blocks into carousel slides.
- Render a hero slideshow with the slick carousel.
- Attach the slick-carousel JS/CSS assets a recipe cannot ship.
- Fix up imported Layout Builder content so blocks resolve.
- Rewrite block UUID references to local block IDs on import.
- Resolve Bootstrap background-media UUIDs to media IDs.
- Re-index the products Search API index after content import.
- Evaluate Drupal Commerce quickly from a worked example.
- Learn the Commerce Kickstart demo store setup.
- Demonstrate a Commerce storefront to a client.
- Set up a Commerce training or workshop environment.
- Build a sandbox store for experimentation.
- Explore Layout Builder + Bootstrap layout patterns.
- Study how a module backs a core recipe.
- Provide a worked default-content import example.
- Show a product listing powered by Search API.
- Prototype a slideshow-driven landing section.
- Reference code for recipe-plus-module packaging.
- Support a Commerce proof of concept.
- Demonstrate cart and checkout in a seeded store.
