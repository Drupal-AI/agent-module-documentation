<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Flag Lists builds on the Flag module to let each user create their own named collections — "lists" — of flagged content, rather than a single global flag per flag type. It is the difference between one "Bookmarks" and a user's own "Reading list", "Gift ideas" and "For work".

---

Flag gives you flag types: bookmark, favourite, report. Each is a single on/off relationship between a user and an entity. That covers "did this user bookmark this?" but not "which of this user's *lists* is it on?", and the multi-list case — wishlists, playlists, curated collections — is common enough that rebuilding it per project is a waste.

This module adds that layer. A flag type can be used as a **template** for user-created lists (flagging collections); a user makes as many lists as they like from it and flags content into any of them. The entities involved are real Drupal entities with revisions, so the module ships a full permission set covering creating lists, viewing your own versus all lists, editing, and the flagging-collection revision operations (view/revert/delete). Views integration is a dependency, so lists can be rendered and listed through Views like any other content.

A submodule, `flag_lists_actions`, adds actions around the lists. Version note worth carrying: release **4.0.4** has a malformed dependency manifest that breaks Composer installation (the require key concatenates the package name with its constraint); **4.0.3** installs cleanly, so pin to it until upstream fixes the typo.

The action routes are correctly built — they carry `_csrf_token: 'TRUE'` and flag-access requirements — which is worth noting given how many flag-style modules get the CSRF protection on state-changing links wrong.

---

- Let users create named content lists.
- Build a wishlist feature.
- Build a reading list feature.
- Support multiple lists per user.
- Flag content into a chosen list.
- Use a flag type as a list template.
- Render user lists through Views.
- Let users view their own lists.
- Grant viewing all lists separately.
- Manage flagging-collection revisions.
- Revert a flagging collection revision.
- Curate collections of content.
- Build gift-idea lists.
- Add actions with flag_lists_actions.
- Pin to 4.0.3 to avoid the broken 4.0.4 manifest.
- Rely on CSRF-protected flag actions.
- Restrict list creation by permission.
- Let users edit their own lists.
- Offer per-user favourites collections.
- Extend Flag beyond a single global flag.