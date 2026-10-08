<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodules (18) — one Schema.org medical type each

Every submodule depends on `schema_metatag:schema_metatag` + `schema_medical_entity`, ships a
`@MetatagGroup` and generated `@MetatagTag` plugins (each `<Type>Type` tag is the required
`@type` selector), and adds **no** hooks, permissions, routes or config entities of its own.
Enable only the types the site publishes. Each type carries the shared MedicalEntity/Thing
properties too; the properties below are the type-specific fields.

| Submodule | Schema.org type | Type-specific properties |
|---|---|---|
| `schema_anatomical_structure` | AnatomicalStructure | associatedPathophysiology, bodyLocation, connectedTo, diagram, function, partOfSystem, relatedCondition, relatedTherapy, subStructure |
| `schema_anatomical_system` | AnatomicalSystem | associatedPathophysiology, comprisedOf, relatedCondition, relatedStructure, relatedTherapy |
| `schema_drug` | Drug | activeIngredient, administrationRoute, alcoholWarning, availableStrength, breastfeedingWarning, clinicalPharmacology, dosageForm, doseSchedule, drugClass, drugUnit, foodWarning, includedInHealthInsurancePlan, interactingDrug, isAvailableGenerically, isProprietary, labelDetails, legalStatus, manufacturer, maximumIntake, mechanismOfAction, nonProprietaryName, overdosage, pregnancyCategory, pregnancyWarning, prescribingInfo, prescriptionStatus, proprietaryName, relatedDrug, rxcui, warning |
| `schema_drug_class` | DrugClass | drug |
| `schema_drug_cost` | DrugCost | applicableLocation, costCategory, costCurrency, costOrigin, costPerUnit, drugUnit |
| `schema_medical_cause` | MedicalCause | causeOf |
| `schema_medical_condition` | MedicalCondition | associatedAnatomy, cause, differentialDiagnosis, drug, epidemiology, expectedPrognosis, naturalProgression, pathophysiology, possibleComplication, possibleTreatment, primaryPrevention, riskFactor, secondaryPrevention, signOrSymptom, stage, status, subtype, typicalTest |
| `schema_medical_device` | MedicalDevice | adverseOutcome, contraindication, indication, postOp, preOp, procedure, purpose, seriousAdverseOutcome |
| `schema_medical_guideline` | MedicalGuideline | evidenceLevel, evidenceOrigin, guidelineDate, guidelineSubject |
| `schema_medical_procedure` | MedicalProcedure | bodyLocation, followup, howPerformed, indication, outcome, preparation, procedureType, status |
| `schema_medical_risk_estimator` | MedicalRiskEstimator | estimatesRiskOf, includedRiskFactor |
| `schema_medical_risk_factor` | MedicalRiskFactor | increasesRiskOf |
| `schema_medical_study` | MedicalStudy | healthCondition, outcome, population, sponsor, status, studyLocation, studySubject |
| `schema_medical_test` | MedicalTest | affectedBy, normalRange, signDetected, usedToDiagnose, usesDevice |
| `schema_medical_web_page` | MedicalWebPage | medicalAudience (also depends on `schema_metatag:schema_web_page`) |
| `schema_physician` | Physician | name, description, image, url, medicalSpecialty, hospitalAffiliation, memberOf |
| `schema_substance` | Substance | activeIngredient, maximumIntake |
| `schema_superficial_anatomy` | SuperficialAnatomy | associatedPathophysiology, relatedAnatomy, relatedCondition, relatedTherapy, significance |

## Notes
- **`schema_medical_web_page`** additionally depends on `schema_metatag:schema_web_page` — it
  layers a medical audience/aspect onto Schema Metatag's WebPage type.
- **`schema_physician`** uses the base module's shared `hospital_affiliation` and `member_of`
  PropertyType plugins; it ships its own `config/schema/schema_physician.metatag_tag.schema.yml`.
- Types listed in the README/`@type` tree but **without a dedicated submodule**
  (LifestyleModification, MedicalContraindication, MedicalIndication, MedicalIntangible) are
  selectable as `@type` values on the base **MedicalEntity** group rather than shipping as
  separate modules.
- Submodule Tag plugin classes are generated from each module's `config/schema/*.yml` via the
  base module's Drush command — see [../metatags/mechanism.md](../metatags/mechanism.md).
