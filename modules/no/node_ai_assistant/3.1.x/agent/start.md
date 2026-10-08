<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node AI Assistant — agent index

**Adds an AI chatbot tab to node edit forms to query field data**. Depends on core `node`, `ai`. Provides
permissions. Version **3.1.0**. Core `^10||^11`.

AI/content-editing — **sends node field data + prompts to the AI provider** (egress; can be unpublished/sensitive —
confirm + disclose); AI credentials as secrets; gate to editors. No access role beyond permission.
