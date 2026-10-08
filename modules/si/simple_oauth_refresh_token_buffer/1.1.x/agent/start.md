<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple OAuth Refresh Token Buffer — agent index

**Buffers OAuth token-refresh responses for a short period** so concurrent/duplicate refresh requests get the
same response instead of failing (combats refresh-token rotation races). Depends on `simple_oauth`. Version
**1.1.1**. Core `^10.3||^11`.

Reliability/security-adjacent — keep the **buffer window short** (a brief tolerance window, not long-term
refresh-token reuse; preserves single-use semantics). No access role.
