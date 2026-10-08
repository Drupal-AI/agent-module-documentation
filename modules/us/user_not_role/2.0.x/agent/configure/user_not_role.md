<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the User Not Role condition

There is **no dedicated admin/settings route** for this module. It contributes a condition plugin that appears wherever Drupal exposes condition/visibility UIs. The canonical place is **block visibility**.

## Add it to a block

1. Enable the module: `drush en user_not_role -y` (or Administration › Extend).
2. Go to **Administration › Structure › Block layout** (`/admin/structure/block`).
3. Press **Configure** on the block you want to control (requires the `administer blocks` permission).
4. Open the **"User Not Role"** vertical tab.
5. Under *"When the user does not have the following roles"*, check the role(s) the user must **not** have for the block to display.
6. Optionally tick **"Negate the condition"** to invert the meaning (see below).
7. **Save block**.

## Evaluation semantics

The condition computes the intersection of the roles you selected and the viewing user's roles:

- User has **none** of the selected roles → condition **passes** (block shows).
- User has **at least one** of the selected roles → condition **fails** (block hidden).
- **No roles selected** (and not negated) → passes for everyone (no restriction).
- **Negate** ticked → the result is inverted: the block then shows only to users who **do** have one of the selected roles (summary reads *"The user can be one of …"*).

Note: selecting several roles means "does not have **any** of these" — a user with even one of them fails the (non-negated) condition.

## Config storage

Saved under the block's `visibility` as the `user_not_role` condition, matching schema `condition.plugin.user_not_role`:

```yaml
visibility:
  user_not_role:
    id: user_not_role
    negate: false
    roles:
      editor: editor
      subscriber: subscriber
    context_mapping:
      user: '@user.current_user_context:current_user'
```

## The combination pattern (from the README)

To show a block to role **A** but not to users who *also* have role **B**:

- Set core **"User Role"** visibility to **A** (must have A).
- Set **"User Not Role"** visibility to **B** (must not have B).

A user with both A and B is hidden, because the User Not Role condition fails. Condition consumers AND the visibility conditions together.

## Cache

The condition varies on **`user.roles`** only (not per-user), so a page/block cache entry is correctly shared among users with the same role set and separated across different role sets. No extra configuration is needed.
