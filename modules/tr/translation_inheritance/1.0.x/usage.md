<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Translation Inheritance lets a content entity's translation point at another language and render that source language's content, rather than duplicating it per language.

---

The module provides an `InheritTranslationItem` field type and `InheritTranslationWidget` whose value is a `source_language`. `TranslationInheritance::getCorrectTranslation()` walks the inheritance chain (which may be recursive) to resolve the actual translation to render, and hook_entity_view_alter / form_alter integrate this into entity display and edit forms (the inherit field is hidden on the default translation). Settings live at `/admin/config/content/translation-inheritance` (permission `administer translation inheritance`), and an install file/config schema back the field. It depends on core `language` and `content_translation`.

There are no anonymous or mutating endpoints — the only route is the permission-gated admin settings form; the module's logic runs through field/entity hooks, so there is no notable security surface. Typical setup: enable the module, add the inherit-translation field to a translatable bundle, and let editors mark a translation as inheriting from a chosen source language.

---

- Link a translation to another language's content.
- Avoid duplicating content across languages.
- Render a page using an inherited source translation.
- Resolve recursive inheritance chains to the real source.
- Add the inherit-translation field to a content type.
- Hide the inherit field on the default translation.
- Configure module behavior on the settings form.
- Let editors pick a source language per translation.
- Keep a secondary language in sync by inheritance.
- Fall back to a base language for untranslated content.
- Manage inheritance for translatable entity bundles.
- Integrate with core content_translation workflows.
- Use a dedicated field widget to choose the source language.
- Restrict configuration to authorized administrators.
- Reduce translation maintenance overhead.
- Present shared content across regional language variants.
- Support multi-step language fallbacks.
- Alter entity view to substitute the inherited translation.
- Add the field via standard Field UI.
- Provide consistent content across language variants.
