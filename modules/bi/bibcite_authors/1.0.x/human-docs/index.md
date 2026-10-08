# Bibcite Authors — manual setup guide

**Bibcite Authors** (`bibcite_authors`) is a small field formatter for the
Bibliography & Citation (Bibcite) ecosystem that links a citation's author
names to matching **Drupal user accounts**. Instead of author names rendering as
plain text, they become links to the user profiles of the people on your site —
connecting publications to their authors.

It is a content-display feature: the linked profiles follow normal
user-profile access, and the module adds no access-control role or permissions
of its own. It has no separate settings page — you turn it on where you control
how the author field is displayed.

This guide is written for a **human** clicking through the admin UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Bibcite Authors provides a formatter you choose when configuring the display of
a Bibcite reference's author field:

1. Go to **Manage display** for the Bibcite reference (for example under the
   bibliography entity's display settings).
2. For the author field, choose the Bibcite Authors formatter that links
   authors to user accounts.
3. Save the display.

Author names then render as links to the corresponding user profiles wherever
that display is used. Because the links point at user profiles, what a visitor
can see still depends on your site's normal user-profile access rules.
