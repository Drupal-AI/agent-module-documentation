<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Translation Inheritance (translation_inheritance) — agent index

**Lets an entity translation inherit/link to another language's content instead of keeping its own copy.**

- **Version:** 1.0.x (1.0.0-beta6)
- **Core:** ^9.4 || ^10 || ^11 · **Depends:** language, content_translation
- **Config route:** `translation_inheritance.settings` → `/admin/config/content/translation-inheritance` (permission `administer translation inheritance`)
- **Field type/widget:** `InheritTranslationItem` / `InheritTranslationWidget` (value: `source_language`).
- **Resolver:** `TranslationInheritance::getCorrectTranslation()` walks the (possibly recursive) inheritance chain; integrated via entity view/form_alter hooks.

**Security:** the only route is the permission-gated admin settings form; logic runs through field/entity hooks. No anonymous or mutating endpoints — no notable security surface.

See [configure/translation_inheritance.md](configure/translation_inheritance.md)
