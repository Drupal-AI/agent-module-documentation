<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Merge wizard (routes, forms, tempstore)

There is **no settings form and no configure route** — the module's whole UI is a three-step
wizard hung off each vocabulary. A "Merge" local task is added next to *List terms*
(`term_merge.links.task.yml`, base route `entity.taxonomy_vocabulary.overview_form`).

## Routes (`term_merge.routing.yml`)

| Route name | Path | Form |
|---|---|---|
| `entity.taxonomy_vocabulary.merge_form` | `/admin/structure/taxonomy/manage/{taxonomy_vocabulary}/merge` | `MergeTerms` (`taxonomy_merge_terms`) |
| `entity.taxonomy_vocabulary.merge_target` | `…/merge/target` | `MergeTermsTarget` (`taxonomy_merge_terms_target`) |
| `entity.taxonomy_vocabulary.merge_confirm` | `…/merge/confirm` | `MergeTermsConfirm` (`taxonomy_merge_terms_confirm`) |

All three carry `_permission: 'merge taxonomy terms'` **and**
`_term_merge_access_check: 'TRUE'`, plus `_admin_route: TRUE`.
See [../permissions/merge-access.md](../permissions/merge-access.md).

## Step 1 — select terms (`MergeTerms`)

Checkboxes listing every term in the vocabulary (`loadByProperties(['vid' => …])`, sorted by
label), required. With the optional **Synonyms** module installed an extra
"Add source term as synonym" checkbox appears. Submit stores the checked tids in the private
tempstore and redirects to step 2.

## Step 2 — choose the target (`MergeTermsTarget`)

Two mutually exclusive inputs: **New term** (textfield) or **Existing term** (select, built
from the vocabulary minus the already-selected tids). Validation rejects filling both or
neither ("You must either select an existing term or enter a new term."). Submit stores either
the new label (a **string**) or the loaded `Term` object under `target`.

## Step 3 — confirm (`MergeTermsConfirm`)

Lists the terms that will disappear and calls the merger service — `mergeIntoNewTerm()` when
`target` is a string, `mergeIntoTerm()` when it is a `TermInterface`. It stashes the resulting
tid in `$form_state->set('destination_tid', …)` (readable from `hook_form_alter()`), optionally
copies source labels + synonyms onto the target when Synonyms is enabled, shows
"Successfully merged %count terms into %target" and redirects back to step 1.

## Tempstore keys

Collection `term_merge` (`tempstore.private`), per user:

| Key | Set by | Value |
|---|---|---|
| `terms` | step 1 | array of selected tids |
| `terms_to_synonym` | step 1 (Synonyms only) | bool |
| `target` | step 2 | `string` (new term label) **or** a `Term` entity |

An empty `terms` on step 3 produces the error "You must submit at least one term."; a `target`
that is neither a string nor a `TermInterface` throws `\LogicException`.

## Manual walkthrough

1. *Structure → Taxonomy → &lt;vocabulary&gt; → List terms → **Merge***.
2. Tick two or more terms → **Merge**.
3. Type a new term name **or** pick an existing one → **Submit**.
4. Review the list → **Confirm merge**.

## Doing it without the UI

The wizard is only a front end for the service — for scripts, cron jobs or update hooks call
`term_merge.term_merger` directly, see
[../api/term-merger-service.md](../api/term-merger-service.md).
