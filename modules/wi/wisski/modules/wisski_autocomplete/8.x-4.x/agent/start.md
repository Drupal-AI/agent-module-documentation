<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI Autocomplete (wisski_autocomplete) — agent index

Submodule of **wisski**, **required by `wisski_core`** — infrastructure, not an option.
Adds extra information within autocomplete title patterns. Version **8.x-4.3**. Core `>=10.4 <12`.

**Why it is infrastructure:** a collection holds forty people called Müller and six objects called
"cup". A suggestion list showing only titles is unusable, and **selecting the wrong referent is the
most damaging data quality error in semantic cataloguing** — a wrong Müller propagates through
every subsequent query and export.