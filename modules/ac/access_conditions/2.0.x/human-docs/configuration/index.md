# Configuration

Configuration has two halves: building **access models** in the admin UI, and
**referencing** those models from whatever should respect them.

## 1. Open the access-models list

Go to **Configuration → System → Access models**
(`/admin/config/system/access-models`). This page lists your models and lets you
add new ones. It requires the `administer access models` permission.

## 2. Create a model

Add a model and give it a clear name (it becomes exportable configuration, so the
name travels between environments). A model is a container for conditions plus a
logic operator.

## 3. Add conditions

Into the model, add one or more of Drupal's core **Condition plugins** — for
example **Request path**, **User role**, and other request/context conditions.
Each add, edit, and delete action on a condition is permission-gated. Add as many
conditions as the rule needs, but keep the set minimal for good cacheability.

## 4. Choose the access logic

Set the model's **logic operator**:

- **AND** — every condition must match for the model to grant access.
- **OR** — any single condition matching is enough.

## 5. Reference the model from a consumer

A model does nothing on its own — something has to *use* it. Point a consumer at
the model:

- A **field group**, via `access_conditions_field_group`, to show/hide a group.
- A **Commerce checkout pane**, via `access_conditions_commerce`, to show/hide a
  pane.
- An **entity**, via the `access_conditions_entity` submodule's access-model
  reference field — attach it to an entity display with the autocomplete widget.
  You can attach multiple models; access is granted if **any** attached model
  passes.
- **Custom code**, by calling the checker directly:

  ```php
  \Drupal::service('access_conditions.access_checker')->checkAccess($model);
  ```

The checker applies its runtime context mappings, resolves the conditions, and
returns TRUE or FALSE. Consumers typically hide content by setting
`#access = FALSE` when no model grants access. Remember to merge the checker's
cache contexts, tags, and max-age into your render array so caching stays correct.

## The bypass permission

A user with **`bypass access conditions access`** short-circuits evaluation to
TRUE — every model passes for them. Grant it only to roles that genuinely should
ignore all visibility rules.

## Test it

Always test your models as both an **anonymous** and an **authenticated** user to
confirm the right people see the right content before relying on a model in
production.
