<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DCAT-BE (dcat_be) — agent index

**Belgian Federal DCAT-AP profile: BE fields, three content entities, vocabulary import, JSON-LD export & validation.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Package:** DCAT
- **Dependencies:** dcat, dcat_export, dcat_ap, taxonomy, language, views, content_translation, inline_entity_form, entity_browser(+entity_form), address, field_group
- **Routes:** `/admin/structure/dcat/settings/dcat-be` & `/admin/structure/dcat/vocabulary-import` (`administer dcat be`); `/admin/content/dcat/dataset/{dcat_dataset}/validate` (`validate dcat be datasets`+`administer dataset entities` OR, plus `_entity_access: dcat_dataset.view`). Route subscriber overrides `dcat_export.export`.
- **Services:** `dcat_be.vocabulary_service`, `.export_service`, `.validation_service`, `.form_alter_subscriber`, `.route_subscriber`, `.commands`.
- **Plugins:** DcatFieldProvider (dataset/distribution/agent/vcard-org); 3 content entity types (License, Location, Quality Measurement).
- **Drush:** `dcat-be:import-vocabularies`, `:import-vocabulary`, `:update-vocabularies`, `:list-vocabularies`, `:validate-dataset`, `:export-dataset`.
- **Security:** Granular permissions on all routes; validate route read-only + entity-access gated. Vocabulary import fetches only from a hardcoded HTTPS EU/gov source list (no user input → no SSRF; TLS verification not disabled). No `_access: TRUE`, no raw SQL, no unserialize, no weak tokens/secrets. No security findings. (Minor: `hook_entity_view_alter` links route name `dcat_be.export.dataset` not defined in routing.yml — latent broken link, not a security issue.)

See [drush/commands.md](drush/commands.md).
