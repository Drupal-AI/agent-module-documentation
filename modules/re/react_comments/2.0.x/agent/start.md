<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# React Comments — agent index

**React-based commenting system** — reads/posts Drupal comments via **REST** (dynamic/SPA-style). Depends
on core `comment`, `rest`. Config at `react_comments.settings`. Version **2.0.1-beta5**. Core
`^10.6||^11.3||^12`.

**Security:** the comment REST resources must be access-controlled (comment permissions apply); add
spam/flood protection (public POST endpoint); comment content is user input (Drupal sanitizes — confirm
React escapes it). Relies on comment/REST permissions.
