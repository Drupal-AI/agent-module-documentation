<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content callback — agent index

A **field type whose value is a ContentCallback plugin id**; the plugin renders dynamic content at display time.
Version **2.0.x**. Core `^9 || ^10`. Depends on `field`, `options`. Submodules: `content_callback_block`,
`content_callback_views`, `content_callback_examples`.

Security: SOUND. Callbacks are **annotated plugins** resolved through a plugin manager — the field stores a
plugin id chosen from a curated list, NOT a user-supplied function name; no `call_user_func` on untrusted input,
no arbitrary code execution. Output rendered via a standard field formatter.
