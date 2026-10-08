<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Current URL — agent index

A **global Views field** exposing the **current URL**, its parts, or query parameters (build links / show
context / use the request query in output). Depends on core `views`. Version **1.0.2**. Core `^9||^10||^11`.

Content-display/Views — query parameters are **user-controlled input**: render them through normal Views
escaping (no raw reflected input). No access role.
