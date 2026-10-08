<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PreGenerateResponseEvent subscriber (HTML/URL preservation)

`src/EventSubscriber/AiTmgmtPreRequestEventSubscriber.php`
(service `ai_tmgmt.pre_request_event_subscriber`) subscribes to the AI module's
`PreGenerateResponseEvent` (`\Drupal\ai\Event\PreGenerateResponseEvent::EVENT_NAME`).

`onPreRequest()` acts only when **all** of these hold:
- the input is a `ChatInput`, and
- the request tags include `ai_tmgmt` (the tag the `ai` translator's basic-prompt path adds to
  `$provider->chat(..., ['ai_tmgmt'])`), and
- no hostname filter is already set on the input.

When they do, it sets `new HostnameFilterDto(fullTrust: TRUE)` on the input. This tells the AI
module to skip its default hostname/URL filter, which otherwise runs each non-streamed chat
response through a Masterminds HTML5 DOM parse-and-reserialize cycle. For a translation
round-trip that cycle would reorder/normalize attributes and drop external URLs not in the AI
module's global `allowed_hosts` allowlist, corrupting the translated markup relative to the
source. The AI module's `ProviderProxy` restores the previous filter state after the request, so
the override is scoped to `ai_tmgmt`-tagged translation calls only and does not affect other AI
requests.

Integrator note: because of this, the model's HTML output is stored on the job item as-returned.
Rendering of accepted translations is handled by the target field's normal text-format pipeline
(the same as any other content), so the display format applied to rich-text fields governs the
final rendered markup — configure those formats as you would for any editor-supplied content.
