Advanced Datalayer example ships a ready-made set of datalayer tag and group plugins for the Advanced Datalayer module, so you get a working GTM dataLayer (event, site, and page variables) without writing any plugins.

---

The base `advanced_datalayer` module defines no tags itself — this submodule fills that gap with concrete `@AdvancedDatalayerTag` and `@AdvancedDatalayerGroup` plugins you can immediately assign values to on the page-variable defaults screens. It provides two groups — `site_Information` ("Site Information Group") and `page_Information` ("Page Information Group") — plus seven tags: `event` (group `root`), `site_Name`, `site_Category`, `ga_client_id` (group `site_Information`), and `page_Name`, `page_Category`, `response_Code` (group `page_Information`). Each tag extends `DatalayerNameBase` and carries annotation metadata (global/required/translatable/show_empty/weight). The submodule also implements `hook_page_attachments()` to attach `js/example_advanced_datalayer.js`, which fills in values that can only be computed client-side (e.g. device type, GA client id) when global datalayer tags exist on a supported route. Treat it as both a usable default configuration and a copy-paste reference for authoring your own tag/group plugins. It adds no routes, permissions, or services of its own.

---

- Get a working GTM dataLayer with common variables without writing plugin code.
- Push an `event` variable (e.g. `pageview`) into `window.dataLayer` on every page.
- Emit `site_Name` and `site_Category` global variables for analytics.
- Provide a `page_Name` and `page_Category` per page/section.
- Report the HTTP `response_Code` (200/403/404) as a dataLayer variable.
- Capture the Google Analytics client id (`ga_client_id`) computed on the client.
- Organize variables under nested `site_Information` and `page_Information` groups.
- Use these tag ids as keys when configuring `advanced_datalayer_defaults` contexts.
- Copy a tag class (e.g. `PageCategory`) as a template for a custom `@AdvancedDatalayerTag`.
- Copy a group class as a template for a custom `@AdvancedDatalayerGroup`.
- Demonstrate token-driven values by setting `page_Name` to `[node:title]`.
- Show how a `root`-group tag (`event`) sits at the top level of the dataLayer object.
- Provide device-type/client-side values via the bundled example JS.
- Bootstrap a GTM integration on a new site quickly, then customize.
- Teach content teams which dataLayer variables exist and where to set them.
- Serve as the fixture for testing Advanced Datalayer end to end.
