<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node by Email — agent index

Creates **nodes from emails fetched over IMAP** (subject→title, body→body, configured author). Provides
permissions + a Drush command. Version **1.x** (dev). Core `^9||^10||^11`.

Only unseen messages whose `From` header matches the configured sender address are ingested
(`imap_search FROM "…"`).
