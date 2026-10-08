<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# llms.txt AI Generator — agent index

**Automatically generates an llms.txt file using AI** (make content discoverable by LLMs). Depends on `ai`,
`metatag`, `menu_ui`. Provides permissions. Version **0.0.3**. Core `^10||^11`.

Content-authoring/SEO — **sends content to the AI provider** (egress); publishes **llms.txt for LLM crawlers**
(only public-intended content); AI key as a secret. No access role beyond permission.
