<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lookup form, route & permissions

## Install / enable
`composer require drupal/entity_uuid_lookup && drush en entity_uuid_lookup`. No dependencies, no config to set.
Grant the two permissions below to the roles that should use it.

## Permission
`entity_uuid_lookup.permissions.yml` declares one permission:
- `lookup entities by uuid` — "Lookup entities by UUID".

## Route
`entity_uuid_lookup.routing.yml`:
- `entity_uuid_lookup.admin` — path `/admin/content/by-uuid`, `_form: \Drupal\entity_uuid_lookup\Form\EntityUuidLookupForm`, title "UUID lookup".
- `requirements._permission: 'lookup entities by uuid,view the administration theme'` — the comma means the user
  must hold **both** permissions.
- Menu link `entity_uuid_lookup.admin` (`entity_uuid_lookup.links.menu.yml`) places it under
  `system.admin_content`.

## Form: `src/Form/EntityUuidLookupForm.php`
`EntityUuidLookupForm extends FormBase` (form id `entity_uuid_lookup_admin`). It injects `entity_type.manager`
and `entity.repository` via `create()`.

- `buildForm()` — a required `uuid` textfield plus two submit buttons: **View** and **Edit**.
- `validateForm()` does the work (the redirect is set during validation; `submitForm()` is empty):
  1. Reads the submitted `uuid` and the triggering element (View vs Edit).
  2. Iterates every entity type from `EntityTypeManager::getDefinitions()`, skipping any type without a `uuid`
     key (`$entityType->getKey('uuid')`).
  3. Calls `entityRepository->loadEntityByUuid($entityTypeId, $uuid)` — a parameterized entity load, not a raw
     query. Skips types where nothing loads.
  4. If the button was **Edit** and the entity has an `edit-form` link template, it builds that URL and uses it
     **only when `$editUrl->access()` passes**.
  5. Otherwise it falls back to the `canonical` link template.
  6. If no URL was resolved, or `$url->access()` fails, it `break`s out of the loop.
  7. On success it calls `$form_state->setRedirectUrl($url)` and returns.
- If nothing matched (or the matched entity's URL was not accessible), it sets a generic form error:
  "No entity found with the given UUID."

## Operating notes
- The redirect target always respects the current user's entity access (`$url->access()` is checked before
  redirecting), so the form never sends a user to a page they cannot view/edit.
- It resolves any entity type exposing a `uuid` key that has a `canonical` (and optionally `edit-form`) link
  template — nodes, users, taxonomy terms, media, etc.
- There is no configuration form and no stored config; behavior is entirely code-driven.
