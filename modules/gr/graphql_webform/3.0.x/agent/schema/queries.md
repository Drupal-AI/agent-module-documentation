<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Query side: reading a webform and its elements

All types below live in the `graphql` module's SDL schema (server id you configure) via
`graphql_webform`'s `WebformExtension` schema extension. Field resolvers are wired to data
producers; the base SDL is in `graphql/webform.base.graphqls` + `graphql/webform.extension.graphqls`,
and one GraphQL type per Webform element plugin is **generated at runtime** by `WebformSchemaBuilder`
from the Webform element manager (so custom element plugins get a type automatically).

## `webformById` → `Webform`

```graphql
query ($id: String!) {
  webformById(id: $id) {
    id
    label
    settings { ajax confirmationType confirmationMessage confirmationUrl draft ... }
    form {
      title
      elements { ... }
      unavailable { message type reason }
    }
  }
}
```

Arguments: `id` (required), `sourceEntityType` / `sourceEntityId` (build for a source entity),
`prepopulate` (a URL-encoded query string, parsed with PHP `parse_str`; honored per the webform's
`form_prepopulate` setting; the reserved `source_entity_type`/`source_entity_id` keys are stripped —
pass those through the dedicated args).

**Access:** the `webform_load` producer calls `$webform->access('view')` and returns `null` when
denied, so a webform the current user cannot view is invisible. Per the module README, granting
`access webform configuration` (per-webform, or `access any webform configuration` globally) is the
normal way to let a decoupled client read a form's definition.

`Webform` fields: `id`, `label`, `settings` (a `WebformSettings` object of the webform's config
settings — array-valued settings like `formAttributes` come back serialized as strings), and
`form`.

## `WebformForm` — the built form instance

`form` builds the submission form once (Webform's `api` mode) and exposes:

- **`elements: [WebformElement]`** — the built element tree. Empty when the form is unavailable.
  Each entry resolves to a concrete type named `WebformElement<PluginIdUpperCamel>`
  (`WebformElementTextfield`, `WebformElementEmail`, `WebformElementSelect`,
  `WebformElementManagedFile`, `WebformElementWebformCustomComposite`, ...). An element whose plugin
  is not exposed resolves to `WebformElementUnexposed`. Query with inline fragments:

  ```graphql
  elements {
    ... on WebformElement { metadata { key type title required requiredError } }
    ... on WebformElementTextBase { defaultValue size maxlength placeholder pattern { rule message } }
    ... on WebformElementOptionsBase { options { value title } }
    ... on WebformElementManagedFile { fileExtensions maxFilesize }
    ... on WebformElementWebformCustomComposite { elements { metadata { key type } } }
  }
  ```

  Shared interfaces carry the common fields: `WebformElementMetadata` (`key`, `type`, `title`,
  `required`, `requiredError`, `help`, `disabled`, `defaultValue`, `states`, ...),
  `WebformElementTextBase`, `WebformElementOptionsBase`, `WebformElementMultipleValuesBase`
  (`multipleValues { limit message }` — `limit: -1` means unlimited, `0` means unlimited config
  depending on element), `WebformElementDateBase`, `WebformElementContainerBase`, and many more.
  Conditional logic is exposed through `WebformElementMetadata.states` →
  `WebformElementStates` → `WebformElementState { conditions logic }`.

- **`unavailable: WebformFormUnavailable`** — `null` when the form is fillable; otherwise
  `{ message, type, reason }`. `message` is the human text Webform would show; `type` is
  `STATUS`/`INFO`/`WARNING`/`ERROR`; `reason` is one of `CLOSED`, `OPENING`,
  `SOURCE_ENTITY_REQUIRED`, `SOURCE_ENTITY_TYPE_MISMATCH`, or `OTHER`. The `#custom_form` marker
  Webform sets when it refuses to render the form is the single source of truth.

- **`title`, `sourceEntityType`, `sourceEntityId`, `sourceEntityLabel`** — the title takes the
  source entity into account; source-entity load is `view`-access-checked.

## `webformConfirmation`

```graphql
query { webformConfirmation(submissionId: 42, token: "…") { type title message redirectUrl } }
```

Resolves via `webform_load_submission` (loads the submission by id, then **throws
`Invalid webform submission token.` unless the passed `token` matches the submission's secret
token**) chained into `webform_submission_confirmation`. Pass `webformId` instead of
`submissionId`/`token` to get a webform's confirmation when no submission is stored.

## `webformEntityAutocomplete`

```graphql
query { webformEntityAutocomplete(webformId: "contact", elementKey: "ref", input: "jo") { id label } }
```

Resolves matches for an `entity_autocomplete` element using the element's own configured reference
target and selection handler (which applies the entity's access rules); the caller only supplies
the typed string. `WebformElementEntityAutocomplete.defaultEntities` resolves configured defaults
into the same `{id, label}` shape, skipping entities the current user cannot view.
