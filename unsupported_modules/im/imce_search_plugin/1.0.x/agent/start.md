<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IMCE Search Plugin (imce_search_plugin) — agent index

File search inside the **IMCE** browser: previews, instant navigation, match highlighting.
Version **1.0.0-beta2** (**beta**). Core `^10.1 || ^11`, PHP `^8.1`. Depends on `imce ^3.0`.

**Project → module rename:** project is **`imce_search_2`**, module is **`imce_search_plugin`**.
`drush en imce_search_2` fails — use the module name.

Registers as `Plugin/ImcePlugin/Search`, the supported extension point, so it appears inside the
browser rather than as a separate screen.

**IMCE profiles still govern scope** — search operates within the folders the user's IMCE profile
grants, not across the filesystem.