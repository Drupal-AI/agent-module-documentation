<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Menu — agent index

Adds a **JSON:API resource exposing menus and their items** (fetch navigation for a decoupled front end).
Depends on core `menu_link_content`, `jsonapi_resources`. Version **1.1.0-beta7**. Core `^10||^11`.

Decoupled/web-services — exposes the **menu tree** (usually public navigation, but reveals linked paths — don't
put sensitive URLs in exposed menus; rely on each route's own access). No access role of its own.
