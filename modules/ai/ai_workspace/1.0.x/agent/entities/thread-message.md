<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Workspace — entities, ownership & ThreadManager

Two content entity types (SQL storage, auto-managed tables). All CRUD is funnelled through
`Service\ThreadManager` — controllers and services never touch entity storage directly.

## `ai_workspace_thread` (`Entity\AIWorkspaceThread`)
Base table `ai_workspace_thread`; `admin_permission = 'administer ai workspace'`; uses
`EntityOwnerTrait` + `EntityChangedTrait`. Entity keys: `id`, `uuid`, `label`, `owner`=`uid`, `status`.
Fields: `label` (string 255), `uid` (owner), `provider_id` (string 128), `model_id` (string 255),
`assistant_id` (string 128, nullable — set when in assistant mode; added by `ai_workspace_update_9002`),
`status` (boolean active/archived), `created`, `changed`. Helpers: `getModelKey()` = `provider_id__model_id`,
`isAssistantMode()`, `isActive()`. Canonical link `/workspace/thread/{ai_workspace_thread}` is declared but
there is no view controller/route wired — the SPA is the real UI.

## `ai_workspace_message` (`Entity\AIWorkspaceMessage`)
Base table `ai_workspace_message`; child of a thread via `thread_id` (entity_reference, required).
Fields: `role` (string 32 — `user`/`assistant`/`system`/`tool`, constants on
`AIWorkspaceMessageInterface`), `content` (string_long), `metadata` (string_long JSON — token usage etc.),
`tool_invocation` + `tool_result` (string_long JSON, reserved for future tool calls), `created`.
`getMetadata()`/`getToolInvocation()`/`getToolResult()` json-decode; `toChatArray()` shapes a message for
provider context.

## Access control
`Handler\AIWorkspaceThreadAccessHandler`: `administer ai workspace` → full bypass; otherwise
`view/update/delete` allowed only if the account is the owner **and** holds `use ai workspace`
(`cachePerUser`). `checkCreateAccess` = `use ai workspace` or `administer ai workspace`.
`Handler\AIWorkspaceMessageAccessHandler` derives access from the parent thread's ownership (forbidden if
the message has no parent). Note these entity-access handlers gate entity-API operations, not the REST
routes directly (see `agent/api/rest.md`).

## ThreadManager (`ai_workspace.thread_manager`)
- `DEFAULT_LABEL = 'New conversation'` — sentinel that drives auto-title generation.
- `createThread($label,$provider_id,$model_id,$assistant_id=null)` — creates + saves with `uid`=current
  user, `status`=1; logs creation.
- `getThread($uuid, $check_ownership=true)` — `loadByProperties(['uuid'=>...])`; throws
  `ThreadNotFoundException` (404) or `WorkspaceAccessDeniedException` (403). Ownership compares
  `getOwnerId()` vs current user id, skipped for `administer ai workspace`.
- `listThreads()` — entity query `uid`=current + `status`=1, `accessCheck(TRUE)`, newest first.
- `deleteThread($uuid)` — ownership-checked (via `getThread`), then bulk-deletes child messages
  (`accessCheck(FALSE)`) and the thread; logs it.
- `addMessage($thread,$role,$content,$metadata=[])` — creates a message and touches the thread's
  `changed` timestamp so lists re-sort.
- `getMessages($thread)` (oldest first) / `hasPendingUserMessage($thread)` (last message role == user) —
  both `accessCheck(FALSE)` (parent-thread ownership already enforced upstream).

## ChatService orchestration (`ai_workspace.chat_service`)
Ties ThreadManager + `AiProviderAdapterInterface` + ModelAdapter + ToolExecutor. `chat()` (sync) and
`stream()` build context via `buildConversationContext()` (maps stored messages to `ai` `ChatMessage`
DTOs + `resolveSystemPrompt()` from config). `streamAssistant()` loads the `ai_assistant` entity and
drives `ai_assistant_api.runner` (keyed by thread UUID). `generateTitle()` sends only the first user
message with a title-generation system prompt, best-effort (returns null on any exception).
