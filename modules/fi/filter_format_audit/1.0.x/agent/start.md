<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter Format Audit — agent index

**Audits text (filter) formats to identify content affected by format changes**. Depends on core `filter`,
`dynamic_entity_reference`. Provides permissions. Version **1.0.0-rc9**. Core `^8.8||~9.0||^10||^11`.

**Security/QA-positive** admin tool — see which content uses a format before changing it (avoid breaking
sanitization / exposing raw HTML). Report gated by permission; no access role beyond that.
