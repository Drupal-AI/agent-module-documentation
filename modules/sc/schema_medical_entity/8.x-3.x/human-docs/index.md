# Schema.org Medical Entity — manual setup guide

**Schema.org Medical Entity** (`schema_medical_entity`) brings the medical branch
of Schema.org — conditions, drugs, procedures, studies, physicians, anatomical
structures, and much more — to the JSON-LD structured data your site emits through
the [Schema.org Metatag](https://www.drupal.org/project/schema_metatag) framework.
Schema.org's medical vocabulary is unusually large because health information is
unusually structured: a condition has signs, causes, risk factors, and
treatments; a drug has an active ingredient, a dosage schedule, contraindications,
and interactions; a procedure has a preparation, a followup, and a body location.
Search engines make heavy use of that structure, and health queries are among the
most carefully curated result types — so hospitals, clinics, patient-information
charities, and medical publishers get real benefit from describing content
properly rather than hoping it is understood from the prose.

The project is organised as a **base module plus 18 submodules**, one per
Schema.org type. That structure is what makes it practical: a site enables just
the types it needs — say `schema_medical_condition` and `schema_drug` — and leaves
the rest alone. The types it can produce include MedicalEntity, AnatomicalStructure
and AnatomicalSystem, Drug, DrugClass and DrugCost, LifestyleModification, the
MedicalCause / MedicalCondition / MedicalContraindication / MedicalDevice /
MedicalGuideline / MedicalIndication / MedicalIntangible / MedicalProcedure /
MedicalRiskEstimator / MedicalRiskFactor / MedicalStudy / MedicalTest /
MedicalWebPage family, Physician, Substance, and SuperficialAnatomy. Following the
standard Schema.org Metatag pattern, Schema.org Metatag owns the JSON-LD assembly
and the token replacement while each type submodule contributes its vocabulary. It
works on Drupal 9, 10, and 11.

**Two things belong in any conversation about medical structured data.** First,
**accuracy is a duty of care, not an SEO detail** — markup asserting a dosage, a
contraindication, or an indication is a machine-readable clinical claim, and a
mis-mapped field is a wrong claim published under the organisation's name. Second,
**medical content is regulated in most jurisdictions**, so what may be said about a
drug or a treatment governs the structured data exactly as it governs the visible
page; clinical review of the mapping is the same work as clinical review of the
text.

There is no settings page of this module's own — you configure each type's fields
inside the Metatag UI like any other Schema.org Metatag type.

This guide is written for a **human** setting things up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the base module with Composer
   and enable only the type submodules you need.

## How to use it

Configuration happens inside the Metatag UI, not a page of this module's own:

1. Install the project and enable the base module plus the **type submodules** for
   the Schema.org types you want (see [Installation](installation/index.md)).
2. Go to **Configuration → Search and metadata → Metatag**
   (`/admin/config/search/metatag`) and edit (or add) the metatag defaults for the
   entity type and bundle you are marking up.
3. Expand the fieldset for the relevant Schema.org type (for example
   **Schema.org: MedicalCondition** or **Schema.org: Drug**) and fill in the field
   mappings, typically using **tokens** so each page's values come from its own
   fields.
4. Save. Schema.org Metatag renders the resulting JSON-LD in the page head. Have
   the mappings reviewed with the same rigour as the clinical text itself.
