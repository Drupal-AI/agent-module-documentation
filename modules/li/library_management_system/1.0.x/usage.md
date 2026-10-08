<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Library Management System manages a library's books, publications, authors, and lending workflow.

---

The module defines custom content entities - LmsBook, LmsPublication, LmsBookAuthor, RequestedLmsBook, IssuedLmsBook - each with admin list/add/edit/delete routes gated by per-entity `administer *` permissions, plus CSV import forms, fine-amount settings, and report pages. Patrons request a book via `/lmsbook/{lmsbook}/request` (gated only by `access content`), which creates a request tied to the current user; staff then issue books from the requested list. It suits libraries needing an in-Drupal catalog and circulation tool.

---

- Catalog books, publications, and authors as entities.
- Manage book requests and issued (lent) books.
- Let patrons request a book from its page.
- Issue requested books to patrons as staff.
- Import authors, publications, books, and users from CSV.
- Configure fine amounts for overdue books.
- View book, author, publication, and issue reports.
- Gate admin entity management behind `administer *` perms.
- List entities via admin views and bulk operations.
- Track which patron requested which book.
- Prevent duplicate requests per user and book.
- Provide canonical view pages for each entity.
- Serve libraries needing in-Drupal circulation.
- Support Drupal 8, 9, and 10.
- Use Views Bulk Operations for list actions.
- Centralize library data in custom entities.
