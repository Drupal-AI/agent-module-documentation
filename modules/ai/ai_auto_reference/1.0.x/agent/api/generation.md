<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The generator service, Batch, and the "Generate references with AI" flow

## Service `ai_auto_reference.ai_references_generator`

Class `Drupal\ai_auto_reference\AiReferenceGenerator` (`src/AiReferenceGenerator.php`). Constructed
with entity type manager, renderer, config factory, current user, logger factory, theme
initialization/manager, and AI core's `ai.provider`, `ai.tokenizer`, `ai.text_chunker`. All AI calls
go through the **drupal/ai provider abstraction** — there is no direct HTTP client and no TLS handling
in this module.

### Key methods

- `getBundleAiReferencesConfiguration($bundle)` — loads `node.{bundle}.default` form display, returns
  the `ai_auto_reference` third-party settings as a list of `{field_name, view_mode, prompt}`,
  skipping any row missing a `view_mode` or `prompt`.
- `getFieldAllowedValues(NodeInterface $node, $field_name)` — the candidate target list. Calls the
  field storage's options provider:
  `getOptionsProvider('target_id', $node)->getSettableOptions($this->currentUser)`. **This is
  access-aware** — candidates are only the entities the current user is allowed to reference. It then
  removes values already on the node, flattens bundle-grouped option arrays, and drops the current
  node's own id (no self-reference). Returns `id => label`.
- `getAiSuggestions(NodeInterface $node, $field_name, $view_mode, $prompt_id, $override_content = '')` —
  the core routine. Steps:
  1. `possible_results` = imploded (`|`) allowed-value labels; `contents` = `$override_content` or
     `getNodeContent()` (rendered view mode → Markdown via `League\HTMLToMarkdown`), whitespace
     collapsed.
  2. Loads the `AiPrompt` by id (`AiPrompt::load`); if missing, uses a hard-coded fallback prompt.
  3. Token budgeting with `ai.tokenizer`: if prompt + possible_results alone exceed `token_limit`, it
     logs an error and gives up; if prompt + results + contents exceed it, it makes an extra AI call to
     **summarise** the contents (cropping first with `ai.text_chunker->chunkText()` if even the summary
     prompt is too big).
  4. Replaces `{possible_results}` / `{contents}` in the prompt, calls `aiApiCall()`, JSON-decodes the
     answer, and intersects the returned `highly` / `moderately` label arrays back against the allowed
     values to recover ids. Returns `['h' => [ids...], 'm' => [ids...]]`. On any exception it logs and
     returns `[]`.
- `aiApiCall(ImmutableConfig $config, string $prompt_text)` — builds a `ChatInput`/`ChatMessage`,
  resolves provider+model from the `provider` simple option, calls `->chat(...)->getNormalized()
  ->getText()`, strips ```` ```json ```` fences, trims. Model falls back to `gpt-3.5` when none set
  (`getChatModelId()`).

Because suggestions are derived by intersecting the model's answer with the **access-filtered**
allowed-value labels, an id the current user cannot reference cannot end up in the result even if the
model invents it.

## The "Generate references with AI" button (batch route)

Wired in `ai_auto_reference.module`:

- `hook_form_node_form_alter` — on an **existing**, default-translation node, when the user has
  `access ai auto-reference suggestion tools` and the bundle has auto-reference config and a
  `provider` is set (and the bundle's `hide_generate_button` is off), adds a submit button
  `#name = ai_auto_reference` ("Generate references with AI") with submit handler
  `ai_auto_reference_node_form_submit`. (Disabled on the *create* form, since its page refresh would
  discard unsaved input.)
- `ai_auto_reference_node_form_submit` — strips any `destination` query (so we return to the edit form
  when reviewing) and calls `batch_set()` with `AiReferenceBatch::getbatchSteps($node)`.

### Batch — `AiReferenceBatch` (`src/Batch/AiReferenceBatch.php`)

- `getbatchSteps($node)` — one `batchOperation` per configured field.
- `batchOperation($node, $ai_autoreference, &$context)` — calls
  `generator->getAiSuggestions(...)`, stores comma-joined ids per relevance in
  `$context['results']['query'][$field_name]` as `{h: "id,id", m: "id,id"}`.
- `batchFinished($success, $results, $operations)` — if `auto_apply_suggestions` is on, loads the
  active node revision and appends ids whose level (`h`→high / `m`→medium) is in
  `auto_apply_relevance_levels`, then saves. Always redirects to `entity.node.edit_form` with the
  suggestions passed as **query parameters** (and `auto-apply` flag).

## The apply / review form — `AutoReferenceApplyForm`

Not a routed form; `hook_form_node_form_alter` renders it via `form_builder->getForm()` and injects it
as a status **message** at the top of the returned edit form (deleting prior status messages to avoid
duplicates). `buildForm(array $form, $form_state, ?NodeInterface $node, ?array $configuration)` reads
the suggestion ids from the **request query** (set by `batchFinished`) and builds, per field:

- **cardinality 1** → a single `radios` group merging high+medium suggestions plus a "- None -"
  option, defaulting to the first high id.
- **multi-value** → separate `checkboxes` groups for High and Medium relevance (High checked by
  default).

When `auto-apply` was on, inputs are `#disabled` and titled "…have been applied". `submitForm()`
re-checks `access ai auto-reference suggestion tools`, appends the chosen `target_id`s to the node,
saves if changed, and redirects to the edit form. A "Reject all suggestions" link just returns to the
edit form without saving. Suggestion labels come from `$storage->loadMultiple($ids)` where the ids
originate from the access-filtered allowed-value set, and are placed as Form-API option labels (escaped
by core).
