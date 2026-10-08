<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# author_field — field type, widget & formatters

All classes under `src/Plugin/Field/`; templates under `templates/`; JS in
`js/authorfield.ui.default.js`.

## Field type `author_field` (`FieldType/AuthorFieldItem.php`)

- `@FieldType(id="author_field", default_widget="author_field_widget",
  default_formatter="author_field_default", category="General")`.
- `propertyDefinitions()` / `schema()` — five `string` / `varchar(255)` columns:
  `family_name`, `given_name`, `email`, `orcid_id`, `organization_name`. No constraints, no
  `email`-type validation — `email` is a plain string, **not** an email data type.
- `isEmpty()` returns TRUE only when all five sub-values are NULL or `''`.
- Stored inline on the host entity; there is no reference to a `user` entity.

## Widget `author_field_widget` (`FieldWidget/AuthorFieldWidget.php`)

- Injects `config.factory` and `http_client` (Guzzle). `formElement()` builds a `details`
  ("Author Details") containing:
  - `orcid_search_info` — Search textfield with `#autocomplete_route_name: author_field.autocomplete`
    and an `#ajax` callback on `autocompleteclose` → `orcidCallback()`.
  - `family_name`, `given_name`, `email`, `orcid_id`, `organization_name` textfields, each rendered
    only when its `hide*` setting is FALSE.
- **Instance settings** (`defaultSettings()` / `settingsForm()`): `hideGivenName`, `hideFamilyName`,
  `hideEmail`, `hideOrganizationName`, `hideNameIdentifier` (all bool, default FALSE). Coerced with
  `boolval()` in `sanitizeSettings()` (no schema, so validation is on use).
- `orcidCallback()` — reads the picked ORCID from the triggering element, `urlencode()`s it, queries
  the configured ORCID endpoint (`?q=orcid:<id>&fl=orcid,given-names,family-name,email,current-institution-affiliation-name&rows=1`,
  `Accept: application/vnd.orcid+json`), and writes `given_name` / `family_name` / `email` /
  `orcid_id` (from `orcid-id`) / `organization_name` (first `institution-name`) back into the
  sub-field `#value`s. Sandbox vs production chosen by config `author_api` (0 = sandbox, 1 = prod).
- `massageFormValues()` normalizes each sub-value to NULL when `''`.

## Formatters (`FieldFormatter/*`)

| ID | Class | Theme hook | Purpose |
|----|-------|------------|---------|
| `author_field_default` | `AuthorFieldDefaultFormatter` | `author_field_default` | Multi-author byline; affiliation superscripts + collapsible list |
| `configurable_author_field_formatter` | `ConfigurableAuthorFieldFormatter` | `configurable_author_field_formatter` | Labels, ORCID URL/icon, link target + rel options |
| `author_field_name_formatter` | `AuthorFieldNameFormatter` | `author_field_name_formatter` | Name only, optional ORCID link |

- Default formatter: `viewElements()` builds an `#authors` array (per delta: given/family name, email,
  orcid_id, organization_name, a `superscript` index computed from a de-duplicated
  `#organization_list`, and `delta` = total count). Only the first render item is populated.
- Configurable + name formatters share `defaultSettings()`: `authorNameLabel` (Name),
  `authorEmailLabel` (Email), `orcidUrlLabel` (Name identifier), `authorOrganizationLabel`
  (Organization), `authorNameLabelLink` (TRUE), `orcidLabelIconOrLink` (`url`|`icon`),
  `showORCIDUrl` (TRUE), `showORCIDUrlLink` (TRUE), `ORCIDOpenLinkIn` (`_self`|`_blank`),
  `orcidurlnoreferrer` / `orcidurlnoopener` / `orcidurlnofollow` (FALSE). `#author_name` is built as
  `given_name . ' ' . family_name`. `sanitizeSettings()` whitelists the enum settings against
  `getAuthorOpenLinkInValues()` / `getOrcidLabelOptions()` and `boolval()`s the flags; if
  `showORCIDUrl` is FALSE it forces `showORCIDUrlLink` FALSE.

## Templates & rendering

- `templates/author-field-default.html.twig` — byline, ORCID logo `<img src="/<module>/images/orcid.svg">`
  (path derived from `_self`), and a jQuery-UI tooltip / "Show affiliations" toggle wired by
  `js/authorfield.ui.default.js` (`Drupal.behaviors.authorFieldTooltip`, library
  `author_field/author_field_ui_default`, which depends on `jquery_ui_tooltip/tooltip`).
- `templates/configurable-author-field-formatter.html.twig` and
  `templates/author-field-name-formatter.html.twig` — output the name as an `<a>` to
  `https://orcid.org/{{ orcid_id }}` with `target`/`rel` from the whitelisted settings.
- All field values (`author_name`, `email`, `orcid_id`, `organization_name`) are emitted with Twig
  `{{ }}` auto-escaping — no `|raw`, so they are HTML/attribute-escaped on output.

## Enable & attach

1. `composer require drupal/author_field` (pulls `drupal/jquery_ui_tooltip`), `drush en author_field`.
2. On a content type's *Manage fields*, add a field of type **Author Field**.
3. *Manage form display* → pick **Author Field Widget** (optionally hide sub-fields in its settings).
4. *Manage display* → pick **Default**, **Author field**, or **Author Name field** formatter.
