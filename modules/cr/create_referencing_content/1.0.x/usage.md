<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Gives site users a button on a piece of content that opens an add form for another content type with an entity-reference field pre-filled to point back at the content they were viewing.

---

Create Referencing Content button lets a site builder place a button (rendered as an extra pseudo-field, provided via Extra Field Plus / Extra Field Configuration) on the display of a "referenced" content type. When an authorized user views that content, the button links to the standard `entity_type/add/bundle` form of the "referencing" content type with a query parameter that Entity Prepopulate (EPP) uses to fill the chosen entity-reference field with the ID of the content just viewed. Configuration is done entirely through Drupal's Manage Display UI plus the Extra Field admin: you pick the target entity-reference field, set the button label, tooltip, and CSS classes, and the module writes the matching EPP third-party setting onto that field automatically. It ships no routes, no permissions, and no config schema of its own — content creation still goes through core's normal add-form access checks. Requires the `epp`, `extra_field_plus`, and `extra_field_configuration` modules and supports Drupal 8 through 11.

---

- Add a "Leave a review" button to Article nodes that opens a Review add form referencing the article.
- Add a "Post your take on this recipe" button that opens a Recipe add form back-referencing the source recipe.
- Let visitors create response content that undergoes moderation instead of using comments.
- Pre-fill an entity-reference field on the new content with the ID of the content being viewed.
- Configure the button through the referenced content type's Manage Display page.
- Choose which entity-reference field on the referencing bundle receives the pre-populated value.
- Set custom anchor text (label) for the button per display.
- Set a translated tooltip on the button link.
- Apply space-separated CSS classes (default `button is-primary is-medium`) for theming.
- Render the button through a single-directory component (SDC) so themers can override the markup.
- Have EPP third-party settings written onto the target field automatically when you save the display.
- Surface create-content links only where a target field is configured (button hidden otherwise).
- Build networks of linked content (articles ↔ reviews, recipes ↔ variations, employers ↔ applications).
- Give editors a one-click path from viewing content to authoring related content.
- Limit the button to reference fields whose target type and bundle match the current entity.
- Place the button on any content entity type supported by Extra Field Plus, not just nodes.
- Keep the reference wiring in code rather than asking editors to copy IDs manually.
- Pair with the Read-only field widget module so the pre-filled reference cannot be changed by the author.
- Replace fragile manual "create related X" workflows with a configured, repeatable button.
- Style the button as a primary call-to-action on landing or detail pages.
- Provide contributor-friendly "add your own" entry points on community content sites.
