Pathauto automatically generates clean, human- and SEO-friendly URL aliases (like `/blog/my-first-post`) for content, users, taxonomy terms, and other entities from configurable token-based patterns, so editors never have to set paths by hand.

---

Out of the box Drupal lets you type a URL alias per node, but doing that manually across a whole site is tedious and inconsistent. Pathauto solves this by letting you define **patterns** — e.g. `[node:content-type]/[node:title]` — per entity type and bundle, and it then creates or updates the alias whenever content is saved. It relies on the Token module for the placeholders in those patterns and on core's Path module for storing the aliases. Aliases are cleaned according to global settings: a configurable word separator, maximum length, transliteration of accented characters to ASCII, case handling, and a list of "ignore words" (a, an, the, …) that are stripped. Patterns are config entities (`pathauto.pattern.*`), so they are exportable and deployable like any other configuration. When content changes you choose an update action — do nothing, create a new alias, or (with the Redirect module) create a redirect from the old alias. Site builders manage everything at Admin → Configuration → Search and metadata → URL aliases, including bulk generation for existing content and bulk deletion. Developers can add new aliasable entity types with an `AliasType` plugin, generate aliases programmatically via the `pathauto.generator` service, and fine-tune behavior through a set of alter hooks. It is a near-universal SEO building block and a hard dependency for many content-heavy sites.

---

- Auto-generate `/section/title` URLs for every node on save.
- Give articles date-based paths like `[node:created:custom:Y]/[node:title]`.
- Create clean taxonomy term paths such as `topics/[term:name]`.
- Generate user profile aliases like `members/[user:account-name]`.
- Enforce a consistent URL structure across an entire site.
- Improve SEO with keyword-rich, readable URLs.
- Transliterate accented/non-Latin titles into ASCII slugs.
- Strip stop-words (a, an, the) from generated aliases.
- Set a maximum alias length to avoid overly long URLs.
- Choose a custom word separator (hyphen vs underscore).
- Bulk-generate aliases for thousands of existing pieces of content.
- Bulk-delete all auto-generated aliases before a re-import.
- Create a redirect from the old URL when a title changes (with Redirect module).
- Keep aliases stable by choosing "do nothing" on updates.
- Define different patterns per content type or per vocabulary.
- Restrict a pattern with conditions (e.g. only a specific language or bundle).
- Deploy URL patterns between environments as exportable config.
- Provide clean URLs for Commerce products and categories.
- Add pathauto support to a custom entity type via an AliasType plugin.
- Programmatically create an alias for an entity in custom code.
- Update all aliases after changing a pattern.
- Avoid duplicate aliases with automatic uniquifying suffixes (`-0`, `-1`).
- Reserve certain paths so pathauto never collides with them.
- Alter a generated alias in code before it is saved.
- Localize aliases per language on multilingual sites.
- Notify editors when a path changes (permission-gated).
- Standardize URLs for a headless/decoupled front end that reads path aliases.
- Give menu and breadcrumb systems predictable, readable paths.
