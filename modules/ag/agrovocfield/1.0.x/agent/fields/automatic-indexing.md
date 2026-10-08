<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AGROVOC automatic indexing — enabling, flow and config

## Install & enable

```bash
composer require drupal/agrovocfield
drush en agrovocfield -y
```

Depends on core `taxonomy` and `field`. You also need a reachable **AgroTagger** service (deployed
separately) and a **taxonomy reference field** using one of the two supported widgets.

## Point it at the AgroTagger service

Form `Drupal\agrovocfield\Form\SettingsForm` (`ConfigFormBase`), route `agrovocfield.settings` →
`/admin/config/content/agrovocfield`, permission **`administer site configuration`**. Writes config
object **`agrovocfield.settings`**:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `service_url` | string (`#type => url`, required) | `http://agrotagger:8080` | Base URL of the AgroTagger service. |
| `timeout` | integer (1–120, required) | `15` | Per-request HTTP timeout in seconds; blocks node save until the service responds or times out. |

## Enable indexing on a field

`_agrovocfield_applies()` gates everything: the widget must be one of
`entity_reference_autocomplete_tags` / `tagify_entity_reference_autocomplete_widget`, **and** the
field's `target_type` must be `taxonomy_term`. When it applies,
`agrovocfield_field_widget_third_party_settings_form()` adds these to the widget config (Manage form
display → the field's gear), stored under third-party settings key `agrovocfield` (schema
`field.widget.third_party.agrovocfield`):

- `enabled` (checkbox) — turn automatic indexing on.
- `source_field` (select) — which text-bearing field on the bundle to read
  (`_agrovocfield_text_field_options()` lists `text`, `text_long`, `text_with_summary`, `string`,
  `string_long` fields).
- `max_tags` (number 1–50, default 10).

`agrovocfield_field_widget_complete_form_alter()` then attaches, to the inner `widget` element (not
the outer wrapper — its `#parents`/`#field_parents` must match where values are read), an
`#agrovocfield` metadata array and the `_agrovocfield_validate` `#element_validate` callback.

## Save-time flow (`_agrovocfield_validate`)

Runs only during interactive form submission (an `#element_validate` callback — never on
programmatic saves, migrations or imports). Steps:

1. **Skip if already filled.** Reads the just-submitted field value; "empty" differs per widget —
   core: `empty($current['target_id'])`; Tagify: `empty($current) || $current === '[]'`. If not
   empty, returns (no clobbering editor/existing tags).
2. **Read source text.** The form object must be an `EntityFormInterface` and the entity must have
   `source_field`. Reads `form_state->getValue([...#field_parents, source_field, 0, 'value'])`,
   `strip_tags` + `trim`. Empty → return.
3. **Call the service.** `\Drupal::service('agrovocfield.tagger_client')->tag($text)`; slice to
   `max_tags`.
4. **Resolve/create terms.** Target vocabulary is the field's single `target_bundles` entry
   (`_agrovocfield_target_bundle()` returns NULL — and aborts — if the field allows multiple
   vocabularies). For each returned `{label, uri}`: `loadByProperties(['name'=>label,'vid'=>vid])`
   reuses an existing term, otherwise `create()`s one; a new term gets `field_agrovoc_uri` set to
   `_agrovocfield_normalize_uri($uri)` when that link field exists on the vocabulary.
5. **Inject into the widget value** in that widget's raw shape:
   core → `['target_id' => [['target_id'=>tid], ...]]`; Tagify → JSON string of
   `[{'entity_id'=>tid}, ...]`.

## The HTTP client (`AgroTaggerClient::tag`)

`src/AgroTaggerClient.php`, service `agrovocfield.tagger_client` (`@http_client`, `@config.factory`,
`@logger.channel.agrovocfield`). `tag(string $text)`:

- `POST <service_url>/tag` with Guzzle, body `['json' => ['text' => $text]]`, `timeout` from config.
- Expects `{"tags": [{uri, label, score}, ...]}`; returns `$data['tags']`.
- Any `GuzzleException`, or a response body that isn't the expected shape, is **logged** and returns
  `[]` — tagging is a best-effort suggestion, so a service outage degrades to "no suggestions"
  rather than blocking the save.

Uses Drupal's shared `http_client` with default options (standard TLS verification). The service URL
is set by an administrator, not by request input.

## URI normalisation (`_agrovocfield_normalize_uri`)

Rewrites the exact legacy pattern `http://aims.fao.org/aos/agrovoc/c_<n>` to
`https://aims.fao.org/aos/agrovoc/c_<n>.html` (avoids a multi-hop redirect chain). Anything not
matching that pattern is passed through unchanged.

## Backfilling legacy terms

Terms created before `field_agrovoc_uri` existed, or matched by name, won't have a URI. The service
exposes `GET /lookup?label=` for direct label→URI lookup; there is **no UI** for backfill — it is a
one-off `drush php:script` you write to iterate terms with `field_agrovoc_uri`, call `/lookup`, and
save the normalised URI. Not run automatically.
