<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access enforcement (widget alter hook)

Enforcement lives entirely in `autocreate_access_field_widget_single_element_form_alter()`
(`autocreate_access.module`), an implementation of `hook_field_widget_single_element_form_alter`.

## Trigger conditions
The hook acts only when ALL hold:
- `$context['widget'] instanceof EntityReferenceAutocompleteWidget`
  (`Drupal\Core\Field\Plugin\Field\FieldWidget\EntityReferenceAutocompleteWidget`), and
- `$element['target_id']['#autocreate']` is non-empty (core decided autocreate is offered for this element), and
- the field definition is a `FieldConfigInterface` whose `getThirdPartySetting('autocreate_access', 'enabled')`
  is TRUE (the per-field opt-in).

Otherwise the element is left exactly as core built it (module does nothing).

## What it does
1. Reassigns the autocreate owner to the current user:
   `$element['target_id']['#autocreate']['uid'] = \Drupal::currentUser()->id();`
   Core normally sets this uid to the node owner, who may be a different (higher-privileged) user — so the
   access check must not run against them.
2. Gets the target entity type's access control handler
   (`entityTypeManager()->getAccessControlHandler($element['target_id']['#target_type'])`) and calls:
   ```
   $access = $access_handler->createAccess(
     entity_bundle: $element['target_id']['#autocreate']['bundle'] ?? NULL,
     account: \Drupal::currentUser(),
     return_as_object: TRUE,
   );
   ```
3. **If `!$access->isAllowed()` → `$element['target_id']['#autocreate'] = NULL;`** — removing autocreate so the
   widget will not create a new entity for text the user typed. If allowed, autocreate is left in place.
4. Attaches the access result's cache metadata to the element via
   `CacheableMetadata::createFromRenderArray(...)->addCacheableDependency($access)->applyTo(...)`, so the
   rendered/cached form varies correctly with the user's create access.

## Why it is fail-closed / safe
- The decision is derived server-side on every form build/rebuild; `#autocreate` is a build property, not a
  submitted value, so a client cannot re-add it. On rebuild the hook re-evaluates access.
- The module only ever **removes** the autocreate capability; it never returns an ALLOWED access result and
  never overrides a core deny. Existing entity-view/reference access is untouched.
- Create access is checked with the target **bundle**, so bundle-level create permissions are honored.
- It does not affect selecting/referencing existing entities — only inline creation of new ones.

## Scope limits
- Only the **autocomplete** widget is handled (not select/checkbox widgets, which don't autocreate).
- Only fields where an editor opted in via "Respect access"; all other fields keep core's default behavior.
