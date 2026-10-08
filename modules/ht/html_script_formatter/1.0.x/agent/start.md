<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTML Script Formatter — agent index

A field formatter that **outputs the raw field value UNESCAPED** (renders HTML/`<script>`). Depends on core
`field`. Applies to `text`/`text_long`/`text_with_summary`/`string`/`string_long`. Version **1.0.3**. Core
`^8||^9||^10||^11`.

Returns the value as markup with no escaping (comment: "user input should equal the output") — also for
unformatted `string` fields. Use **only** on fields editable exclusively by fully-trusted admins; prefer a real
text format otherwise. No access role.
