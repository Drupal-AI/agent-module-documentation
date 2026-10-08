<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Redirect redirects to the uri value of a link, file or image field for content entities.

---

Field Redirect redirects an entity's page to the URI stored in one of its fields — so viewing an entity
(node etc.) redirects the visitor to the URL/file in a chosen link, file or image field, useful for
"link" content types that should send visitors straight to an external URL or document. It requires PHP 8.1,
is configured at `field_redirect.settings`, provides its own permissions.

Use it where an entity should redirect to a field's URI. It redirects to whatever URL/URI the field
holds. It has no access-control role. Configure which field drives the redirect.

---

- Redirect an entity to a field's URI.
- Send visitors to a field's URL/file.
- Support link content types.
- Require PHP 8.1.
- Configure at field_redirect.settings.
- Provide its own permissions.
- Understand it redirects to the field's URL.
- Have no access-control role.
- Configure the driving field.
- Redirect to documents.
- Handle field-based redirects.
- Redirect entities.
- Configure redirects.
- Send to external URLs.
