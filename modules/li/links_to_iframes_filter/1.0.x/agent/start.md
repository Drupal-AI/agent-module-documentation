<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Links to Iframes Filter — agent index

**Text filter that replaces ADMIN-CONFIGURED links with iframe embed markup** (curated link→iframe mapping, not
arbitrary user URLs). Depends on core `filter`. Provides permissions. Version **1.0.0**. Core `^10||^11`.

Content-display/filter — iframe markup is **admin-defined + rendered**: restrict who edits the mappings, control
which roles get the text format, mind iframe privacy/clickjacking. No access role beyond permission.
