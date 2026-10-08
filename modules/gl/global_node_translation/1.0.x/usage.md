<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Global Node Translation creates translations in all enabled languages when a node is created.

---

Global Node Translation **auto-creates translations on node create** — when a node is created in the original
language, it generates translation entities in all enabled languages, so every language has an entry from the
start. It depends on core Language and Content Translation.

Use it to seed all-language translations. It is a multilingual/content feature; it creates translation entities
(following core translation handling) and has no access-control role. Note: it creates (possibly empty) translations
that then need actual translating. Configure the auto-translation behavior.

---

- Auto-create translations on node create.
- Cover all enabled languages.
- Seed every language.
- Depend on core Language + Content Translation.
- Serve multilingual/content.
- Create translation entities.
- Follow core translation handling.
- Create (possibly empty) translations that need translating.
- Have no access-control role.
- Configure the auto-translation.
- Handle auto-translation.
- Create translations.
- Configure the behavior.
- Seed languages.
- Handle the node.
- Generate translations.
- Configure multilingual.
- Handle the languages.
- Add translations.
- Provide auto node translation.
