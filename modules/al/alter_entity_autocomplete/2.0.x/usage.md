<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alter Entity Autocomplete lets editors reference an entity by typing its numeric ID, `#ID`, email address, full URL, or path alias directly into a core entity-reference autocomplete field (Node, User, Taxonomy Term).

---

Alter Entity Autocomplete swaps in an enhanced version of core's `entity.autocomplete_matcher` service so that, alongside the normal label-search suggestions, an entity-reference autocomplete field can resolve a directly typed identifier to a suggestion. For each entity type an admin enables, the matcher recognises a bare ID (`123`), a hashed ID (`#123`), a user email address, a full URL (`https://example.com/node/123`), a canonical path (`/node/123`, `/user/123`, `/taxonomy/term/5`), or a path alias (`/my-article`), and prepends the resolved entity as the first suggestion. It requires no other modules, adds no permissions of its own, and is configured entirely from one settings form; because the default configuration enables no entity types, the module is inert until an administrator opts specific types in. Field-level bundle restrictions on the reference field are still honoured, and alias resolution goes through Drupal's path validator so it stays language-safe and works with Pathauto-generated aliases when Pathauto is installed.

---

- Reference an existing node by typing its node ID (e.g. `42`) instead of remembering its title.
- Reference a node by `#42` when the numeric-only form is ambiguous with a title.
- Reference a user account by typing their email address in a user-reference field.
- Reference a user by pasting a `/user/17` path or a full user profile URL.
- Reference a taxonomy term by its term ID in a term-reference (e.g. tags) field.
- Paste a full canonical URL copied from the browser address bar to reference that entity.
- Paste a URL from an external system (report, spreadsheet, email) to resolve it to the Drupal entity it points at.
- Type a Pathauto alias like `/blog/my-post` to reference the node behind it.
- Reference a taxonomy term by its alias path when the vocabulary has aliases.
- Speed up bulk editorial work where editors already know the IDs of the entities they link to.
- Reference entities on a multilingual site using their localized aliases or language-prefixed URLs.
- Enable enhanced autocomplete for only Node while leaving User and Taxonomy Term on core behaviour.
- Enable it for User references (author, owner, moderator fields) so accounts can be picked by email.
- Enable it for Taxonomy Term references so categories/tags can be entered by ID or alias.
- Keep the field's configured target bundles enforced so only allowed content types resolve.
- Fall back gracefully: if the typed text is not an ID/email/URL/alias, the field behaves exactly like core autocomplete.
- Combine URL paste with subdirectory installs — the matcher strips the site base path before resolving.
- Populate reference fields quickly in migration cleanup, where source data carries IDs or URLs.
- Let power users who maintain content relationships work from known identifiers rather than search text.
- Reference the same entity by either its canonical `/node/N` path or its alias interchangeably.
- Disable the enhancement site-wide at any time by unchecking all entity types on the settings form.
