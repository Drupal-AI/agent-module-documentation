<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Signifyd webhook contract

**Endpoint:** `POST /webhook/signifyd/{signifyd_team}` (`_access: TRUE`).

**Authentication** (`Signifyd\Webhook::validWebhookRequest`): the module reads the raw request body and the headers `X-SIGNIFYD-TOPIC` and `X-SIGNIFYD-SEC-HMAC-SHA256`, then computes `base64_encode(hash_hmac('sha256', $body, $team->getApiKey(), TRUE))` and compares it to the header. Empty body/hash/topic → reject. Mismatch → `BadRequestHttpException` (400). No case is created or order transitioned until validation passes.

**Test topic:** for `topic == cases/test` only, an HMAC computed with the literal key `ABCDE` is also accepted — this is Signifyd's documented test-webhook placeholder and carries no `caseId`/case, so it cannot mutate a real order.

**Handled topics:** `cases/creation`, `cases/rescore`, `cases/review` create/update a `signifyd_case` (score, guarantee, investigation id, status); `cases/decision` sets score + decision and maps ACCEPT/REJECT to a guarantee. After update, a `SignifydWebhookEvent` is dispatched and — if the order type has `workflow` enabled — the order is moved via the configured approved/declined transition based on `decision_type`.
