<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Questions and Answers — agent orientation

Field-attached Q&A system: ask/answer/report/subscribe/helpful + moderation queue + email notifications.

- Version 8.x-1.x, core `^8||^9||^10`, dep user. Global settings `/admin/config/content/questions-answers` (`administer site configuration`); moderation `/admin/content/questions-answers*` (`administer questions and answers`). Permissions: ask/answer/report/subscribe.
- Formatter builds forms per current-user permission; entity queries use `accessCheck()` + `checkViewable()`. Question/answer text output via `t()` placeholders + Twig (escaped).
- User content escaped on output; per-permission gating throughout. No stored-XSS or access-bypass found.