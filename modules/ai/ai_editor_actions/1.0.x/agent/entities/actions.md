<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Editor Actions — the action & category entities

Two content entity types, both administered under `/admin/config/ai/editor-actions` and shown in
the CKEditor "AI Actions" dropdown.

## `ai_editor_action` (`src/Entity/EditorAction.php`)

Content entity (`ContentEntityBase`, `EntityOwnerTrait`), base_table `ai_editor_action`,
`admin_permission = administer ai editor actions`, `collection_permission = create ai editor
actions`. Implements `EditorActionInterface`.

Base fields (`baseFieldDefinitions()`):

| Field | Type | Notes |
|---|---|---|
| `label` | string (max 64) | Shown in the dropdown, e.g. "Translate to Spanish". Required. |
| `instruction` | string_long (≤ 2000) | The instruction sent to the AI. Required. |
| `provider` | string (max 255) | `provider__model` simple option; `''` = site default chat model. |
| `category` | entity_reference → `ai_editor_action_category` | Optional grouping; uncategorized actions list flat. |
| `roles` | string, unlimited (max 64) | Role ids the action is shared with; empty = private to owner. |
| `status` | boolean (default TRUE) | Disabled actions stay configured but hidden from the dropdown. |
| `created` | created | Sort key. |
| `uid` | (owner) | Set to the current user in `preCreate()`. |

Interface accessors: `getInstruction()`, `getProvider()`, `isEnabled()`, `getCategoryId()`,
`getRoles()`. Reserved id constant `CUSTOM_ACTION_ID = 'custom'` marks the built-in free-form
"Ask AI" dropdown item (handled specially in the controller, not stored).

Forms: `Form\EditorActionForm` (add/edit, `Form\ActionCreateForm` for the modal add dialog,
`Form\EditorActionFormTrait`), core delete form. List builder `EditorActionListBuilder`.

## `ai_editor_action_category` (`src/Entity/EditorActionCategory.php`)

Grouping entity (`EditorActionCategoryInterface`); form `Form\CategoryForm`, list builder
`EditorActionCategoryListBuilder`, access handler `EditorActionCategoryAccessControlHandler`.
Categories with no visible actions are omitted from the catalog.

## Access model (`EditorActionAccessControlHandler`)

`checkAccess()`:
- `administer ai editor actions` → allowed (all ops), cache per permissions.
- owner (`getOwnerId() === account id`) → allowed, cache per user + entity.
- `view` op AND the account holds one of the action's shared `roles` → allowed.
- otherwise neutral.

`checkCreateAccess()` → allowed if the account has `administer ai editor actions` OR
`create ai editor actions`. The controller and `ActionCatalog` only ever expose actions that pass
`access('view')` and are enabled; a `transform` against an inaccessible action id returns 404 (not
403).

## Admin UI & menu

- Collection `entity.ai_editor_action.collection` at `/admin/config/ai/editor-actions` (the
  module's `configure` route; menu link `entity.ai_editor_action.collection` under
  *Configuration → AI*, parent `ai.admin_config_tools`).
- Local tasks (`ai_editor_actions.links.task.yml`): Actions / Categories / Settings tabs.
- Action links (`ai_editor_actions.links.action.yml`): "New Action" / "New Category" as modal
  dialogs.
- Route provider `AdminHtmlRouteProvider` supplies the add/edit/delete routes at
  `/admin/config/ai/editor-actions/…`.

## Starter content

`ai_editor_actions_install()` seeds five categories (Rewrite, Length, Analyze, Tone, Translate)
and their actions, owned by uid 1, shared with `authenticated`, on the default chat provider. See
the install file for the exact instruction strings.
