<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Schema.org MedicalEntity (schema_medical_entity) — agent index

Adds the **medical branch of Schema.org** to **Schema.org Metatag** (`schema_metatag`)'s
JSON-LD output. The base module contributes the `MedicalEntity` type and its shared
properties; **18 submodules** each add one top-level medical type. Version **8.x-3.1**,
core `^9 || ^10 || ^11`, package SEO, GPL-2.0-or-later. ~169 reported installs.

## What it actually is
A **pure add-on to `schema_metatag` (>=3.0)** — it owns no JSON-LD assembly, no override
system and no admin UI of its own. Schema Metatag (built on core Metatag) does all of that.
This project only registers **Metatag Group + Tag plugins** (and a couple of shared
`schema_metatag` PropertyType plugins) so that medical `@type` values and their fields show
up inside the normal Metatag configuration forms — global defaults, per bundle, or per node —
where you hard-code values or use tokens like any other Schema Metatag type.

- **No permissions**, **no routes**, **no config entities**, **no services** beyond one Drush command.
- **No hooks** — the three `.module` files are empty stubs.
- Config lives entirely in Metatag; this module only ships `config/schema/*.yml` (metadata typing).

## Base module (`schema_medical_entity`)
- **Group plugin** `schema_medical_entity` → "Schema.org: MedicalEntity".
- **Tag plugins** for MedicalEntity + inherited Thing properties: `@type` (a select of the
  medical type tree — MedicalEntity, AnatomicalStructure, AnatomicalSystem,
  LifestyleModification, MedicalCause, MedicalCondition, MedicalContraindication,
  MedicalDevice, MedicalGuideline, MedicalIndication, MedicalIntangible, MedicalProcedure,
  MedicalRiskEstimator, MedicalRiskFactor, MedicalStudy, MedicalTest, Substance,
  SuperficialAnatomy), `code`, `guideline`, `legalStatus`, `medicineSystem`,
  `recognizingAuthority`, `relevantSpecialty`, `study`, plus `name`, `description`,
  `alternateName`, `disambiguatingDescription`, `identifier`, `image`, `url`, `sameAs`,
  `subjectOf`, `mainEntityOfPage`, `potentialAction`.
- **Base/Trait** classes reused by submodules: `SchemaMedicalEntityBase`,
  `SchemaMedicalCodeBase`, `SchemaMedicalGuidelineBase`, `SchemaMedicalSpecialtyBase`,
  `SchemaMedicalStudyBase`, `SchemaMedicineSystemBase`, `SchemaSupersededByBase` (+ traits).
- **PropertyType plugins** (shared): `hospital_affiliation`, `member_of`.
- **Drush command** `schema_medical_entity:generate-tags` (alias `schema-medical-entity-generate-tags`):
  a developer scaffolder that generates Tag plugin classes from a submodule's config schema.
  Not an end-user command — see [metatags/mechanism.md](metatags/mechanism.md).

## Submodules (18 — one Schema.org type each)
Each depends on `schema_metatag` + `schema_medical_entity`, ships a Group plugin and generated
Tag plugins. Enable only what you need. Full list + property highlights:
[submodules/list.md](submodules/list.md).

## Where to read next
- **How the mechanism works / config-free integration / the Drush scaffolder** →
  [metatags/mechanism.md](metatags/mechanism.md)
- **The 18 submodules and what each adds** → [submodules/list.md](submodules/list.md)
- **Metadata** → `../data.json` · **Usage & use cases** → `../usage.md`

## Caveats specific to medical structured data
1. **Accuracy is a duty of care, not an SEO detail.** Markup asserting a dosage,
   contraindication or indication is a machine-readable clinical claim; a mis-mapped field is
   a wrong claim published under the organisation's name.
2. **Medical content is regulated.** What may be said about a drug or treatment governs the
   structured data exactly as it governs the page — clinical review of the mapping is the same
   work as clinical review of the text.
