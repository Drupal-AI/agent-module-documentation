<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AttemptFactory API (`attempt_mgmt.factory`)

`src/AttemptFactory.php` — `final class AttemptFactory` (uses `LoggerChannelTrait`). Service id `attempt_mgmt.factory`, constructor args: `@database`, `@current_user`, `@entity_type.manager`, `@entity_field.manager`. This is the integration surface other modules use to drive attempts. Get it with `\Drupal::service('attempt_mgmt.factory')` or inject the service.

Users are identified by `uid` when authenticated; anonymous visitors are identified by a per-session UUID (`getSessionIDForUnauthenticatedUsers()`, stored in the session under `core.tempstore.private.owner`). Most read queries call `->accessCheck(FALSE)` because they run as the site's own bookkeeping, not as user-facing listings.

## Discovering a host's configuration
- `getAttemptField(EntityInterface $entity)` — the first `attempt_mgmt_attempt_settings` field value on the entity (via internal `getAvailableAttemptManagementField()`), or NULL.
- `getAttemptFieldByProperty(EntityInterface $entity, $property)` — one property of that field (e.g. `attempt_type`, `limit`, `force_new_attempt`).
- `isForceNewAttempt(EntityInterface $entity)` — TRUE when the field's `force_new_attempt` is set.

## Counting & limit checks
- `numberAttemptsPerUser(EntityInterface $entity, $user_id, $session_id)` — count of non-temporary attempts for the user/session on that host entity.
- `allowNewAttempt(EntityInterface $entity, int $user_id, $session_id): bool` — FALSE when `limit > 0` and the current count equals the limit (a limit of 0 means unlimited).
- `getBestAttempt(EntityInterface $entity, $sort_field = NULL)` — the current user's top attempt sorted DESC by `$sort_field` (returns the entity or NULL).
- `getLastAttemptDateForUser(...)` (protected) — most-recent `created` timestamp for the user/session.

## Creating & updating attempts
- `createAttempt(EntityInterface $entity, $user_id, $session_id = NULL): string` — creates an `attempt_mgmt_attempt` in the host's `attempt_type` bundle with `number_attempt = count+1`, `temporary = TRUE`, `status = TRUE`, and returns the new UUID. If a previous attempt exists it calls `updatePreviousAttempt()` to close the prior open, non-temporary attempt of that number. Errors are caught and logged to the `attempt_mgmt` channel.
- `updateAttempt(string $attempt_uuid, array $field_data, EntityInterface $entity, $user_id, $finished = FALSE): bool` — loads the attempt by UUID, sets `temporary = FALSE` (and `closed = TRUE` when `$finished`), writes each `$field_data` field, saves. Returns success.
- `updatePreviousAttempt()` / `createOrUpdateAttempt()` — internal helpers.

## Reading / closing existing attempts
- `getExistingAttempt(EntityInterface $entity, $user_id): bool` — whether the user/session has any attempt on the entity.
- `getExistingTemporaryAttempt(EntityInterface $entity, $user_id)` — UUID of an in-progress (temporary) attempt, or NULL.
- `getCurrentAttempt(EntityInterface $entity, $user_id)` — UUID of the newest non-temporary attempt.
- `getLastAttemptForUser(EntityInterface $entity, $user_id)` — UUID of the highest-id attempt.
- `setCurrentAttemptToClosed($attempt_uuid)` — mark one attempt `closed = TRUE`.
- `setAttemptsToClosedForUser(AccountInterface $account)` — close all of a user's open, non-temporary attempts; called from `hook_user_logout` (`attempt_mgmt.module`), and logs a notice with the count.

## Misc
- `getEntity($entity_type_id, $entity_id)` — load a host entity or NULL.
- `getAttemptConfig()` — pulls the confirm strings (`attempt_question`, `start_new_attempt_label`, `proceed_attempt_label`) from `attempt_mgmt.settings` config.

## Typical consumer flow (e.g. scorm_field)
1. On host view/interaction, read the field with `getAttemptFieldByProperty()`; check `allowNewAttempt()`.
2. If allowed, `createAttempt()` and keep the returned UUID for the session.
3. As results arrive, `updateAttempt($uuid, ['status' => ..., <your fields>], $entity, $uid, $finished)`.
4. `setCurrentAttemptToClosed()` / logout closes the attempt.

Note: the class also carries a raw-DB settings API (`settingExists`/`loadSettings`/`insertSettings`/`updateSettings`) against the `attempt_mgmt_settings` table (see [config doc](../config/settings.md)); these are not wired into the current flow.
