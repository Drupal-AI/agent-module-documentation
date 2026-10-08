<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Revision Author Tokens exposes the author of a node **revision** as three `node` tokens, so a notification or a rendered field can say who made the latest change rather than who originally created the node.

---

Drupal's node tokens include `[node:author]`, which is the node's owner — the person who created it, and frequently not the person who just edited it. For any message about a change ("X updated this page", a moderation notification naming the reviewer) the useful identity is the *revision* author, and core provides no token for it. This module adds three via `revision_author_tokens.tokens.inc` (`hook_token_info()` + `hook_tokens()`), reading `$node->getRevisionUser()`: `[node:revision-author]` (the user's display name), `[node:revision-author-uid]` (their user id), and `[node:revision-author-mail]` (their email). Each returns an empty string when no revision user is set. Core `token` is the only dependency; there are no routes, permissions, config, schema, or plugins — the `.module` file is empty. Because they are ordinary node tokens they work anywhere tokens are consumed: Pathauto patterns, Metatag, Views, mail bodies, and ECA/Rules actions. Note the README calls the email token `[node:revision-author-email]`, but the registered id is `revision-author-mail` — the working token is `[node:revision-author-mail]`. The usual token caution applies with particular force here: these tokens name a person and one exposes their email, so a pattern that puts a revision author into a public URL alias or a meta description discloses who edited a page — and their address — to everyone who reads it.

---

- Name the person who made the latest edit with `[node:revision-author]`.
- Send a notification saying who changed a page.
- Include the reviewer's name in a moderation message.
- Show the last editor in a rendered field or Views area.
- Build a message template naming the editor.
- Distinguish the node creator (`[node:author]`) from the last editor (`[node:revision-author]`).
- Drive an ECA or Rules action with the revision author.
- Email the editor's address using `[node:revision-author-mail]`.
- Reference the editor's uid with `[node:revision-author-uid]` for downstream lookups.
- Attribute a change in a workflow notification.
- Include the editor in an internal audit message.
- Notify a team of who published or updated a page.
- Personalise an editorial notification with the editor's name.
- Reference the editor in a Metatag description (internal pages only).
- Use the revision author in a Rules condition.
- Report on recent editors of content.
- Name the approver in a confirmation message.
- Improve accountability in editorial messaging.
- Log who changed content, with their email, in an admin-only report.
- Resolve the editor of a specific historical revision by passing that revision to the token service.
- Fill a mail "from"/attribution line with the last editor's details.
- Swap `[node:revision-author]` in wherever a "who edited this" placeholder is needed.
