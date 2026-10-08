<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Inspire Tree registers the Inspire Tree JavaScript library as Drupal asset libraries so other code can attach an interactive, hierarchical tree UI. It ships no widget, field, or render element of its own — it is a library provider.

---

Drupal renders hierarchies as indented tables with drag handles — a taxonomy vocabulary of four hundred terms, a deep menu, a category picker — and those stop being usable past a couple of hundred rows. Inspire Tree (the client-side library by helion3) is built for the job: lazy-loaded nodes, in-tree search, multi-select with parent/child propagation, and file-browser expand/collapse. This module makes three libraries available to Drupal's asset system — `inspire_tree/inspire_tree` (inspire-tree 6.0.1), `inspire_tree/inspire_tree_dom` (inspire-tree-dom 4.0.6, the DOM renderer), and `inspire_tree/lodash` (4.17.21) — so custom code, a theme, or another module can `#attached` them and build a tree. By default the JavaScript is pulled from the jsDelivr CDN (`//cdn.jsdelivr.net/gh/helion3/...`); `hook_library_info_alter()` transparently switches each library to a local copy if the matching file (e.g. `inspire-tree.min.js`) is found in a `libraries/` directory via `library.libraries_directory_file_finder`. A settings form at `/admin/config/services/system/inspire-tree` (behind `administer site configuration`) has one option — Mode: none / light / dark — which controls whether the module attaches `inspire-tree-light.css` or `inspire-tree-dark.css` (local if present, otherwise from the CDN) to the DOM library. Version **1.0.6**, core `^8.8` through `^11`. One detail in the info.yml has site-wide reach: **`libraries-override: core/underscore: inspire_tree/lodash`** — installing this module replaces core's Underscore with Lodash for the whole site. The two are broadly compatible and the substitution is common, but it is a global change made by a module whose stated purpose is a tree widget, so verify it against any custom JavaScript that depends on `core/underscore` before installing.

---

- Provide the Inspire Tree JS library to a custom module that renders a taxonomy as a tree.
- Attach `inspire_tree/inspire_tree_dom` from a theme to build a hierarchical category picker.
- Build an interactive organisational chart in custom JavaScript.
- Add in-tree search over a large hierarchy.
- Lazy-load deep tree branches instead of rendering thousands of rows.
- Multi-select nodes with automatic parent/child propagation.
- Improve a bespoke menu-editing interface.
- Present a file/document structure as an expandable tree.
- Build a location or region hierarchy selector.
- Replace an unusable indented drag-and-drop table.
- Make a 400-term vocabulary navigable.
- Add expand/collapse behaviour to a nested structure in a form.
- Build a product category browser.
- Serve the tree JS from the CDN with zero local setup, or drop a local copy in `libraries/` to self-host.
- Switch the tree's CSS theme between light and dark from a single admin setting.
- Provide Lodash to the site as a drop-in for core's Underscore.
- Prototype a hierarchy UI quickly before deciding on fields/Views integration.
- Share one canonical Inspire Tree asset library across several custom features.
- Self-host the assets for an air-gapped or CDN-restricted deployment.
- Give front-end code a drag-and-drop tree without bundling the library yourself.
