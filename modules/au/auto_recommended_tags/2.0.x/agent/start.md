<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# auto_recommended_tags

Real-time taxonomy tag suggestions via Apache Stanbol over WebSocket.

- Settings form at `/admin/config/services/auto_recommended_tags` (perm `administer auto recommended tags settings`).
- Front-end JS (js/, built via gulp/scss) opens a WebSocket to Stanbol and streams suggestions into the content form.
- Dep: core `taxonomy`. Requires an external Stanbol server.

See [../usage.md](../usage.md).
