<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# securitytxt — agent start

Serves a standards-compliant `/.well-known/security.txt` (security.txt draft RFC / RFC 9116)
from one settings form. All state is the single config object **`securitytxt.settings`** — no
entities, plugins, or Drush. Two moving parts: the **config** (what to publish) and a
**controller + `SecuritytxtSerializer`** that renders it as plain text.

Key facts:
- Configure at **Admin → Configuration → System → Security.txt** — route `securitytxt.configure`,
  path `/admin/config/system/securitytxt`, permission `administer securitytxt`.
- The file is only served when `securitytxt.settings:enabled` is `TRUE`; otherwise the
  `/.well-known/*` routes throw 404 (`NotFoundHttpException`).
- Viewing `/.well-known/security.txt` (+ `.sig`) requires the `view securitytxt` permission —
  grant it to Anonymous + Authenticated.
- Saving as enabled requires at least one contact (email, phone, or contact page URL).

- Settings keys, the form, expiry/contact/policy, drush config, the enabled gotcha → [configure/settings.md](configure/settings.md)
- How the file is served & the exact field lines the serializer emits → [api/serializer.md](api/serializer.md)
- The two permissions and which role needs which → [permissions/permissions.md](permissions/permissions.md)
