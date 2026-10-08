<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LangFuse — agent index

**Integrates the LangFuse LLM-observability SDK** (traces AI calls: prompts/responses/metrics). Depends on core
`config`, `system`. Version **1.0.2-alpha1**. Core `^10||^11`.

AI-observability — **sends AI trace data to LangFuse** (egress; can include **prompt/response PII** — confirm +
disclose); **API keys** as secrets (env/Key, HTTPS). No access role.
