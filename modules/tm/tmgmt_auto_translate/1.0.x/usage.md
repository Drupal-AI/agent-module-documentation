<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Translation Management Auto Translate automatically translates content when published or when a specific moderation state is reached.

---

Translation Management Auto Translate automatically translates content through TMGMT — triggering a
translation job when content is published or reaches a configured moderation state, so translations are
created automatically without manual submission. It depends on the TMGMT module and core Node, in the
Translation Management package.

Use it to auto-translate content on publish/moderation transitions. Security/operational notes: it sends
content to the configured TMGMT translator (which may be an external machine-translation service — a
data-handling consideration for sensitive content, and auto-translation removes the human "should this be
sent?" gate, so be deliberate about which content types/states trigger it); auto-created translations may
need review before publishing. It has no access-control role. Configure the trigger states and translator.

---

- Auto-translate content via TMGMT.
- Trigger translation on publish.
- Trigger on a moderation state.
- Depend on TMGMT and core Node.
- Avoid manual translation submission.
- Send content to the TMGMT translator.
- Mind data sent to external translators.
- Be deliberate about which content triggers it.
- Review auto-created translations.
- Have no access-control role.
- Configure the trigger states.
- Configure the translator.
- Automate translation.
- Handle auto-translation.
- Translate on transitions.
- Configure auto-translate.
- Translate automatically.
- Handle translation triggers.
- Trigger translations.
- Auto-translate on publish.
