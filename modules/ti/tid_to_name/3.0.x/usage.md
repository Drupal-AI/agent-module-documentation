Term ID to Name registers a single Twig function, `tn(tid)`, that returns the (translated) name of a taxonomy term given its term ID, or an empty string if the TID is invalid or the term does not exist.

---

The whole module is one Twig extension (`src/TidToNameTwigExtension.php`, registered via
`tid_to_name.services.yml` with the `twig.extension` tag) exposing the function `tn`. Given a term ID
it validates the input is a positive numeric value, loads the `taxonomy_term` entity, then resolves the
translation for the current interface language through the entity repository
(`getTranslationFromContext`) and returns `getName()`. Invalid input, a non-existent term, or a
missing translation yields `''`. There is no config, no permissions, no schema, no Drush — install,
enable, and call the function in any Twig template. It is dependency-injected with the language
manager, entity repository and entity type manager. The typical use is turning a raw term ID (for
example a Views contextual-filter argument) into a human-readable, language-aware term name inside a
template or a rewritten field/title.

---

- Print a taxonomy term's name from its ID in a node/field/Views template: `{{ tn(123) }}`.
- Override a View's page title with a term name when using a taxonomy term contextual filter.
- Render the name of a referenced term when you only have the target ID available in Twig.
- Show a language-appropriate term name automatically on multilingual sites (current-language translation).
- Convert a term ID stored in a custom field or `drupalSettings` value into its label in a template.
- Build breadcrumb or heading text from a term ID passed as a route/argument.
- Display the term name in a block template where only the TID is in scope.
- Safely handle unknown/deleted terms — the function returns an empty string instead of erroring.
- Guard against bad input (0, negative, non-numeric) which also returns an empty string.
- Label a facet or filter value in a template when the underlying value is a term ID.
- Show the parent/category name for a piece of content when the template has the term ID.
- Turn term IDs from an imported/migrated field into readable names during theming.
- Compose an email or PDF template (rendered via Twig) that includes a term name from its ID.
- Add a term name to an aria-label or title attribute in a template.
- Populate a menu/tab label from a term ID in a custom Twig component.
- Print term names for multiple IDs by calling `tn()` in a Twig `for` loop.
- Provide term names in a decoupled/JSON-in-Twig preview template without a preprocess function.
- Replace a small custom preprocess hook that only existed to look up a term name.
- Localize a hard-to-reach term label in a paragraph/layout builder component template.
- Display a taxonomy-driven category name on a teaser where only the reference target ID is exposed.
