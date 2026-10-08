<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Txt42 (txt42) — agent index

**Bridges the Txt42 ChatGPT AI writing assistant into CKEditor via the N1ED integration.**

- **Version:** 8.x-2.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Depends:** ckeditor (CKEditor 4), n1ed
- **Package:** CKEditor

**Surface:** no routes, permissions, services or blocks (empty routing/permissions files) — a dependency/wiring module. Txt42 is enabled as an editor feature through N1ED on a text format's toolbar.

**Security:** no server-side endpoints. Content is sent to the external Txt42/N1ED AI service — review that provider's data handling and API-key setup before enabling for editors. Editor availability is governed by text-format permissions.
