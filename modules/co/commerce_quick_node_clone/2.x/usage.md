<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Quick Node Clone adds a one-click "Clone product" action that opens a pre-filled edit form for a duplicate of a Commerce product, deep-cloning its paragraph fields.

---

Commerce Quick Node Clone is a Commerce Product extension modeled on Quick Node Clone. It adds a "Clone product" entity operation, a `Clone` local task tab on each product page, and a Views field plugin (`commerce_quick_node_clone_link`) so editors can duplicate a `commerce_product` in one click. Choosing the action builds an unsaved duplicate via `createDuplicate()`, reassigns it to the current user with fresh created/changed timestamps, applies an optional title prefix and a configurable publication-status rule, deep-clones any paragraph reference fields so the copy owns its own paragraphs, and then opens the standard product edit form — nothing is persisted until the editor reviews the copy and clicks Save. Access is gated per product type by a `clone <type> content` permission combined with create access to that bundle (and, when the Group/gnode module is present, per-group create access). A settings form at `/admin/config/content/commerce-quick-node-clone` controls the title prefix and status behavior, and a `config`-level `exclude` map can drop specific paragraph fields from the copy.

---

- Duplicate a Commerce product in one click from the product list operations.
- Add a `Clone` tab to each product's canonical page for fast duplication.
- Build catalog variants (color/size/edition ranges) by cloning a base product and editing.
- Seed a new seasonal or promotional product from an existing one instead of rebuilding it.
- Copy a product together with all of its custom fields.
- Deep-clone paragraph reference fields so edits to the copy do not affect the original.
- Reassign each clone to the editor who created it (fresh `uid`, `created`, `changed`).
- Review and adjust the duplicate on a pre-filled edit form before anything is saved.
- Prepend a marker such as "Copy of" to every cloned product title.
- Keep the source product's published/unpublished state on the clone, or force the bundle default.
- Create clones as unpublished drafts by turning off "Copy publication status from source product".
- Grant clone rights per product type via the generated `clone <type> content` permissions.
- Let store staff clone products without giving them broader administrative access.
- Honor Group/gnode per-group create access when deciding who may clone a grouped product.
- Add a "Clone product" link column to any product View with the `commerce_quick_node_clone_link` field.
- Customize the clone link's label per View display.
- Exclude selected paragraph fields from the copy via the `exclude` config map.
- Return the editor to a chosen destination (list/View) after saving, via the `destination` query.
- Speed up bulk product entry for stores with many similar SKUs.
- Restrict the clone settings form to trusted admins with "Commerce Quick Node Clone Settings".
- Provide a translation-aware clone that processes each of the product's translations.
- Migrate legacy Quick Node Clone settings automatically via the module's post-update hooks.
