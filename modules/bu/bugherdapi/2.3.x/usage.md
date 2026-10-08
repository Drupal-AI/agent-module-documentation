<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bugherd API embeds BugHerd's feedback overlay, so reviewers can report issues by clicking on the page they are looking at.

---

Client review of a site normally arrives as a document: "the button on the third page is the wrong blue". Turning that into a ticket someone can act on costs a round trip per item. A visual feedback tool removes it — the reviewer clicks the element, types the comment, and the tool captures the URL, the browser, the viewport and a screenshot alongside it.

This module puts BugHerd's overlay on the site and configures which pages carry it.

**The important deployment decision is who sees the overlay, and it needs to be explicit.** A feedback tool loaded for everyone shows a floating widget to real visitors, invites feedback from people who are not reviewers, and loads a third-party script on every page. The usual arrangement is to restrict it to authenticated users, to a role, or to a non-production environment. Whatever the module offers, decide this before enabling rather than after someone reports the widget on the live homepage.

**It is also a third-party script that can read the page**, which is the nature of a feedback tool that captures screenshots. That places the BugHerd account inside the site's trust boundary and means the tool sees whatever a reviewer sees, including anything personal on an authenticated page. On a site handling regulated data that is worth a moment's thought before the overlay goes on an internal admin screen.

Core requirement `^11 || ^12` — current Drupal only.

---

- Collect client feedback by clicking on the page.
- Turn a review comment into a ticket.
- Capture browser and viewport with a report.
- Attach a screenshot to a bug report.
- Skip the round trip from document to ticket.
- Restrict the overlay to reviewers.
- Limit feedback to a staging environment.
- Keep the widget off the live site.
- Decide who sees the overlay before enabling.
- Configure which pages carry the script.
- Account for the tool reading page content.
- Avoid the overlay on screens with personal data.
- Treat the BugHerd account as part of the trust boundary.
- Speed up a client review cycle.
- Audit third-party scripts on a site.
