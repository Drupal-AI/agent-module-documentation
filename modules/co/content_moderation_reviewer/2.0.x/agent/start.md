<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Moderation Reviewer (content_moderation_reviewer) — agent index

info.yml name **"Content Moderation Reviewer"**, version **2.0.0-alpha5** (version-dir `2.0.x`).
Core `^10 || ^11`. License GPL-2.0-or-later. Depends on core **`workflows`** + **`content_moderation`**.
Not covered by Drupal's security advisory policy (alpha).

Lets an editor record **which user should review a given piece of moderated content**. It adds a
`content_moderation_reviewer` entity-reference (→ `user`) field to every content-moderation-enabled
entity type, with an AJAX autocomplete widget that offers only users whose role can execute a
transition out of the moderation state being set. The reviewer is stored metadata (revisionable);
the module does **not** itself gate who may perform a transition — core `content_moderation`
permissions still govern that.

- **Field, widget, autocomplete route, constraint and the AccessChecker service** →
  [fields/reviewer-field.md](fields/reviewer-field.md)

## What it actually is (from source)

- **Two field hooks** in `content_moderation_reviewer.module`:
  - `hook_entity_base_field_info()` — for any entity type where
    `content_moderation.moderation_information->isModeratedEntityType()` is TRUE, defines the
    revisionable `entity_reference`→`user` base field named `content_moderation_reviewer`
    (`CmrConstants::FIELD_NAME`).
  - `hook_entity_bundle_field_info()` — for bundles that have a `moderation_state` field, redefines
    the field with the `ReviewerAutocompleteWidget` form display (weight 120), a hidden view display,
    the `ModerationStateReviewer` constraint, and `target_type => user`.
- **No `.permissions.yml`, no `config/`, no `.install`, no theme templates.** One service, one route,
  one controller, one widget, one constraint (+validator), two constant/helper classes.
- **Service** `content_moderation_reviewer.access_checker` = `src/AccessChecker.php` (arg:
  `@entity_type.manager`). Pure logic for "which roles/users may act on a state" — see subdoc.
- **Route** `content_moderation_reviewer.autocomplete`:
  `/content_moderation_reviewer/{workflow_id}/{to_state}` → invokable
  `Controller/ReviewerAutocompleteController`, permission `access content`. Returns JSON
  `[{value: "name (uid)", label: name}]` of up to 10 users matching `?q=` whose role can transition
  out of `to_state`.
- **Widget** `content_moderation_reviewer_autocomplete` (`ReviewerAutocompleteWidget`) — renders the
  reviewer autocomplete directly under the core Moderation state select and rewires the state select
  with an `#ajax` callback so the reviewer list refreshes when the target state changes. If the target
  state is a **published** state the widget renders nothing (no reviewer assignable once published).
- **Constraint** `ModerationStateReviewer` (`ModerationStateReviewerConstraintValidator`) — on save of
  an existing moderated entity with a non-empty reviewer, adds a violation unless the referenced user
  is a valid reviewer for the new state.

## Views

The reviewer field is an ordinary entity-reference base field, so Views exposes a relationship to it
automatically (e.g. "content the current user is assigned to review"). No custom Views plugin ships.

## Test/example code

`tests/modules/cmr_test/` is an example install profile fragment (a `test_workflow`, drafter/editorial/
legal reviewer roles, a `page` type). Kernel + FunctionalJavascript tests under `tests/`. Not shipped/enabled in production.
