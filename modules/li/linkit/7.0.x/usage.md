Linkit gives WYSIWYG editors an autocomplete field for building internal and external links, so authors can search for content by title instead of pasting raw URLs.

---

Out of the box Drupal lets editors paste a URL into the CKEditor link dialog, but they have to know the path in advance. Linkit replaces that field with an autocomplete that searches nodes, users, taxonomy terms, files, comments, contact forms, and any entity exposing a canonical link. Behaviour is driven by **Linkit profiles** (config entities at `/admin/config/content/linkit`), each holding an ordered list of **matcher** plugins that decide what can be found and how each suggestion is labelled. A profile is attached to the Drupal Link plugin on a text format, so different formats can expose different content. Instead of storing a fragile path, Linkit inserts a stable reference like `entity:node/1` plus `data-entity-*` attributes, and its **Linkit filter** rewrites that to a real URL at render time — so links survive alias changes. **Substitution** plugins control what URL an entity resolves to (canonical page, direct file download, or media source). Both matchers and substitutions are pluggable, configurable, and alterable, and metadata shown in suggestions supports tokens.

---

- Let editors link to a node by typing its title instead of finding its path.
- Autocomplete internal links inside CKEditor 5 in the Drupal link dialog.
- Search users and insert a link to a user profile.
- Link to taxonomy terms from body text.
- Link directly to an uploaded file for download.
- Link to media entities from the WYSIWYG.
- Link to contact forms by name.
- Add an "Email" suggestion that builds a `mailto:` link.
- Add a "Front page" suggestion for linking to the site home.
- Allow arbitrary external URLs alongside internal suggestions.
- Keep links stable when a URL alias changes, via the `entity:` reference and Linkit filter.
- Restrict which entity bundles appear as suggestions (e.g. only Articles).
- Show only published entities in suggestions to editors.
- Display rich metadata (author, date, status) next to each suggestion using tokens.
- Limit the number of suggestions returned for a matcher.
- Create separate profiles for different text formats or editor roles.
- Order matchers so preferred content types surface first.
- Add a thumbnail to file/media suggestions via the bundled image style.
- Automatically set link titles from the referenced entity's label.
- Choose whether a file link points to the file page or a direct download (substitution).
- Deploy Linkit profiles between environments as exportable configuration.
- Add autocomplete linking support to a custom entity type with a matcher plugin.
- Provide a custom URL substitution for a special entity type.
- Alter another module's matcher or substitution definitions via alter hooks.
- Gate profile administration behind the "administer linkit profiles" permission.
- Integrate IMCE file browsing into the linking workflow.
