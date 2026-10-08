<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LangFuse integrates the LangFuse LLM-observability SDK for tracing AI calls.

---

LangFuse **integrates the LangFuse PHP SDK** — sending traces/observability data about the site's LLM/AI calls
(prompts, responses, latency, cost) to LangFuse, an LLM-observability platform, for monitoring and debugging AI
features. It depends on core Config and System.

Use it to observe/trace AI usage. It is an AI-observability integration. Security/data handling: it **sends AI
trace data to LangFuse** (external egress) — this can include **prompt and response content (potentially sensitive
or PII)**, so confirm it's acceptable to send that off-site and disclose per your privacy policy; authenticate with
**LangFuse API keys** stored as secrets (env/Key) over HTTPS. It has no access-control role. Configure the LangFuse
credentials.

---

- Trace LLM/AI calls to LangFuse.
- Send prompts/responses/metrics.
- Aid AI monitoring/debugging.
- Depend on core Config + System.
- Serve AI observability.
- Use the LangFuse PHP SDK.
- Send AI trace data to LangFuse (egress; may include prompt/response PII).
- Confirm it's acceptable off-site + disclose per policy.
- Store LangFuse API keys as secrets (env/Key, HTTPS).
- Have no access-control role.
- Configure the LangFuse credentials.
- Handle AI tracing.
- Trace AI.
- Configure the client.
- Send traces.
- Handle the integration.
- Monitor AI.
- Observe LLM calls.
- Secure the keys.
- Provide AI observability.
