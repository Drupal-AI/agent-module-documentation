<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Excluding routes / how the gating works

## Adding an HTML route to the allowlist
Implement `hook_disable_ui_route_exclusions()` returning an array of route machine names to leave unrestricted:

```php
function mymodule_disable_ui_route_exclusions(): array {
  return ['mymodule.public_page', 'mymodule.webhook'];
}
```

Results are collected via `moduleHandler->invokeAll()` and cached in a static. Default exclusions (from `disable_ui.module`): `user.login`, `user.logout`, `user.logout.confirm`, `user.pass`, `user.reset`, `user.reset.form`, `user.reset.login`, `system.csrftoken`, `system.js_asset`, `system.css_asset`, `system.menu.linkset`, `rest.csrftoken`.

## API detection
`RouteSubscriber::isApiRoute()` inspects the route's `_format` requirement (splitting on `|`). A format matching `/(?:^api_.+$)|(?:^.*json$)/` marks the route as API and leaves it untouched. Routes with no `_format` are treated as HTML and get restricted. If you expose a custom API without a sentinel `_format`, either add an appropriate `_format` or exclude the route via the hook.

## Access decision
`DisableUiAccessCheck::access()`:
- allowed if the account has `access ui route`;
- OR allowed if `$request` is null (i.e. not the main request — this covers access checks run while building menus/links, so they don't spuriously fail).

Because the subscriber uses `setRequirement('_disable_ui','TRUE')`, the check is ANDed with the route's own access — it never overrides or weakens existing access control.

## Grant the permission
Give `access ui route` to any role that must reach themed HTML pages (admins, developers, editors). Ordinary decoupled API consumers do not need it.
