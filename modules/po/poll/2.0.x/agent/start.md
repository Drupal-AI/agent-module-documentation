<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Poll (poll) — agent index

Poll captures votes on multiple-choice questions. Two content entities: `poll` (question +
settings) and `poll_choice` (an answer option). Votes live in the `poll_vote` table, not as
entities. Documented release **2.0.0-alpha5 (alpha — pre-stable)**. Dependencies: field, node,
options, views, user. Admin list: `/admin/content/poll`; add: `/poll/add`; view: `/poll/{id}`.

- **Create/manage polls & choices, entity fields, votes, the block, Views** → [configure/poll.md](configure/poll.md)
- **Create polls, choices & votes programmatically; poll_vote.storage service** → [api/poll.md](api/poll.md)
- **The 9 permissions and what each gates** → [permissions/poll.md](permissions/poll.md)
