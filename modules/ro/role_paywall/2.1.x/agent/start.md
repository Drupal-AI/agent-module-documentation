<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Role Paywall (role_paywall) — agent index

Hides configured fields on premium content from users without a subscriber role. Core requirement
`^10.3 || ^11`. Configuration at `/admin/config/content/role_paywall`
(`administer site configuration`); permission `access paywalled content`.

> ## How the paywall is applied
>
> Enforcement is one line in `hook_entity_view()`, for the `full` view mode only:
>
> ```php
> if ($view_mode == 'full') { … $build[$field_name]['#access'] = $access; }
> ```
>
> `#access` hides a render element. There is **no `hook_node_access`, no field access, no query
> alter** in the module, so the stored field values are untouched: other view modes (e.g. a teaser
> that includes the field), JSON:API/REST, Views field rendering and search indexing are not
> filtered by it. Keep paywalled fields out of non-full displays and APIs if the content must stay
> restricted.

Key facts:
- `RolePaywallManager::checkAccess()` computes the role/permission decision; its result is applied
  as render-element `#access` in the full view mode.
- Admin routes are correctly gated by `administer site configuration`.
- A block is provided for the "subscribe to continue" prompt.
