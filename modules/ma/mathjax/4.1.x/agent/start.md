<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MathJax — agent index

Loads the MathJax JS library and typesets LaTeX/MathML in rendered text. One config object, one
filter plugin, one permission, three JS libraries. No services, no plugin types, no Drush,
no submodules.

- **`mathjax.settings` keys, the two config modes, the filter, CDN vs local library** →
  [configure/settings.md](configure/settings.md)
- **The single permission and what it gates** →
  [permissions/administer.md](permissions/administer.md)

Key facts:
- Configure route: `mathjax.settings` → `/admin/config/content/mathjax` (permission
  `administer mathjax`, `restrict access: TRUE`).
- Filter plugin id: **`filter_mathjax`** (title "MathJax", `TYPE_TRANSFORM_REVERSIBLE`,
  weight 50) — must be **last** in the format's filter processing order.
- `config_type: 0` = *Text Format* mode (recommended; assets only attach through the filter).
  `config_type: 1` = *Custom* mode (assets attach on **every** page via
  `hook_page_attachments()`).
- Default CDN URL targets MathJax **2.x** (`…/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML`);
  `js/setup.js` uses the v2 `MathJax.Hub` API.
- Local install path when `use_cdn: 0`: `/libraries/MathJax/MathJax.js`.
