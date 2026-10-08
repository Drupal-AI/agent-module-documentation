<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, hooks, events, token, Drush & config action

Declared in `ai_schemadotorg_jsonld.services.yml` (all `autowire: true`).

## Services

- `ai_schemadotorg_jsonld.builder` → `AiSchemaDotOrgJsonLdBuilder`
  (alias `AiSchemaDotOrgJsonLdBuilderInterface`). Creates the field storage/instance, the per-bundle
  `ai_automator`, and the form/view display components. See
  [../config/settings.md](../config/settings.md). Interface constant `FIELD_NAME =
  'field_schemadotorg_jsonld'`.
- `ai_schemadotorg_jsonld.manager` → `AiSchemaDotOrgJsonLdManager`
  (alias `AiSchemaDotOrgJsonLdManagerInterface`). Resolves supported entity types, seeds/syncs the
  `entity_types` config, and builds default prompts from `prompts/entity_types/*.prompt.txt`.
- `ai_schemadotorg_jsonld.token_resolver` → `AiSchemaDotOrgJsonLdTokenResolver`
  (alias `AiSchemaDotOrgJsonLdTokenResolverInterface`). `resolve(ContentEntityInterface): FormattableMarkup`
  renders the entity in the **default view mode as the anonymous user in the site default theme**
  (switches account + theme inside a try/finally so both restore), then post-processes: strips
  single-child outer `<div>` wrappers, absolutizes root-relative `href`/`src` to `$base_url`, and
  returns the result **`Xss::filter()`-ed**. This backs the content token used in prompts.
- `EventSubscriber\AiSchemaDotOrgJsonLdEventSubscriber` (tagged `event_subscriber`) — see Events.

## Hooks (`src/Hook/`, PHP attribute `#[Hook(...)]`)

`AiSchemaDotOrgJsonLdPageHooks` — `page_attachments` (head JSON-LD, in
[../config/settings.md](../config/settings.md)).

`AiSchemaDotOrgJsonLdFieldHooks`:

- `field_widget_action_info_alter` — registers the `json_editor` widget type on the `automator_json`
  action when `json_field_widget` is on.
- `entity_field_access` — for `field_schemadotorg_jsonld`, `view` is **forbidden** unless the account
  has `update` access to the entity (so only editors see the field rendered on the entity view page).
- `field_widget_complete_json_textarea_form_alter` / `..._json_editor_form_alter` — on saved entities,
  adds a *Copy JSON-LD* button (library `ai_schemadotorg_jsonld/copy`), a validator-links description,
  and an *Edit prompt* modal link (only when `development.edit_prompt` is on **and** the user has
  `administer site configuration`); on new entities, shows an inline "save first" message.

`AiSchemaDotOrgJsonLdTokenHooks`:

- `token_info` — declares `ai_schemadotorg_jsonld:content` under each enabled entity type's token type.
- `tokens` — replaces `[<type>:ai_schemadotorg_jsonld:content]` with `token_resolver->resolve($entity)`.

## Events (`EventSubscriber\AiSchemaDotOrgJsonLdEventSubscriber`)

Subscribes to `drupal/ai` events, scoped to this module's automator via
`AiSchemaDotOrgJsonLdAutomatorTrait::hasTags()` (tag `ai_automator` **and**
`ai_automator:field_name:field_schemadotorg_jsonld`).

- `PreGenerateResponseEvent` → `onPreGenerateResponse()`: for each `user` `ChatMessage`, runs
  `cleanupPromptText()` — substitutes the `[ai_schemadotorg_jsonld:requirements]` placeholder with the
  configured `requirements`, `html_entity_decode`s the text (so token-embedded rendered HTML is raw,
  not double-escaped), and normalizes line endings/blank runs.
- `ValuesChangeEvent` → `onValuesChange()`: only for `field_schemadotorg_jsonld`. Runs `extractJson()`
  on each value — trims, finds the outermost `{ … }`, repairs common bad quote escapes, and validates
  with `json_decode(..., JSON_THROW_ON_ERROR)`; on failure it logs a warning + adds a messenger warning
  and keeps the original value. This is what turns a chatty LLM reply into a stored JSON object.

## Token resolver notes

`resolve()` uses `renderer->renderInIsolation()` under an `AnonymousUserSession` so the prompt sees
only anonymous-visible content. It renders a local entity (no request-supplied URL is fetched), and
the output is `Xss::filter()`-ed before it becomes markup.

## Drush (`Drush/Commands/AiSchemaDotOrgJsonLdCommands`)

`ai_schemadotorg_jsonld:add-field <entity_type> [<bundle>]` → `builder->addFieldToBundles()`. Omit the
bundle (or pass `*`) to target all current bundles / a non-bundle entity type. Wraps errors as
`RuntimeException`.

## Config action (`Plugin/ConfigAction/AddField`)

`#[ConfigAction(id: 'addField', entity_types: ['ai_schemadotorg_jsonld.settings'])]`. `apply()` requires
`{entity_type: string, bundles: non-empty array}` and calls `builder->addFieldToBundles()`. Use it from
a Drupal recipe to declaratively add the JSON-LD field, e.g.:

```yaml
config:
  actions:
    ai_schemadotorg_jsonld.settings:
      addField:
        entity_type: node
        bundles: [article, page]
```

## Traits (`src/Traits/`)

`AiSchemaDotOrgJsonLdCurrentEntityTrait` (matches `entity.<type>.canonical` and returns the route's
content entity), `AiSchemaDotOrgJsonLdAutomatorTrait` (tag check above),
`AiSchemaDotOrgJsonLdMessageTrait` (builds a `status_messages` render array for inline notices).
