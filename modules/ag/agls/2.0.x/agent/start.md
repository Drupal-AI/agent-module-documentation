<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AGLS (agls) — agent index

Adds the **AGLS (Australian Government Locator Service)** metadata tags to Drupal via **Metatag**.
It is a set of Metatag plugins — one group + ~16 `AGLSTERMS.*` meta tag plugins — plus a hook that
adds the AGLS schema profile `<link>`s. Version **2.0.0**, core `^9.3 || ^10 || ^11`, **PHP 8.0**,
package `Metatag`, license GPL-2.0-or-later.

- **Every tag, the group, the schema-link hook, and how to configure/operate it** →
  [plugins/metatag-tags.md](plugins/metatag-tags.md)

## What it actually is (from source)

- **Dependency:** `metatag:metatag` (`^2.0`). No routes, no permissions, no services, no config
  objects, **no config schema** of its own (tag config is stored/validated by Metatag).
- **Group plugin:** `src/Plugin/metatag/Group/Agls.php` — `@MetatagGroup(id="agls")`, extends
  `GroupBase`. All tags belong to this group.
- **Tag plugins:** `src/Plugin/metatag/Tag/*.php`, each a `@MetatagTag` extending metatag's
  `MetaNameBase` (rendering/escaping is entirely metatag's). Names are `AGLSTERMS.<term>`, all
  `type="label"` (except `agls_datelicensed` = `type="date"`), `secure=FALSE`, `multiple=FALSE`.
- **Hook:** `agls.module` `agls_metatags_attachments_alter()` appends two `<link>` head elements
  with fixed hrefs — `rel="schema.dcterms"` → `purl.org/dc/terms/`, `rel="schema.AGLSTERMS"` →
  `www.agls.gov.au/agls/terms/` (required by the AGLS HTML5 profile). `agls_help()` renders
  README.md on the module help page.
- **No submodules.** Dublin Core AGLS properties (creator/title/date/…) come from Metatag's own
  Dublin Core submodule, not this project.

## Tag ids (all group `agls`)

`agls_act`, `agls_aggregationlevel`, `agls_availability`, `agls_case`, `agls_category`,
`agls_datelicensed`, `agls_documenttype`, `agls_function`, `agls_isbasedon`, `agls_isbasisfor`,
`agls_jurisdiction`, `agls_mandate`, `agls_protectivemarking`, `agls_regulation`,
`agls_servicetype`.

See [../usage.md](../usage.md) for prose and use cases.
