<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Select2 (`select2_all`) — agent index

Automatically applies the **Select2** JS library to `select` form elements, mainly on **admin
routes**, adding search/tagging to dropdowns. Zero configuration: **no settings form, no
config, no schema, no permissions, no Drush** (legacy options exist only as commented-out
code).

- **How it targets selects, opting in/out (`#select2`, `select2-enable`/`select2-disable`), the libraries, and serving Select2 locally vs CDN** →
  [api/behavior.md](api/behavior.md)

Key facts:
- `hook_element_info_alter()` adds `#pre_render` = `Select2::preRenderSelect` to `select` and any type starting `select_` / ending `_select`.
- Applies by default in **admin context** (admin route or admin theme). Opt out with class `select2-disable` or `#select2 => FALSE`; force on with `select2-enable` or `#select2 => TRUE`.
- Attaches library **`select2_all/drupal.select2`**, which depends on **`select2_all/select2`** (CDN by default; local if `libraries/select2/dist` exists — via `hook_library_info_alter()`).
- Class `Drupal\select2_all\Select2` implements `TrustedCallbackInterface` (`preRenderSelect`, `preRenderDateCombo`, `preRenderSelectOrOther`).
