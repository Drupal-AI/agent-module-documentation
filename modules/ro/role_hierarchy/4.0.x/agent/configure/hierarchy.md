<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Defining and tuning the hierarchy

There is **no dedicated settings page** (`configure: null`). The hierarchy is defined by the
**role order** on `/admin/people/roles`, and the module injects its three settings into that
same form.

## The ordering = the ranking

By default the module treats a role **higher in the list (lower weight)** as more powerful. An
account can edit a user / grant a role only when the target's rank is **at or below** the
account's own highest hierarchical role. Reorder roles on People > Roles to change who
outranks whom.

An account's effective rank is its **highest** hierarchical role (`getAccountHighestRole()`),
after removing any `non_hierarchical_roles`. An account with no hierarchical role is treated as
the weakest (weight `9999`, or `-9999` when inverted).

## Settings (saved to `role_hierarchy.settings`)

Edited in the **Role hierarchy** details fieldset on the People > Roles form; the submit
handler `_role_hierarchy_user_admin_roles_form_submit()` writes them.

| Key | Type | Effect |
|---|---|---|
| `invert` | boolean | Roles edit the roles **above** them instead of below. On save, existing role weights are negated so the visual order still matches. |
| `strict` | boolean | Cannot edit **equal** roles — only strictly higher/lower. Off = peers can edit peers. |
| `non_hierarchical_roles` | array (rid => rid/0) | Roles excluded from the hierarchy: they neither raise an account's rank nor are protected by it. |

The config object **does not exist until the form is saved once**. Read it with
`drush cget role_hierarchy.settings`; set it in code:

```php
\Drupal::configFactory()->getEditable('role_hierarchy.settings')
  ->set('strict', TRUE)
  ->set('invert', FALSE)
  ->set('non_hierarchical_roles', ['newsletter' => 'newsletter'])
  ->save();
```

## Comparison rules (from `RoleHierarchyHelper::hasRoleEditAccess()`)

Let `A` = account's highest-role weight, `E` = edited role weight.

| invert | strict | Access when |
|---|---|---|
| off | off | `A <= E` |
| off | on  | `A <  E` |
| on  | off | `A >= E` |
| on  | on  | `A >  E` |

`bypass role hierarchy` short-circuits all of this to allowed.
