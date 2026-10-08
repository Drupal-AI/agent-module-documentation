# Rules, events & the re-merge mechanism

Term Merge Manager has **no service you configure** — it works through one event subscriber,
two entity types, and two taxonomy hooks. This is the whole moving picture.

## The two content entities (the "rules")

| Entity type id | Purpose | Key fields |
|---|---|---|
| `term_merge_into` | the surviving **target** term | `tid` (target term id), `vid` (vocabulary), `status` |
| `term_merge_from` | one **source** name that folds into a target | `name` (source term name), `vid`, `tmiid` (id of the `term_merge_into` row), `status` |

Both are `ContentEntityType`s with base tables `term_merge_into` / `term_merge_from`, list
builders at `/admin/structure/term_merge_into` and `/admin/structure/term_merge_from`, and
add/edit/delete forms. Only **published** (`status = 1`) rows are matched. There is no config
schema — these are content, not config.

Static loaders you can call:

```php
use Drupal\term_merge_manager\Entity\TermMergeFrom;
use Drupal\term_merge_manager\Entity\TermMergeInto;

// Returns the TermMergeFrom rule, or FALSE.
$rule = TermMergeFrom::loadByVidName($vid, $name);

// Returns the term_merge_into ENTITY ID for a target term id, or FALSE.
$intoId = TermMergeInto::loadIdByTid($tid);

// From a TermMergeFrom rule, resolve the target term:
$targetTid  = $rule->getIntoId();    // target taxonomy term id
$targetName = $rule->getIntoName();  // target term name
```

## 1. Recording a merge — the event subscriber

`DefaultSubscriber` (`term_merge_manager.default`) subscribes to
**`term_merge.terms_merged`** (a `Drupal\term_merge\TermsMergedEvent`). On each merge it:

1. Loads or creates a `term_merge_into` for the target term (`TermMergeInto::loadIdByTid`).
2. For every source term, loads-or-creates a `term_merge_from` (`vid` + `name` → `tmiid`).
3. If `redirect` is enabled **and** `redirect.settings.auto_redirect` is TRUE, creates a 301
   `Redirect` from the source term's URL alias to `/taxonomy/term/<target tid>` (deleting any
   pre-existing redirect with the target alias as source first).

So the rules are populated as a side effect of actually running Term Merge — you do not
normally create them by hand (though you can, via the entity API or the admin forms).

## 2. Re-applying a rule — `hook_ENTITY_TYPE_presave`

`term_merge_manager_taxonomy_term_presave()`
(→ `TermMergeManagerHooks::taxonomyTermPresave`) runs on **every** taxonomy term save:

- Looks up `TermMergeFrom::loadByVidName($term->bundle(), $term->getName())`.
- No rule → returns, the term saves normally.
- Rule found → **rewrites the term in place to BE the target term**: sets `originalId` and
  `tid` to the target id, copies the target's `name`, `description` and all `field_*` values,
  and sets `$entity->original` to the target term. Net effect: creating a new term whose
  (vocabulary, name) matches a "from" rule does **not** create a new term — the existing
  target term is what you end up with (its `tid` is reused).
- If the new name already equals the target name it deletes the now-redundant `from` rule.
- If `pathauto` is enabled it sets `PathautoState::SKIP` on the rewritten term to avoid
  appending duplicate URL aliases to the target on every merge.

## 3. Cleaning up — `hook_taxonomy_term_delete`

`term_merge_manager_taxonomy_term_delete()` → `TermMergeManagerHooks::taxonomyTermDelete`:
when a term is deleted, if it is a merge target (`TermMergeInto::loadIdByTid`), the matching
`term_merge_into` row **and** all `term_merge_from` rows pointing at it (`loadByMergeId`) are
deleted, so no stale rules survive.

## Creating a rule programmatically

```php
$into = TermMergeInto::create(['tid' => $targetTerm->id(), 'vid' => $targetTerm->bundle()]);
$into->save();
$from = TermMergeFrom::create();
$from->set('tmiid', $into->id());
$from->set('vid', $sourceVid);   // usually same vocabulary
$from->set('name', 'OldName');   // the source term name to fold in
$from->save();
// Now saving a new term named 'OldName' in $sourceVid becomes the target term.
```
