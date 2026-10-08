<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce License Access Control adds a Commerce License type that, on purchase, grants a customer view/update/delete access to specific node(s) through an ACL, enforced by Drupal's core node-grant system.

---

The module ships a single Commerce License type plugin, `AccessControl` (`@CommerceLicenseType` id `commerce_license_access_control`), that bridges Commerce License and the contrib ACL module. When you build a product (variation) that sells this license type, you pick the node(s) to protect, choose which operations to grant (view, update, delete), and set an ACL priority. Saving the license configuration creates an ACL (`acl_create_acl`) named by your license label and maps the chosen nodes to it (`acl_node_add_acl`). When a customer's license becomes active, the plugin adds that customer to the ACL (`acl_add_user`) and rebuilds node grants for the licensed nodes; when the license is revoked/expired, it removes the customer and rebuilds grants. Because access is enforced through core node grants (via ACL's `hook_node_access_records`/`hook_node_grants`), this is genuine access control, not display gating — but it also means node-access permissions must be up to date: after configuring or changing which nodes a license protects, rebuild node access permissions so the grant table reflects the mapping, and remember that node grants govern the node itself (verify attached private files and non-page delivery paths such as JSON:API are covered by your file/entity access setup). It depends on `acl:acl` and `commerce_license:commerce_license`; there is no admin settings form or route of its own (all configuration lives on the license type within the Commerce product).

---

- Sell view access to a members-only article gated by a purchased license.
- Sell a bundle of nodes (comma-separated) behind one license.
- Grant paid editors update access to specific nodes via a license.
- Grant delete access to a node for a license holder.
- Build a paid-content paywall on top of Drupal Commerce.
- Tie content access to a Commerce License lifecycle (active vs. expired).
- Automatically add a buyer to an ACL on license activation.
- Automatically remove a buyer from an ACL on license revoke/expiry.
- Use ACL priority to resolve grants when multiple ACL-based modules apply.
- Prevent duplicate purchases via the "already has access" existing-rights check.
- Sell course-lesson node access as licensed content.
- Restrict a downloadable resource node to license holders.
- Offer subscription-style renewals where content access follows the license state.
- Combine per-user node grants with core node access on the same node.
- Label each license distinctly using the license label field (stored as the ACL name).
- Grant access to several nodes at once from a single license configuration.
- Migrate a manual ACL-based paywall into a purchasable Commerce flow.
- Keep anonymous users out — the plugin never grants node access to anonymous owners.
- Rebuild node access after changing which nodes a license protects.
- Audit which nodes an ACL grants via the licensed-nodes lookup on the ACL id.
- Sell tiered access by pairing different license types/products with different node sets.
- Reuse an existing ACL across licenses by keeping the stored ACL id on the license.
- Verify no bypass path (direct file URLs, JSON:API, other view modes) reaches protected content.
- Confirm access disappears when a customer cancels or a license expires.
