<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MarkdownService, MarkdownController & DifyChatProxyService

Two shared services the widget/search submodules depend on, plus the render controller.

## MarkdownService (`dify.markdown_service`)

`Drupal\dify\Service\MarkdownService` (`src/Service/MarkdownService.php`) wraps
`League\CommonMark\CommonMarkConverter`. Constructor config is deliberately hardened:
`html_input => 'escape'`, `allow_unsafe_links => FALSE`, `max_nesting_level => 10` — so raw HTML
in an LLM response is escaped, not emitted, and `javascript:`/`data:` links are dropped.

- `toHtml(string $markdown)` — convert then `processLinks()`; on any exception falls back to
  `htmlspecialchars(..., ENT_QUOTES | ENT_HTML5)`.
- `toHtmlStreaming(string $markdown, bool $is_complete=FALSE)` — same conversion for partial
  streaming chunks; on exception falls back to `simpleMarkdownFormat()` (a small
  htmlspecialchars-first regex formatter for bold/italic/code/headings/list items). When
  `$is_complete` it defers to `toHtml()`.
- `processLinks()` (protected) — regex that adds `target="_blank" rel="noopener noreferrer"` to
  absolute `http(s)://` links only.

## MarkdownController

`Drupal\dify\Controller\MarkdownController` (`src/Controller/MarkdownController.php`),
`render(Request)` reads a JSON body `{markdown, is_complete}` and returns JSON `{html}` from
`MarkdownService::toHtmlStreaming()`. On error it logs to `logger.channel.dify` and returns the
escaped markdown. **This controller defines no route of its own** — `dify_widget_vanilla` and
`dify_augmented_search` each register a `…/markdown/render` POST route (`_permission: access
content`) pointing here, so the client JS renders markdown through the server rather than in the
browser.

## DifyChatProxyService (`dify.chat_proxy_service`)

`Drupal\dify\Service\DifyChatProxyService` (`src/Service/DifyChatProxyService.php`, arg
`@logger.channel.dify`) streams SSE responses from Dify to the browser while the API token stays
server-side.

- `streamChatMessages($base_url, $token, $request_body, $content_type='application/json')` →
  `POST {base_url}/v1/chat-messages`.
- `streamWorkflowRun($base_url, $token, $request_body)` → `POST {base_url}/v1/workflows/run`
  (stateless single-turn, used by augmented search).
- Private `streamToUrl()` — calls `session_write_close()` first (releases the session lock so
  concurrent requests aren't blocked for the whole stream), then returns a Symfony
  `StreamedResponse`. Inside the callback it flushes all output buffers, `set_time_limit(0)`, and
  uses **native curl** with `CURLOPT_WRITEFUNCTION` echoing+`flush()`ing each chunk to bypass
  Guzzle/middleware buffering. curl options include `CURLOPT_SSL_VERIFYPEER => TRUE`,
  `CURLOPT_TIMEOUT => 300`, and a `Authorization: Bearer <token>` header. Response headers set
  `text/event-stream`, `Cache-Control: no-cache, no-store`, `X-Accel-Buffering: no`. curl errors
  are logged and surfaced to the client as a single `data: {event:error,...}` SSE frame.

Both `$base_url` and `$token` are supplied by the calling controller from admin-configured Drupal
**State** (keyed by block/server), never from the incoming request.
