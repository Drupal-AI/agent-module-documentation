<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds an improved language switcher to entity edit forms so editors can move between a content item's translations directly from the form.
---
The module sets a `content_language_switcher` entity handler on every translatable entity type (`hook_entity_type_alter`) and, late in `hook_form_alter`, lets that handler (`ContentLanguageSwitcherHandler`) alter add/edit/default content-entity forms to render the switcher (themeable via the `content_language_switcher` template). It also removes the separate "Translate" local task tabs (`hook_local_tasks_alter`) so translation navigation lives on the form itself, giving a smoother editing flow than the default content-translation overview.

This is an administrative UX enhancement for content translation: it has no routes, permissions or write endpoints of its own and relies entirely on core Content Translation's existing access controls for who may edit which translation. Setup is simply enabling the module on a multilingual site with Content Translation configured.
---
- Switch between an entity's translations from the edit form.
- Show available translation languages inline on content forms.
- Streamline the multilingual editing workflow for editors.
- Remove the separate Translate tab in favour of the inline switcher.
- Apply to any translatable entity type automatically.
- Indicate the current editing language on the form.
- Theme the switcher via the provided template.
- Work with add, edit and default entity form operations.
- Reduce clicks when maintaining many translations.
- Rely on core Content Translation access for permissions.
- Improve the admin UI without custom routes.
- Support nodes, taxonomy terms, media and other translatable entities.
- Keep translation navigation next to the content being edited.
- Let editors jump to create a missing translation.
- Preserve core translation behaviour while improving its UI.
- Order the switcher hook to run after other form alters.
- Provide a consistent switcher across entity types.
- Help reviewers compare translations while editing.
- Reduce reliance on the content-translation overview page.