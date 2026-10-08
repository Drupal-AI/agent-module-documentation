<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Personal Contact Form Link — agent index

A **Display Suite field** rendering a link to a user's personal contact form. Version **2.0.x**.
Core `^8 || ^9 || ^10`. Depends on `ds`.

Placed on the user entity display via DS Manage-display; links to `/user/{uid}/contact`. Link visibility follows
core personal-contact-form access (no access bypass added). No routes, no own permissions, no callbacks.
Trivial security surface.
