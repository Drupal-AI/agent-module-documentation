<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Browser Class — agent index

Adds browser/platform/device CSS classes to `<body>` on every page, and exposes the same detection
as tokens. No config UI (`configure` null), no permissions, no Drush, no config schema. Enable and
the classes appear.

- **Body classes (client-side JS), tokens (server-side), the `browserclass_classes` extension hook,
  and the `browserclass_get_classes()` API** → [api/detection.md](api/detection.md)

Key facts:
- `hook_page_attachments_alter()` attaches library `browserclass/global-browserclass`
  (`js/browserclass.min.js`, dep `core/jquery`); its JS reads `navigator.userAgent` and
  `$('body').addClass(...)`.
- Class families: browser (`chrome`, `ff`, `safari`, `ie`+`ie11`, `opera`, `operamini`, …, often
  with major version appended), platform (`win`, `mac`, `linux`, `android`, `iphone`, `ipad`, …),
  and one of `mobile` / `desktop`.
- Server-side equivalent from `$_SERVER['HTTP_USER_AGENT']` via tokens (all `Html::escape`d).
