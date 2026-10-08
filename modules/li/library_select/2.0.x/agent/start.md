<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Library Select — agent index

Lets editors **select which registered asset libraries (CSS/JS) to attach per node/entity** (page-specific
libraries without theme changes). `library_select_context` submodule; provides permissions. Version
**2.0.0-beta1**. Core `^10||^11`.

Content-display/asset — selects from **registered** libraries (not arbitrary URLs); attaching loads JS/CSS,
so restrict the permission to trusted editors. No access role beyond permission.
