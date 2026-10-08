<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filehash Report — agent index

Reports **duplicate files** using File Hash hashes (find/clean up duplicate uploads, reclaim storage).
Depends on `filehash`; provides permissions. Config at `filehash.reportduplicates`. Version **1.0.1**. Core
`^10||^11`.

Admin/reporting — informational (doesn't delete/change access); gate the report by permission (file
listings reveal uploads).
