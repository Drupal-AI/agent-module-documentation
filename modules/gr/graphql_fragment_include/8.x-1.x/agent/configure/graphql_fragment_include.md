<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring GraphQL Fragment Include

1. Enable with GraphQL: `drush en graphql graphql_core graphql_fragment_include -y`.
2. Go to *Configuration > GraphQL > Fragment Include* (`/admin/config/graphql/fragment-include`, needs `administer site configuration`).
3. Set **Fragments base directory** — must start with a leading slash, relative to `DRUPAL_ROOT`, e.g. `/sites/default/graphql/fragments`.
4. Create `.gql` fragment files under that directory (subdirectories allowed).
5. In a query, add include lines at the top:
   ```graphql
   # include Image.gql
   { content: nodeById(id: "1") { ... on NodeArticle { image: fieldImage { entity { ...Image } } } } }
   ```
   The loader replaces each `# include X` with the file's contents before execution; nested includes are resolved recursively and each fragment is loaded at most once.

**Notes**
- Keep the base directory limited to fragment files only. The loader reads any file whose resolved path is within the base dir (not just `.gql`), and the prefix containment check has no trailing-separator guard — avoid sibling directories whose names start with the base-dir name.
- Missing/invalid includes are skipped and logged to dblog (channel `graphql_fragment_include`).
- The include syntax can be changed by extending the `graphql_fragment_include.graphql_fragment_loader` service.