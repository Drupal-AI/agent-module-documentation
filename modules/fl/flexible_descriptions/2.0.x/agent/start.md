<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flexible descriptions (flexible_descriptions) — agent index

**Central UI to add/edit/translate field descriptions (help text) per entity-type|bundle.**

- **Version:** 2.0.x  | **Core:** ^9 || ^10  | **Package:** Administration
- **Configure:** `entity.flexible_description.settings` (perm `administer flexible_description`); management form perm `manage flexible descriptions`.
- **Composer dep:** drupal/single_content_sync ^1.3 (not in info.yml). **Submodule:** flexible_descriptions_sync.
- **Routes:** HTMX controller `DescriptionHTMX` (GET build / POST performAction / cancel), each `_custom_access: checkAccess`.

**Access model:** `checkAccess()` reads the request-supplied `description-identifier`, splits it into `entity_type|bundle`, and requires the dynamic permission `manage flexible descriptions in {type}|{bundle}`. The identifier is attacker-controlled but the permission check still requires the current user to actually hold that granular permission — sound, no bypass.
