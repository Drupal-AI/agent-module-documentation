<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Redirect sends the user to a configurable destination after they add, edit, or delete an entity, set per bundle (content type, media type, vocabulary, etc.). It is ideal for "add another" data-entry workflows or sending contributors to a thank-you page after they save.

---

Entity Redirect works by third-party settings on **bundle** config entities and a submit handler on the entity form. On a bundle's edit form (e.g. a content type at `/admin/structure/types/manage/<bundle>`) it adds, inside the *workflow* group, a "Redirect after Entity Operations" fieldset with a details section per **action**: `add`, `edit`, `delete`, plus an `anonymous` override. Each action has an `active` toggle and a `destination` choice: `default` (no change), `add_form` (go to a fresh add form), `edit_form` (back to the entity's edit form), `created` (view the saved entity), `url` (a local path like `/thanks`), `previous_page` (the page the form was submitted from, via the referrer), `layout_builder` (the entity's Layout Builder page — only when `layout_builder` is enabled), and `external` (a fully-qualified external URL — only for users with the `set external entity redirects` permission, sent via a `TrustedRedirectResponse`). Settings are stored at `<bundle_config>.third_party_settings.entity_redirect.redirect.<action>.{active,destination,url,external}`. On the entity's add/edit form a submit handler reads the bundle settings and calls `setRedirect()` accordingly; the `anonymous` action lets you override the destination just for anonymous users, and `personalizable` allows privileged users to set their own redirect on their profile. Schema ships for node, media, taxonomy, contact, paragraphs, profile and webform bundles. There is no global settings page, no route, and no Drush command.

---

- Return to a fresh "add" form after saving a node, for fast repeated data entry.
- Send a contributor to a thank-you page after they submit content.
- Redirect editors back to the edit form after saving (stay on the entity).
- Go straight to the saved entity's canonical page after creating it.
- Send users to a specific local path (e.g. `/dashboard`) after add or edit.
- Return the user to the page they came from using the previous-page/referrer option.
- Jump to the entity's Layout Builder page after creating it (with Layout Builder enabled).
- Redirect to an external URL after save for users granted `set external entity redirects`.
- Configure different destinations for add vs edit vs delete on the same bundle.
- Override the redirect just for anonymous users (e.g. a public submission form).
- Set per-user personalized redirects on a profile for privileged users.
- Streamline a moderation queue by returning to the add form after each item.
- Apply redirects to media types, taxonomy vocabularies, or contact forms, not just nodes.
- Redirect after deleting an entity to a listing or dashboard page.
- Build a "create many in a row" content-entry UX without custom code.
- Send survey/webform submitters to a confirmation page after saving.
- Keep translators on the edit form after saving a translation.
- Route new paragraphs-type or profile entities to a chosen destination after save.
- Send users to a campaign landing page after they contribute a story.
- Configure the behaviour via exported bundle config (`third_party_settings.entity_redirect`).
- Differentiate anonymous vs authenticated post-save journeys on the same form.
- Avoid writing a custom form submit handler just to change where a save lands.
