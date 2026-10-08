<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

`toc_js.permissions.yml` defines one permission:

- **`administer toc_js`** — "Administer Toc.js": enable/disable and configure the table of contents
  per content type.

The content-type **Table of contents** settings section (`form_node_type_form_alter`) is shown when
the user has `administer toc_js` **or** core's `administer nodes`
(`#access => hasPermission('administer toc_js') || hasPermission('administer nodes')`).

Placing/configuring the `toc_js_block` uses core's `administer blocks`. The per-node toggle
(submodule `toc_js_per_node`) has its own permission `administer toc_js per node`.
