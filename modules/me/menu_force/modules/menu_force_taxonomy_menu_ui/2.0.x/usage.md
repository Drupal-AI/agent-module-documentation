<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Force - Taxonomy Menu UI is the taxonomy counterpart of Menu Force: it makes menu placement mandatory for terms in chosen vocabularies, so a term cannot be saved without a menu link. It requires the contrib `taxonomy_menu_ui` module, which adds the "Menu settings" UI to the term form.

---

This submodule of Menu Force mirrors the parent's behaviour for taxonomy terms instead of nodes. It depends on the contrib `taxonomy_menu_ui` module (which provides the menu widget on the term add/edit form). On the vocabulary edit form (`VocabularyForm`) it adds two checkboxes — "Make the Menu Settings mandatory for this content type" (`menu_force_taxonomy_menu_ui`) and "Lock the 'Default parent item' as well" (`menu_force_taxonomy_menu_ui_parent`) — and stores them as third-party settings on the `taxonomy.vocabulary.<vid>` config entity under the provider `menu_force_taxonomy_menu_ui`. When the first is on, the term add/edit form has its menu fieldset forced open, "Provide a menu link" checked and disabled, and the menu link title made required. When the second is on too, the parent-item selector is disabled, pinning new terms under a fixed parent. Enforcement is purely form-level (the menu link title becomes `#required`), so programmatic `Term::create()->save()` calls are not blocked. There is no settings page and no configure route.

---

- Force every term in a "Topics" vocabulary into the menu system before it can be saved.
- Guarantee taxonomy landing pages always appear in a navigation menu.
- Make the menu link title required when editors add a new category term.
- Auto-open and pre-check "Provide a menu link" on the term form so it cannot be skipped.
- Lock new terms of a vocabulary under one fixed parent menu item.
- Keep a category-driven mega-menu complete and gap-free.
- Ensure Pathauto/menu-token patterns for terms always have a menu entry to read.
- Enforce a consistent taxonomy-based navigation on a large content site.
- Require menu placement only on specific vocabularies while leaving others free.
- Prevent orphaned terms that never surface in any menu.
- Standardise how editors publish taxonomy landing terms into navigation.
- Pin product-category terms under a "Shop" parent in the main menu.
- Drive menu-based breadcrumb or visibility modules that assume terms are in the menu.
- Roll out mandatory term-menu placement through exported vocabulary config.
- Toggle the requirement per environment by overriding the vocabulary config.
- Reduce QA effort by making "add term to menu" impossible to forget.
- Combine with `taxonomy_menu_ui` to expose and require the menu widget on term forms.
- Keep menu-based sitemaps that include taxonomy terms complete.
- Ensure child terms are always attached under an existing parent for hierarchical menus.
- Support an information architecture where the menu tree is the canonical structure.
- Apply the same "must be in a menu" rule to terms that Menu Force applies to nodes.
- Enforce term menu placement without writing a custom validation constraint.
