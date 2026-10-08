<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Moderation State Sync syncs Content Moderation state between languages.

---

Moderation State Sync **keeps the Content Moderation state in sync between translations** — so when one
translation of a node changes moderation state (draft/published/archived), the other translations follow,
avoiding translations drifting into inconsistent published/unpublished states. It depends on core Content
Moderation.

Use it on multilingual, moderated sites to keep translations' states aligned. It is an editorial-workflow/
multilingual feature; moderation state affects publish status (which governs visibility), so syncing it changes
what's published across languages — intended behaviour, but be aware it can publish/unpublish translations
together. It follows Content Moderation's own access and has no access-control role. Configure the state sync.

---

- Sync moderation state across translations.
- Keep translations' states aligned.
- Avoid inconsistent publish states.
- Depend on core Content Moderation.
- Follow one translation's state change.
- Serve multilingual moderation.
- Know it changes publish status across languages.
- Follow Content Moderation access.
- Have no access-control role.
- Configure the state sync.
- Handle moderation sync.
- Sync states.
- Configure syncing.
- Handle the states.
- Align translations.
- Configure moderation.
- Handle the workflow.
- Sync publishing.
- Set the sync.
- Provide moderation sync.
