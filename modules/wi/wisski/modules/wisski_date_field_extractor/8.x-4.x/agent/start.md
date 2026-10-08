<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI Date Field Extractor (wisski_date_field_extractor) — agent index

Submodule of **wisski**. Field type + presave hook deriving **calculable values from date
expressions**. Version **8.x-4.3**. Core `>=10.4 <12`.

Historical dates are not timestamps — "second quarter of the 15th century", "before 1523",
"c. 1780–1790" are normal catalogue entries and none is sortable. The usual result is a collection
whose dates are prose: readable, useless for any time query.

**The design bet:** let cataloguers write what they mean and derive structure, rather than forcing
a structured field they will misuse. Better data — **provided the derivation is inspectable**. A
date silently interpreted wrongly is worse than one left as text, because it will be trusted.

**Check on any collection using it:** how ambiguous expressions resolve, and whether the derived
range is visible to cataloguers so a bad interpretation can be corrected.