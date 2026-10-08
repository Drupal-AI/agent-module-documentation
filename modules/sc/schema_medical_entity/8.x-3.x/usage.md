<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Schema.org MedicalEntity extends Schema.org Metatag (`schema_metatag`) with the medical branch of Schema.org — conditions, drugs, procedures, studies, physicians, anatomical structures and more — emitting them as JSON-LD in the page head. The base module provides the `MedicalEntity` type and its shared properties; eighteen submodules each add one top-level medical type, so a site enables only the ones it needs.

---

Schema.org's medical vocabulary is unusually large because health information is unusually structured: a condition has signs, causes, risk factors and treatments; a drug has an active ingredient, a dosage schedule, contraindications and interactions; a procedure has a preparation, a followup and a body location. This module maps that vocabulary onto Drupal's Metatag system. It is a pure add-on to `schema_metatag` (>=3.0), which owns the actual JSON-LD assembly, token replacement and per-content-type/per-node override system; this project only contributes the medical `@type` options and their fields as Metatag tag plugins. Architecturally the base module `schema_medical_entity` registers a Metatag group (`Schema.org: MedicalEntity`), a Tag plugin per MedicalEntity property (`@type`, `code`, `guideline`, `legalStatus`, `medicineSystem`, `recognizingAuthority`, `relevantSpecialty`, `study`, plus inherited Thing properties such as `name`, `description`, `image`, `url`, `sameAs`, `identifier`, `mainEntityOfPage`), reusable Base/Trait classes (`SchemaMedicalEntityBase`, `SchemaMedicalCodeBase`, `SchemaMedicalGuidelineBase`, `SchemaMedicalSpecialtyBase`, `SchemaMedicalStudyBase`, `SchemaMedicineSystemBase`, `SchemaSupersededByBase`) and two shared `schema_metatag` PropertyType plugins (`hospital_affiliation`, `member_of`). The eighteen submodules — `schema_anatomical_structure`, `schema_anatomical_system`, `schema_drug`, `schema_drug_class`, `schema_drug_cost`, `schema_medical_cause`, `schema_medical_condition`, `schema_medical_device`, `schema_medical_guideline`, `schema_medical_procedure`, `schema_medical_risk_estimator`, `schema_medical_risk_factor`, `schema_medical_study`, `schema_medical_test`, `schema_medical_web_page`, `schema_physician`, `schema_substance`, `schema_superficial_anatomy` — each depend on `schema_metatag` + `schema_medical_entity` and ship a Metatag Group plus generated Tag plugins for that type's properties. Those Tag plugin classes are scaffolded from each submodule's `config/schema/*.metatag_tag.schema.yml` by the module's Drush command `schema_medical_entity:generate-tags` (`--module=schema_drug --type=Drug`), a maintainer/developer tool, not something end users run. There is no admin UI of its own and no permissions: once enabled, the medical `@type` values and fields appear inside the normal Metatag configuration forms (global defaults, per bundle, or per entity), where you hard-code values or use tokens exactly as with any other Schema Metatag type. Two cautions are inseparable from medical structured data: markup asserting a dosage, contraindication or indication is a machine-readable clinical claim, so a mis-mapped field is a wrong claim published under the organisation's name; and medical content is regulated in most jurisdictions, so clinical review of the mapping is the same duty of care as clinical review of the prose.

---

- Enable `schema_medical_condition` and mark up a disease/condition page with signs, causes, risk factors and possible treatments.
- Enable `schema_drug` to describe a drug's active ingredient, dose schedule, mechanism of action, contraindications and interactions.
- Add `schema_drug_class` markup to group a drug within its pharmacological class.
- Publish structured drug pricing with `schema_drug_cost` (cost, currency, price component).
- Mark up a clinical study or trial with `schema_medical_study` (study subject, status, sponsor, location).
- Describe a diagnostic test with `schema_medical_test` (used to diagnose, sign detected, normal range).
- Structure a treatment or surgical procedure with `schema_medical_procedure` (preparation, followup, procedure type, body location).
- Mark up a physician or clinician profile with `schema_physician` (medical specialty, hospital affiliation, membership).
- Describe a medical device with `schema_medical_device` (indication, contraindication, adverse outcome).
- Publish clinical guidance with `schema_medical_guideline` (evidence level, evidence origin, recommendation strength).
- Describe an anatomical structure with `schema_anatomical_structure` (body location, connected-to, sub-structure, related condition/therapy).
- Describe an organ system with `schema_anatomical_system`, or surface landmarks with `schema_superficial_anatomy`.
- Mark up the cause of a condition with `schema_medical_cause`, or its risk factors with `schema_medical_risk_factor`.
- Publish a risk calculator's basis with `schema_medical_risk_estimator`.
- Describe a biological/chemical substance with `schema_substance`.
- Turn a patient-information article into a `schema_medical_web_page` (aspect, medical audience) layered on Schema Metatag's WebPage.
- Set site-wide medical structured-data defaults in Metatag global defaults, then override per content type.
- Override the medical `@type`/fields on a single node for exceptional content.
- Drive every field from tokens so editors never touch JSON-LD directly.
- Validate the generated output against Google's Rich Results Test / Schema Markup Validator.
- Improve search presentation of health content for a hospital, clinic, pharmacy or medical publisher.
- Support a health charity's patient-education library with accurate, reviewable structured data.
- For contributors: regenerate a submodule's Tag plugins from its config schema with `drush schema_medical_entity:generate-tags --module=… --type=…`.
- Extend the set by adding a new submodule modelled on an existing one when a medical type you need is missing.
