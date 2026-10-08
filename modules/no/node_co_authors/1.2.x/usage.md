<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Co-Authors adds a co-authors field to nodes and grants those users the same "own content" rights over the node that the author has.

---

Install it with `composer require drupal/node_co_authors` and enable it (`drush en node_co_authors`); it depends only on core's **node** module and needs no configuration. Enabling it adds a revisionable, unlimited-cardinality **Co-authors** base field (an entity reference to users) to every content type, shown by default in the node form's Authoring-information group with an autocomplete widget — you can move or hide it per content type through the node's *Manage form display* / *Manage display* screens. Who may **edit that co-author list** is controlled by three permissions the module provides — *Edit the co-authors of own content*, *…of co-authored content*, and *…of all content* — plus `administer nodes`; grant them only to trusted roles, and note that the "co-authored content" one lets an existing co-author add further co-authors. What a co-author can then **do** with the node is deliberately tied to the standard "own content" permissions: `node_co_authors_node_access()` allows a co-author to edit, delete, or view-while-unpublished a node **only when they also hold** `edit own <type> content`, `delete own <type> content`, or `view own unpublished content` respectively (it conjoins the two with `->andIf()`, never granting more than the user's role already carries and never spilling to nodes they were not added to). The module also ships a Views filter, **(Co-)author name (autocomplete)**, that matches content by author or any co-author, and a `[node:co_authors_email]` token that returns co-authors' email addresses for use in notifications.

---

- Let two people edit one article.
- Share ownership of a page without changing its author.
- Hand content over while keeping the original author on record.
- Give a team edit rights to their own section.
- Credit a second writer on a node.
- Avoid granting the far-too-broad `edit any content`.
- Let an editor co-own a colleague's draft.
- Support a collaborative writing workflow.
- Allow a deputy to maintain a page.
- Let a co-author view an unpublished draft they were added to.
- Let a co-author delete their shared content when they have delete-own rights.
- Restrict who may add co-authors using the three module permissions.
- Let a trusted co-author add further co-authors (delegation chain).
- Cover for a colleague's absence on specific nodes.
- Support pair-authored documentation.
- Move or hide the Co-authors field per content type via Manage form display.
- Build a View listing nodes where a user is author or co-author.
- Email co-authors using the `[node:co_authors_email]` token.
- Model shared editorial responsibility for a departmental content owner.
- Delegate maintenance of a landing page shared between teams.
