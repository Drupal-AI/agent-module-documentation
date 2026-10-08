<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring / applying the condition

The module has **no admin UI, no configure route, and no settings form of its own**. Enabling it
just makes the `user_permission` condition appear inside every condition consumer. Configuration is
per *instance* (per block, per Context reaction, etc.), stored in that host's config.

## Via the block UI (most common)

1. Enable the module: `ddev drush en user_permission_condition -y`.
2. Place or edit a block (**Structure → Block layout**, or a block field). Open the block's
   **Visibility** section.
3. Choose the **User Permission** tab. Pick a permission from the select (options are grouped by the
   module that provides them). Optionally tick **Negate the condition** to invert the match.
4. Save. The block now shows only when the current user has (or, if negated, lacks) that permission.

Leaving the permission empty makes the condition pass unconditionally (it is a no-op — see the
plugins doc), so it neither shows nor hides anything by itself.

## Config schema / stored shape

The instance config validates against `condition.plugin.user_permission`
(`config/schema/user_permission_condition.yml`), which extends core's `condition.plugin` and adds
one key:

```yaml
permission:            # machine name of the selected permission, e.g. 'access administration pages'
```

Combined with the inherited base keys, a stored block-visibility instance looks like:

```yaml
visibility:
  user_permission:
    id: user_permission
    permission: 'access administration pages'
    negate: false
    context_mapping:
      user: '@user.current_user_context:current_user'
```

`context_mapping.user` is what feeds the required `user` context; the block system wires it to the
current user automatically.

## Setting it via drush / config import

Because it is plain config, you can set it without the UI. Example — read then rewrite a block's
visibility:

```bash
ddev drush cget block.block.MYBLOCK visibility
# add/edit the user_permission entry, then:
ddev drush cset block.block.MYBLOCK visibility.user_permission.id user_permission
ddev drush cset block.block.MYBLOCK visibility.user_permission.permission 'access administration pages'
ddev drush cset block.block.MYBLOCK visibility.user_permission.negate 0
```

Or include the `visibility:` block above in the block's exported YAML and `drush config:import`.

## Other consumers

Anything that uses `plugin.manager.condition` exposes it the same way — **Context** (context module)
reactions, **Page Manager** variant selection, Rules-style condition UIs, and custom code (see
[../plugins/user_permission_condition.md](../plugins/user_permission_condition.md) for the
programmatic path and the `user.permissions` cache-context requirement).
