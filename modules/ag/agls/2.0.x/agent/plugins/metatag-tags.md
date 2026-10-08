<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AGLS Metatag group, tags and profile links

## Install & enable

```bash
composer require drupal/agls   # pulls drupal/metatag ^2.0
drush en agls -y
```

Requires **Metatag 2.0+** and **PHP 8.0**. There is nothing to configure in this module itself — it
only registers Metatag plugins; you configure them from Metatag's UI (see below).

## The group

`src/Plugin/metatag/Group/Agls.php` — `@MetatagGroup(id = "agls", label = "Agls")`, extends
`Drupal\metatag\Plugin\metatag\Group\GroupBase`. Every tag below is assigned `group = "agls"`, so
Metatag renders them together under an "Agls" fieldset on each metatag configuration form.

## The tags

Each file in `src/Plugin/metatag/Tag/` is a `@MetatagTag` annotation extending metatag's
`MetaNameBase` with an empty body — behaviour, value handling and output (including HTML escaping of
the `content` attribute) are entirely inherited from `MetaNameBase`. All are `secure = FALSE`,
`multiple = FALSE`, group `agls`.

| Plugin id | `name` output | Type | Weight | Notes |
|---|---|---|---|---|
| `agls_act` | `AGLSTERMS.act` | label | 0 | |
| `agls_aggregationlevel` | `AGLSTERMS.aggregationlevel` | label | 1 | item vs. collection |
| `agls_availability` | `AGLSTERMS.availability` | label | 2 | mandatory for offline resources |
| `agls_case` | `AGLSTERMS.case` | label | 3 | |
| `agls_category` | `AGLSTERMS.category` | label | 4 | service / document / agency |
| `agls_datelicensed` | `AGLSTERMS.dateLicensed` | date | 5 | only `type="date"` tag |
| `agls_documenttype` | `AGLSTERMS.documentType` | label | 6 | |
| `agls_function` | `AGLSTERMS.function` | label | 7 | recommended if no DC subject |
| `agls_isbasisfor` | `AGLSTERMS.isBasisFor` | label | 8 | relationship |
| `agls_isbasedon` | `AGLSTERMS.isBasedOn` | label | 9 | relationship |
| `agls_jurisdiction` | `AGLSTERMS.jurisdiction` | label | 10 | political/administrative entity |
| `agls_mandate` | `AGLSTERMS.mandate` | label | 11 | legislation/authority |
| `agls_protectivemarking` | `AGLSTERMS.protectiveMarking` | label | 12 | security classification |
| `agls_regulation` | `AGLSTERMS.regulation` | label | 13 | |
| `agls_servicetype` | `AGLSTERMS.serviceType` | label | 14 | |

Each renders as `<meta name="AGLSTERMS.<term>" content="<value>">`. Values may be plain text or
Metatag tokens; token replacement and attribute-context escaping are handled by Metatag core.

> The README lists a few AGLS terms (rightsHolder, spatial, temporal) that are **not** shipped as
> plugins in this release; the Dom/Dublin-Core-shared properties are provided by Metatag's Dublin
> Core submodule, not here. Document only the plugin ids in the table above.

## Required profile links

`agls.module` implements `hook_metatags_attachments_alter()` and appends two fixed `<link>`
elements to `#attached[html_head]` on every page Metatag renders:

```html
<link rel="schema.dcterms" href="http://purl.org/dc/terms/">
<link rel="schema.AGLSTERMS" href="http://www.agls.gov.au/agls/terms/">
```

Both hrefs are hard-coded constants (per the AGLS HTML5 validation profile); nothing dynamic is
written into them.

## Configuring the tags (via Metatag)

1. `admin/config/search/metatag` — edit a **default** metatag configuration (e.g. Content, or a
   specific bundle) and fill in the AGLS fields, or add a new default for the entity type/bundle you
   want AGLS metadata on.
2. To override per node/term/user, add a **Metatag** field to that bundle and set values on the
   entity edit form.
3. Values support Metatag tokens, so you can, for example, drive `AGLSTERMS.dateLicensed` from a
   date field or `AGLSTERMS.jurisdiction` from a site-wide constant.

## Help page

`agls_help()` returns `README.md` on `help.page.agls` — rendered through the `markdown` filter if
the (suggested) `drupal/markdown` module is enabled, otherwise wrapped in `<pre>`.
