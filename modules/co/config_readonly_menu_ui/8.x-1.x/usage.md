<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Configuration Read-only Menu UI carves a narrow exception into `config_readonly` so **content** menu links can still be reordered on a locked-down production site, while the menu's configuration parts stay frozen.

---

`config_readonly` makes production configuration immutable: with `$settings['config_readonly'] = TRUE` set, configuration forms refuse to save, so the only sanctioned way configuration changes is through a deployment. That posture collides with the core Menu UI, because a single menu mixes two things Drupal stores differently — the **menu** itself and any module/config-defined links are configuration (`system.menu.*`), while **content menu links** (`menu_link_content` entities) are content. The core menu overview form (`Drupal\menu_ui\MenuForm`) saves the menu config entity on every submit, so `config_readonly` blocks the whole form and editors cannot even move a content-defined link. This module fixes that with three coordinated moves. (1) `hook_entity_type_alter()` swaps the `menu` entity's `add`/`edit` form class to `Drupal\config_readonly_menu_ui\ContentMenuForm` (a subclass of core's `MenuForm`); the swap happens unconditionally so the cached form definition is already correct whenever read-only mode is toggled on. (2) When `Settings::get('config_readonly')` is true, `ContentMenuForm::form()` disables (`#disabled = TRUE`) every top-level form element except `links` and `actions` and shows a warning, and `submitForm()` skips `parent::submitForm()` (which would save the menu config entity) — instead it calls only `submitOverviewForm()`, which persists the content menu links' weight/enabled changes. So the config entity is never written by this form; only content links are saved. Within the links table, `buildOverviewForm()` disables the `weight`/`enabled` widgets and hides the operations for any link that is **not** a `MenuLinkContent` (i.e. a config-defined link), and if any such read-only link is present it removes the table's `#tabledrag` so drag-and-drop (which could shift a config link's weight) is unavailable — editors then reorder content links via the visible weight `<select>` fields instead. (3) `hook_config_readonly_whitelist_patterns()` returns `['system.menu.*']`, adding that pattern to `config_readonly`'s whitelist so writes to menu configuration are not blocked by the read-only lock. Two consequences to understand: content menu-link weights are **content**, so a reorder made on production does not travel with a configuration export and stays on production; and the README warns that mixing content and config links in one menu can make some positions unreachable (a content link cannot be placed between two config links of equal weight), so space config-link weights out or keep menus single-kind. Requires `config_readonly`, `menu_ui` and `menu_link_content`; version 8.x-1.3 on core `^8 || ^9 || ^10 || ^11`; ships no permissions, routes, services or schema of its own.

---

- Keep `config_readonly` enabled in production while still letting editors reorder navigation.
- Let an editor move a content menu link on the live site without a deployment.
- Resolve the "I can't save the menu, the form is blocked" complaint under `config_readonly`.
- Reorder the main navigation menu on a frozen-config site.
- Change the weight/enabled state of `menu_link_content` links while config is locked.
- Support an editorial menu workflow on a GitOps / config-import pipeline.
- Reduce deployments for trivial, content-only menu changes.
- Keep the menu label, description and other config fields read-only on production.
- Prevent drag-and-drop from silently changing a config-defined link's weight.
- Reorder content links in a menu that also contains a view- or module-defined link.
- Fall back to weight `<select>` fields when a menu contains read-only links.
- Give a section owner control over their menu's ordering without config access.
- Keep the config lock narrow — only `system.menu.*` is exempted, nothing else.
- Maintain a strict deployment pipeline that still tolerates live menu ordering.
- Warn editors, via the on-form message, which parts of the menu form are disabled.
- Let a content link be enabled/disabled on production without touching config.
- Preserve `config_readonly`'s block on creating or renaming menus through the UI.
- Support a compliance-driven "no config edits in prod" policy with an editorial carve-out.
- Understand that reordered content-link weights stay on the environment they were changed on.
- Space out config-link weights when designing a mixed menu so content links can be placed between them.
