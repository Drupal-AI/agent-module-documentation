<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTML Titles for Drupal — agent index

Allows entity/page **titles to contain HTML markup** (rich headings — `<em>`/`<sup>`/styling that's normally
escaped). Version **8.x-1.2**. Core `^9.3||^10||^11`.

**SECURITY CAUTION:** this **bypasses the normal title escaping** → a **stored-XSS surface** (whatever HTML an
editor puts in a title is rendered). Only where title editing is restricted to **trusted editors**; ideally
sanitize allowed title HTML to a safe tag set. No access role.
