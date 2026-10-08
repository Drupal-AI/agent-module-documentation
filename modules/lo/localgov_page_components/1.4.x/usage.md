LocalGov Page Components re-labels Drupal's "Paragraphs library" feature as "Page components" and adds a ready-made node field plus LinkIt integration so editors can build pages from reusable, centrally managed content blocks.

---

The module ships a single unlimited-cardinality node entity-reference field, `localgov_page_components` (targets `paragraphs_library_item`), and an optional-install `page_components` Entity Browser (modal) that lets editors either select an existing library item or create a new one inline via `entity_browser_entity_form`. It contributes no admin settings page (`configure` is null) and no permissions of its own — access is governed by the underlying Paragraphs library, Entity Browser and node permissions. Its distinctive code is two LinkIt plugins for the `paragraphs_library_item` entity type: a `PageComponentMatcher` (`entity:paragraphs_library_item`) that "pretends" the target is a `paragraph` entity so suggestions can be filtered and grouped by *Paragraph* bundle (it also honours each item's `view` access when building suggestions), and a `ParagraphsLibraryItem` substitution plugin that returns a useful destination URL by reading the URL field of the referenced paragraph (hardcoded mapping: `localgov_contact` → `localgov_contact_url`, `localgov_link` → `localgov_url`), falling back to the library item's own canonical URL for other bundles. `src/Constants.php` centralises the label strings and route/action ids used to relabel the Paragraphs library UI as "Page component(s)". The bundled `localgov_page_components_workflow` submodule adds content-moderation cascade behaviour. Designed for the LocalGovDrupal distribution (used by the `localgov_services_page` content type) but usable on any content type.

---

- Add a "Page components" field to a content type so editors assemble pages from reusable blocks.
- Let editors pick an existing paragraphs library item instead of re-creating content.
- Create a brand-new reusable component inline from within the node form via the modal Entity Browser.
- Re-use one component (e.g. a contact card) across many pages and edit it once centrally.
- Present the Paragraphs library to editors under the friendlier "Page components" naming.
- Provide a modal "Add/Select component" browser tab that lists available components and a create form.
- Restrict which component (Paragraph) bundles appear in a LinkIt autocomplete via the Page components matcher.
- Group LinkIt suggestions by Paragraph bundle for clearer autocomplete results.
- Make LinkIt suggest Contact and Link page components when authoring rich-text links.
- Have LinkIt resolve a selected Contact/Link component to its real destination URL rather than `/admin/content/paragraphs/N`.
- Honour per-item view access when surfacing components in LinkIt suggestions.
- Build a LocalGov services landing page out of standardised reusable components.
- Standardise recurring page furniture (calls-to-action, contact blocks) as shared library items.
- Give non-technical editors a curated palette of approved content components.
- Reference the same component from multiple content types (field is reusable beyond services pages).
- Translate page components independently (the field is translatable).
- Keep a searchable central inventory of reusable components via the paragraphs library listing.
- Combine with the workflow submodule to gate component changes behind node publication.
- Migrate hand-built paragraph fields toward a shared-library model.
- Offer a consistent "Add Page component" action label across the admin UI.
- Extend the LinkIt substitution mapping in a fork/patch to cover additional paragraph bundles.
