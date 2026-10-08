<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Quick Media Edit — agent orientation

Single-file module (`quick_media_edit.module`). It implements
`hook_preprocess_image_formatter()`: when the image formatter render array carries a `url`
and the current user passes `$url->access()`, it sets a `destination` route parameter equal to
the current path (`path.current`). Otherwise it unsets the URL.

- No routes, services, permissions, config, or forms.
- Depends on core `media` + `image`.
- Security: access is checked before mutating the URL; no disclosure or escalation.
- Nothing to configure; behaviour is automatic once enabled.
