<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The review block, review form, storage & author display

## Placing the block

`CritiqueAndReviewBlock` (`src/Plugin/Block/CritiqueAndReviewBlock.php`), `@Block` id
**`critique_and_review_block`**, admin label *"Critique And Review Block"*, category *"Custom Critique
And Review Block"*. Place it via Block layout (Structure → Block layout) on node pages. Restrict who
reviews using the block's own **visibility** settings (role, pages `/node/*`, content type) — that is
the module's intended access mechanism; there is no per-user review permission. `hook_help` documents
this placement/restriction flow.

## What the block renders (`build()`)

Reads config `critique_and_review.settings` and the current user id, and the current `node` route
parameter. Three outcomes:

1. **Author of the node** (`$current_user_id === $node->getOwnerId()`): no form. Gets the latest
   revision id via `entityTypeManager->getStorage('node')->getLatestRevisionId()`, then
   `critique_and_review_get_reviews($nid, $vid)`. If finished reviews exist → message *"You have
   reviews…"* plus an **Edit** link to `entity.node.edit_form`; else *"You do not have any reviews
   yet."*
2. **Authenticated, not the author**: renders the embedded reviewer form
   `Drupal\critique_and_review\Form\TemplateCritiqueAndReviewForm` via `formBuilder()->getForm()`.
   Attaches library `critique_and_review/critiqueFormScript` only when `add_css` is on.
3. **Anonymous**: the `!isAnonymous() && !author` branch is false and no author branch runs → the block
   builds only the empty `#markup` placeholder (no form).

All build outputs set `#cache` `contexts: ['user']`, `max-age: 0` (per-user, uncacheable).

## The reviewer form (`TemplateCritiqueAndReviewForm`, id `review_template_review_form`)

- `buildForm` sets `userIsAdmin` when the current user has the `administrator` role, reads uid and the
  node's `nid`/`vid` from the route node, and loads config.
- Shows `intro_text` as `#markup`, then one `details` per Review Item. Existing reviews (from
  `get()`) pre-fill each item's `text_format` (`#format => basic_html`); otherwise it loops the
  config `review_items_titles` to render empty items via `printFormItem()`.
- If a review is already **finished** (`rev_finished == 1`) and the user is not admin, each item's
  editor is `#disabled`; admins can still edit finalised reviews.
- When `add_more_reviews` is on and the review is not finished, an *"Add more"* details block lets the
  reviewer add one ad hoc item per submit (title + basic_html body).
- A *Finalise review* checkbox (`nicey_template_finalise_review`) plus a *Save Draft* submit appear
  when there is a node and the review is not finished (or the user is admin). `js/critique_and_review.js`
  flips the button label to *"Finalise Review"* when the checkbox is ticked.
- `validateForm`: when an add-more title is present, errors if it duplicates an existing item title.

## Storage: table `critique_and_review_reviews`

Defined in `critique_and_review.install` `hook_schema`. Columns: `id` (serial PK), `uid`, `nid`,
`vid`, `rev_item_id`, `rev_finished`, `review_title` (varchar 120), `review` (varchar 5000),
`rev_wordcount`, `created`. Indexes on `nid` and `(nid, uid)`. `hook_update_1`/`_2` add
`rev_item_id`, `rev_finished`, `rev_wordcount` on existing installs. It is a plain table, **not** an
entity — no entity access, no fields UI, no views integration out of the box.

Persistence methods (private, in the form):

- `set($title, $body, $rev_id, $rev_finished)`: `get()`s the current user's row for that item; if it
  exists it `UPDATE`s (`review`, `rev_finished`) matched on uid+nid+vid+review_title, else `INSERT`s a
  new row. **Every write conditions on `$this->uid`** (the current user), so a reviewer only ever
  writes their own rows for the node/revision they are viewing.
- `get($rev_id = NULL)`, `getNextIndexValue()`, `delete($rev_id)`: all likewise scoped to
  uid+nid+vid; `delete` also matches `rev_item_id`. Queries use the DB API `->condition()` — no raw
  SQL.
- `setInitialBody()` matches a stored row to a template item by `review_title`.

`submitForm` walks cleaned values: `nicey_template_delete_item*` checked → `delete()`;
`nicey_template_text*` → `set()` with the aligned `item_title*`; a filled add-more title →
`set()` at the next index. The `nicey_template_finalise_review` flag is written as `rev_finished`.

## Author-side display (`hook_form_alter` in `*.module`)

On any `node_*_edit_form`, `critique_and_review_form_alter` loads the node's current `vid`,
calls `critique_and_review_get_reviewer($nid, $vid)` (reviewers who wrote rows), and for each builds a
`vertical_tabs`/`details` structure. For each reviewer it fetches finished reviews
(`critique_and_review_get_user_reviews`, which filters `rev_finished = 1`) and renders each as a
`details` with `#title => review_title` and `#markup => review`. Only **finished** reviews reach the
author here; drafts stay with the reviewer. Reviewer display name comes from `User::load($uid)`.

## Operating notes

- The word-count field and `rev_wordcount` writes are commented out in the current form; the column
  exists but is not populated by the shipped form.
- Reviews are tied to a specific node **revision** (`vid`). Saving a new node revision produces a fresh
  review context; older reviews remain attached to their original revision id.
- Deleting a node does not prune its review rows; uninstalling the module drops the whole table.
