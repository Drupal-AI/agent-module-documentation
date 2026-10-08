<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Answers — HTTP endpoints & the answer pipeline

`src/Controller/AiAnswersController.php`. Both routes are POST, require the `use ai answers`
permission and a CSRF request-header token (`X-CSRF-Token`, fetched by the JS from
`/session/token`). Both set `Cache-Control: no-store`.

## `POST /ai-answers/question` — `AiAnswersController::question()`

Body JSON: `{ agent, question, conversation_id? }`. `agent` is an `ai_agent` id; `conversation_id`
is an existing conversation UUID for a follow-up. The response is **content-negotiated on the
`Accept` header**:

- `Accept: text/event-stream` → `streamAnswer()` returns a `StreamedResponse` (SSE). Frames:
  - `references` — `{ turn, references: [...] }`, fired once before generation completes (lists
    every retrieved source).
  - `token` — `{ text }` per streamed chunk.
  - `done` — `{ conversation_id, turn, text, references }` (the final citation-filtered/renumbered
    pair, plus `log_id`/`trace_id` **only** with `view ai answers traces`).
  - `error` — `{ message }` (a fixed generic message; details go to the log only).
  The session write lock is released (`$this->session->save()`) before the long-lived stream so a
  concurrent same-session request isn't blocked.
- otherwise → `jsonAnswer()` returns one JSON `Answer` (`Data/Answer::toArray($traces)`:
  `{ conversation_id, turn, answer: { text, references }, log_id?, trace_id? }`). Exceptions map to
  status codes: `DomainException`→409, `InvalidArgumentException`→400, `OutOfBoundsException`→404,
  anything else→500 (generic message).

## `POST /ai-answers/feedback` — `AiAnswersController::feedback()`

Body JSON: `{ conversation_id, turn, rating, comment? }`. Validates (`conversation_id` non-empty,
`turn >= 1`, `rating` non-empty) then calls `Service/FeedbackLogger::log()`. Returns
`{ status: "recorded" }` or a JSON error (400/404/500). `rating` normalises to `positive`/`negative`
(accepts `up`/`1`/`positive`, `down`/`-1`/`0`/`negative`); an unknown rating → 400.

`FeedbackLogger` loads the conversation record (authorising the write — see conversation ownership
below), checks the agent's `feedback_enabled`, then, when `ai_logging` is present, writes the
feedback onto the correlated `ai_log` (a `feedback:positive|negative` tag plus an
`ai_answers_feedback` block in `extra_data` with rating/comment/uid/ts), and, when Langfuse is
present and a `trace_id` was stored, submits a `user_feedback` score against the trace. Both
integrations degrade gracefully when absent.

## The answer pipeline — `Service/AnswerService::answer()`

1. Trim/validate the question (empty → `InvalidArgumentException`).
2. Resolve the agent: a follow-up is pinned to the agent the conversation was created with; load
   the `ai_agent`; require `enabled`; resolve RAG settings (else `DomainException`).
3. `prepareConversation()` — new conversation (fresh UUID, `uid` recorded) or resume an existing
   one. **Ownership gate:** an authenticated-owned conversation (`uid > 0`) is resumable only by
   that uid (`OutOfBoundsException` otherwise); an anonymous-owned one (`uid 0`) is
   bearer-by-unguessable-UUID.
4. Thread prior turns (capped by `max_history_turns`) as user/assistant chat messages + the new
   question.
5. `generate()` — runs the agent via `AiAgentManager::createInstance()` /
   `determineSolvability()` / `solve()`. A **brand-new** question forces one `rag_search` call
   (`forceRagSearch()`) before the agent runs, so round-1's system prompt already carries the
   sources block; a follow-up leaves retrieval to the agent's own tool-call decision, captured via
   `AnswerToolResultSubscriber` → `AgentRunContext`. Streams chunks to `$onToken` when streaming.
6. Retrieval results → `resolveRetrievedSources()`: score-threshold filter, optional rerank
   (`maybeRerank`, only when a rerank provider is configured), distinct-entity cap, then
   `renderReferences()`.
7. **Access + render** — `renderReferences()` loads each source entity (in the retrieved langcode)
   and **drops any the current user cannot `view`**, renders the survivors with
   `renderer->renderInIsolation()`, and keeps prompt `[n]` indices in lockstep with the reference
   list. The sources block fed back into the LLM prompt (`buildSourcesBlock`) is built from these
   access-checked survivors.
8. Post-process — `stripOutOfRangeMarkers()` drops `[n]` outside range; `finalizeCitations()` keeps
   only cited sources and renumbers markers. On the JSON path only, a turn with zero surviving
   sources returns the configured no-answer message instead of a generation.
9. `persist()` — appends the `ConversationTurn` (question, answer, ts, log_id, trace_id, sources) to
   the `ai_answers.conversations` expirable key-value store with the agent's TTL.
10. `captureIds()` — best-effort `log_id` (newest `ai_log` tagged `ai_agents_runner_<runnerId>`)
    and Langfuse `trace_id`, returned to the caller (exposed to the client only with the traces
    permission).

## DTOs (`src/Data/`)

`Answer` (conversationId, turn, text, references[], logId, traceId), `ConversationTurn` (question,
answerText, ts, logId, traceId, sources[]), `Reference` (index, entityType, entityId, label, url,
score, rendered HTML, viewMode — `toArray()` omits the chunk and view mode), `Source` (entityType,
entityId, score, chunk text, viewMode, langcode; `withScore()`).
