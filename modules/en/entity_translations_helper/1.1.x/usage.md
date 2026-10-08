<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity translations helper adds two editor conveniences to multilingual content forms: a panel of add/edit links for the translations of referenced entities, and a notice telling editors which language they are creating content in.

---

Install and enable it like any module (`composer require drupal/entity_translations_helper` then enable it) — it depends on core's **Content Translation** and has **no settings page**; its two features switch on automatically where they apply. The first feature helps when you translate an entity that references other translatable entities (media, taxonomy terms, paragraphs) through **non-translatable** entity-reference fields, and you have turned on core's **"Hide non translatable fields on translation forms"** for the bundle (on the *Content language and translation* settings). On the translation edit form the module then adds a **"Manage related translations"** section listing each referenced translatable entity with an **Add** or **Edit** link for the current language; non-node entities open in an in-page **modal** that closes and refreshes the link after you save, while nodes open in a new browser tab. It follows `paragraph` references recursively (up to five levels deep) so composite content is reachable too. The second feature appears on the **create** form of a new **node, media, or taxonomy term** whose bundle has language locked to the interface/URL rather than a language selector element: it shows a **"You are creating this … in *language*"** notice with one-click links to switch to creating the same content in another language, which prevents the common mistake of authoring content in the wrong language. That notice is exposed as the `entity_translations_helper_language` pseudo-field, so you can reorder or hide it per bundle under *Manage form display*. Everything is UI/editor-facing — there are no routes, permissions, drush commands, or configuration to manage.

---

- Give translators Add/Edit links to related translatable entities on a translation form.
- Manage referenced-entity translations without leaving the main translation form.
- Edit a referenced media item's translation in a modal from a node translation form.
- Edit a referenced taxonomy term's translation in a modal.
- Open a referenced node's translation form in a new browser tab from the panel.
- Reach translations of paragraphs referenced by a node.
- Complement core's "Hide non translatable fields on translation forms" option.
- Keep untranslatable entity references reachable when their fields are hidden.
- Refresh a translation link in place after saving in the modal.
- Show editors which language they are creating content in.
- Offer one-click switching to create the same content in another language.
- Prevent editors from accidentally authoring content in the wrong language.
- Add the language notice to node, media, and taxonomy term creation forms.
- Reorder or hide the language helper per bundle via Manage form display.
- Reduce back-and-forth navigation between an entity and its referenced translations.
- Speed up multilingual editorial workflows.
- Help editors on sites configured with many languages.
- Guide translators through composite (paragraph-based) content translations.
- Avoid orphaned, untranslated referenced entities.
- Provide contextual translation UX without writing custom code.
