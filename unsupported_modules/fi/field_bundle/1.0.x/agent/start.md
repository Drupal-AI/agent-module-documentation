<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Bundle — agent orientation

D9.2/D10 module providing the generic `field_bundle` content entity type with site-builder-defined bundles (`field_bundle_config` config entities).

- Bundle admin: `admin/structure/field-bundle`. Fields via standard Field UI.
- Full stack: access control handler (`FieldBundleAccessControlHandler`), query access, revision access check (`Access/FieldBundleRevisionAccessCheck`), translation controller, list builders, revision controller/forms.
- Permissions: create/view/update/delete (own/any), revisions, admin — see `field_bundle.permissions.yml` + `FieldBundlePermissions::getFieldBundlePermissions`.
- Submodules: `field_bundle_canonical`, `group_field_bundle` (Group integration with its own controller/route provider).
- Security: proper entity access + revision access checks are present; nothing anon-facing. Well-structured; no findings.
