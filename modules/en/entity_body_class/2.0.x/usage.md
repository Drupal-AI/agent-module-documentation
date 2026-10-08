<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity body class adds a "Body CSS class(es)" base field to every content entity with a canonical URL, and outputs that field's value (token-aware) as a class on the page `<body>` tag.

---

The module implements `hook_entity_base_field_info()` to add a translatable string base field `entity_body_class` ("Body CSS class(es)") to all content entity types that expose a `canonical` link template — nodes, taxonomy terms, users, comments, media, and so on. Whatever an editor enters there (multiple space-separated classes, and Drupal tokens such as `[language:langcode]`) is appended to `$variables['attributes']['class']` in `hook_preprocess_html()` when that entity's page is viewed, so themes can style pages by entity context without writing custom preprocessing. A site-wide settings form at `/admin/config/content/body-class-settings` stores per-entity-type default values (config `entity_body_class.settings`, key `types`) that pre-fill the field on new entities. Two static permissions plus one dynamic per-entity-type permission control who sees the field and who edits the defaults. Field values are run through `Xss::filter()` by a form validation handler, and the field can be hidden per bundle via Manage form display. It requires no other modules; if the Token module is present, a token browser link is shown next to the field.

---

- Add a CSS class to the `<body>` of a specific node's page.
- Style landing pages differently by tagging them with a body class.
- Give one content type a distinct body class for theme targeting.
- Flag a hero/campaign page so its CSS kicks in only there.
- Add a body class to taxonomy term pages for section styling.
- Style user profile pages with a per-user or per-role body class.
- Style media entity pages via a body class.
- Style comment permalink pages via a body class.
- Set a default body class for all new articles from the settings form.
- Set different default body classes per entity type.
- Build dynamic body classes from tokens, e.g. `[node:content-type]` or `[language:langcode]`.
- Add a language-derived body class for per-language styling.
- Apply multiple space-separated classes to a single page's body.
- Drive JS behaviors that hook onto a body class per page.
- Restrict who can edit body classes using the "Manage body class fields" permission.
- Grant body-class editing for only one entity type via its dedicated permission.
- Keep default-value management to trusted admins via "Manage body class settings".
- Hide the body-class field on a specific bundle via Manage form display.
- Translate the body class per language on translatable entities.
- Give print/PDF or A/B-test variants a body class hook.
- Mark editorial states (e.g. sponsored) with a body class for styling.
- Provide per-page theming hooks without adding template suggestions.
- Add a body class used only by an accessibility or high-contrast stylesheet.
- Enable section-specific navigation highlighting via a body class.
- Prefill a consistent body class on new content to reduce editor error.
