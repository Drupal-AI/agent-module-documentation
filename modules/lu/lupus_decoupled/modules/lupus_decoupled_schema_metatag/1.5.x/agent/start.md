<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lupus Decoupled Schema Metatag (lupus_decoupled_schema_metatag) — agent index

Submodule of **lupus_decoupled**. Exposes **JSON-LD** from the Schema Metatag module to the front
end. Version **1.5.1**. Core `^10 || ^11`.

SEO is the recurring casualty of decoupling. This keeps structured data a **Drupal configuration
task** — mappings, field values, token replacement all stay server-side — instead of front-end
code that drifts from the content model.

**Verify the front-end half:** the JSON-LD must reach the HTML a crawler sees. Straightforward
with server-side rendering; not automatic with purely client-side rendering.