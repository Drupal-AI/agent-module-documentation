<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Import Map — agent index

Manages the browser **ES-module import map** (`<script type="importmap">` mapping bare specifiers → URLs) so
front-end code can use bare-specifier imports. Version **1.0.1**. Core `^10.2||^11`.

Theming/JS integration — emits the import-map JSON; mapped URLs are admin/developer-configured (point at
**trusted** scripts — anything mapped can be imported/executed). No content/access role.
