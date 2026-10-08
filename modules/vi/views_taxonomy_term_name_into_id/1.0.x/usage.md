<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Taxonomy Term Name Into ID adds a Views contextual-filter (argument) validator, "Taxonomy term name as ID", that accepts a human-readable term name in a URL and converts it to the term's numeric ID so the efficient "Has taxonomy term ID" filter can use it.

---

The module supplies a single Views argument-validator plugin,
`Drupal\views_taxonomy_term_name_into_id\Plugin\views\argument_validator\TermNameAsId`
(plugin id `taxonomy_term_name_into_id`), which extends core's `TermName` validator. When a view's
contextual filter (typically "Has taxonomy term ID", `taxonomy_index_tid`) is configured with
"Specify validation criteria" and this validator, an argument like `music` in the path is looked
up by term name and, if a matching accessible term is found, replaced with that term's ID before
the query runs. This lets you keep clean, human-readable URLs (e.g. `/articles/jazz`) while still
issuing the direct, index-based term-ID query rather than a slower name join. It inherits
`TermName`'s options: **Transform dashes in URL to spaces** (`transform`), **Filter to vocabulary**
(`bundles`), and access checking (`access`, `operation`). It restricts the lookup to the chosen
vocabularies when `bundles` is set. The conversion assumes a term name is unique; if several
vocabularies share a name, limit the validator to one vocabulary (otherwise only the first valid
match is used). It has no settings form, no configure route, no permissions, and no services — you
configure it entirely inside a view.

---

- Serve `/blog/jazz` instead of `/blog/12` while still using the fast "Has taxonomy term ID" filter.
- Give category/tag listing pages human-readable, SEO-friendly URLs based on term names.
- Convert a term name argument to an ID for a `taxonomy_index_tid` contextual filter.
- Restore the Drupal 7 "Term name converted to Term ID" validator behavior on Drupal 8–11.
- Let editors link to term pages by name without knowing numeric term IDs.
- Build a view whose path is `/team/[department-name]` and resolve it to the department term.
- Accept dashed URL segments (`new-york`) and match the term "new york" via the transform option.
- Limit name-to-ID resolution to a single vocabulary to avoid cross-vocabulary name clashes.
- Enforce access control on the resolved term via the validator's access option.
- Keep query performance high by avoiding a name-based join in the Views query.
- Provide friendly URLs for faceted/section landing pages driven by taxonomy.
- Power a menu of category links that use readable slugs resolved to term IDs.
- Support multilingual term names resolving to the correct term ID.
- Fail gracefully (validator returns not-found) when a name matches no term.
- Combine with a page display path like `/reviews/%` to accept a term name segment.
- Migrate legacy name-based taxonomy URLs into a modern Views setup.
- Avoid installing a heavier contextual-filter module when you only need name→ID conversion.
- Configure the validator per display so different displays can use different vocabularies.
- Export the view config (validate.type: taxonomy_term_name_into_id) for deployment.
- Reduce editor confusion by never exposing numeric term IDs in URLs.
