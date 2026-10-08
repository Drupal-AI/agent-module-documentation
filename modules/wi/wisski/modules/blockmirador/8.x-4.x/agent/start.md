<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI Mirador Block (blockmirador) — agent index

Submodule of **wisski**, in directory `wisski_mirador_block`. Places a **Mirador viewer as a
block**. Version **8.x-4.3**. Core `>=10.4 <12`.

**Name mismatch to flag:** the directory is `wisski_mirador_block`, the **module is
`blockmirador`** — `drush en wisski_mirador_block` will not work. Recurring source of confusion in
this family.

**Placement matters for performance:** Mirador is a substantial JavaScript application. Site-wide
placement costs every page; restrict it to pages where images are actually examined.