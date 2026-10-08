<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Creating and matching a Site meta rule

A rule is a `sitemeta` content entity. There is **no** settings/config form and **no** exportable
config — rules are content created through the admin UI (or the node edit form).

## Admin UI
- List: `admin/content/sitemeta` (also under Content > Site meta). Columns: Name, Path, Alias.
- Add: `admin/content/sitemeta/add` — permission `add site meta entities`.
- Edit / Delete: `.../{sitemeta}/edit`, `.../{sitemeta}/delete`.

## Fields (`src/Form/SiteMetaForm.php`)
- **Existing system path** (`path`, required): an internal path such as `/node/28`, `/forum/1`,
  `/taxonomy/term/1`, or a wildcard `/taxonomy/term/%`. On save an **alias is resolved to the internal
  path** (`AliasManager::getPathByAlias`). Validation requires a leading `/` and that the path is
  valid (or contains `%`); a duplicate path+langcode on a non-edit form is rejected.
- **Name/Title** (`name`): replaces the page `<title>`.
- **Description** (`description`): emitted as `<meta name="description">`.
- **Keywords** (`keywords`): emitted as `<meta name="keywords">`, comma-separated.

`description` and `keywords` support **tokens** (`token_element_validate`, token tree link with types
`node`, `term`). Tokens are replaced at render time against the current `node`/`taxonomy_term` with
`clear => TRUE` (unreplaced tokens are stripped). `name` also goes through token replacement in
`sitemeta_preprocess_html()` even though the form does not advertise the token tree for it.

## Matching order (`src/SitemetaGenerator.php`)
1. Exact `path` + current `langcode`.
2. Wildcard: rules whose `path` contains `%`; the text before the first `%` is a prefix matched
   (`str_contains`) against the current internal path **and** its alias.

Caveat: `wildcardCheck()` returns `FALSE` after evaluating only the **first** wildcard rule, so
multiple wildcard rules are not all considered. Prefer exact per-path rules where reliability matters;
use a single wildcard for one path family (e.g. all term pages).

## Setting meta from the node form
On an existing node's edit form, the **Custom meta** group (advanced sidebar) exposes Name/Title,
Description and Keywords; the path is fixed to `/node/{nid}` (disabled). Saving the node
creates/updates the `sitemeta` entity for that node. This path is driven by the node form, so a node
editor can set meta for their own node even without the `add site meta entities` permission.

## Language
Rules are matched by `langcode`; create one rule per language for a path if meta should differ.
