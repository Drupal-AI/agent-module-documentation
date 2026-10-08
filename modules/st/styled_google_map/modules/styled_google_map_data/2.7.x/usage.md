<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Styled Google Map Demo Data is an example submodule that, on install, populates the `styled_google_map_demo` `real_estate` entity type with sample Sacramento property data (from a bundled CSV) and ships a preconfigured "Styled Google Map" View with example heatmap, cluster, spiderfied-cluster and custom-control map pages.

---

This submodule builds on `styled_google_map_demo` to give a fully working, clickable demonstration of the parent module. Its `hook_install()` scans the module's `images/` folder into managed files, creates three property-type taxonomy terms in the `real_estate` vocabulary (`Condo`, `Multi-Family`, `Residential`) with those pin icons, then runs a batch (`demo.batch.inc`) that imports rows from `csv/demo.csv` (real Sacramento housing sale data: street, city, price, latitude, longitude, type) into `real_estate` entities. It installs a View named `styled_google_map` using the parent module's Views style, exposing example pages at `/heatmap`, `/cluster-map`, `/cluster-map-spiderified` and `/map-controls`, plus a single-item view; a `hook_preprocess_page()` prints links to those pages and a reminder to add a Google Maps API key, and a `hook_form_views_exposed_form_alter()` positions the exposed filter as an on-map control. Because that View config references the `svg_image` module, this submodule **requires `svg_image` to be installed before it can be enabled**. `hook_uninstall()` deletes the demo terms and content. It holds no settings of its own (`configure: null`) and is for demonstration/learning only.

---

- Load ready-made example maps to see clustering, spiderfying, heatmaps and controls in action.
- Populate the `real_estate` demo entity with realistic Sacramento property data instantly.
- Create the `Condo` / `Multi-Family` / `Residential` property-type terms with pin icons.
- Provide the `/heatmap` example page (a Google `visualization` heatmap of properties).
- Provide the `/cluster-map` example page (js-marker-clusterer grouping of markers).
- Provide the `/cluster-map-spiderified` example (OverlappingMarkerSpiderfier fan-out).
- Provide the `/map-controls` example page with an on-map exposed filter control.
- Ship a reference `styled_google_map` View you can clone for your own multi-marker maps.
- Demonstrate importing CSV rows into a content entity via a Drupal batch.
- Give trainers a one-command demo of every Styled Google Map feature.
- Show how per-category pin icons drive marker appearance on a map.
- Provide test fixtures (content + view) for evaluating the parent module.
- Illustrate wiring an exposed Views filter as a positioned map control.
- Serve as an example of using managed files as taxonomy-term pin images.
- Prototype a property-finder/store-locator quickly on a fresh site.
- Study how a preconfigured Views style map is exported as config.
- Understand the module's `svg_image` dependency when planning an install.
- Seed geolocated demo content for screenshots or client demos.
- Remove all demo content cleanly by uninstalling the submodule.
- Compare heatmap vs cluster vs spiderfy presentations of the same dataset.
