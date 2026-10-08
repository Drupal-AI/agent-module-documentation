<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSnippet — agent index

**Stores and provides reusable code snippets (JS/CSS)** attached to pages as Drupal libraries. Provides
permissions. Version **8.x-1.7**. Core `^9.3||^10||^11`.

Developer/theming — snippets are **JS/CSS that run in browsers** (effectively arbitrary JS — XSS/defacement risk):
keep editing to **fully-trusted** admins/developers, review content. No server-side eval. No access role beyond
permission.
