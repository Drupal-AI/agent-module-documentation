<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Metatag group: Schema.org EducationalOccupationalProgram

**Group plugin id:** `schema_educational_occupational_program`
(class `SchemaEducationalOccupationalProgram extends SchemaGroupBase`).
Maps to Schema.org type <https://schema.org/EducationalOccupationalProgram>; group description
also links Google's job-training data-type docs.

Each tag below is a `@MetatagTag` plugin extending `schema_metatag`'s `SchemaNameBase`, with no
custom PHP. `property_type` controls how Schema Metatag shapes the JSON-LD value; `multiple`
marks properties that accept a list. Tag plugin ids are prefixed
`schema_educational_occupational_program_` + the snake_case of the property.

| Property (`name`) | property_type | multiple | Google note (from description) |
|---|---|---|---|
| `@type` | type | no | REQUIRED. Fixed to `EducationalOccupationalProgram`. |
| `name` | text | no | REQUIRED BY GOOGLE. Name of the program. |
| `provider` | organization | no | REQUIRED BY GOOGLE. Providing educational organization. |
| `offers` | offer | no | REQUIRED BY GOOGLE. Estimated cost of the program. |
| `description` | text | no | The program description. |
| `url` | url | no | Canonical URL of the program. |
| `identifier` | text | no | Program identifier. |
| `applicationDeadline` | date | no | Application deadline. |
| `applicationStartDate` | date | no | When applications open. |
| `startDate` | date | no | RECOMMENDED BY GOOGLE. ISO-8601. |
| `endDate` | date | no | End date. |
| `dayOfWeek` | text | **yes** | RECOMMENDED BY GOOGLE. Days the program runs. |
| `timeOfDay` | text | no | Time of day. |
| `educationalProgramMode` | text | no | Mode of study (e.g. full-time/part-time). |
| `educationalCredentialAwarded` | creative_work | no | Credential awarded on completion. |
| `occupationalCredentialAwarded` | creative_work | no | Occupational credential awarded. |
| `occupationalCategory` | text | **yes** | Occupational category (e.g. O*NET-SOC / BLS). |
| `programType` | text | no | Type of educational program. |
| `programPrerequisites` | creative_work | no | Admission prerequisites. |
| `financialAidEligible` | text | no | Financial aid eligibility. |
| `maximumEnrollment` | text | no | Maximum enrolment. |
| `numberOfCredits` | text | no | RECOMMENDED BY GOOGLE. Credits to complete. |
| `typicalCreditsPerTerm` | text | no | Typical credits per term. |
| `termsPerYear` | text | no | Terms per year. |
| `termDuration` | duration | no | Length of a single term (ISO-8601 duration). |
| `timeToComplete` | duration | no | Time to complete the program (ISO-8601 duration). |
| `salaryUponCompletion` | monetary_amount | no | Expected salary upon completion. |
| `trainingSalary` | monetary_amount | no | Salary paid during training. |

(28 tags total. Property list mirrors Schema.org's `EducationalOccupationalProgram`.)

## Notes for agents
- Object-valued properties (`offers` → `Offer`, `provider` → `Organization`/`Person`,
  `*Credential*` / `programPrerequisites` → `CreativeWork`, `*Salary*` → `MonetaryAmount`)
  render as nested JSON-LD objects; the per-property `tree_parent` in the plugin annotation
  seeds the allowed child `@type` in Schema Metatag's form.
- `date` and `duration` values are expected in ISO-8601 (dates; durations like `P4Y`, `P16W`).
- Values are entered as literals or Metatag tokens in the Metatag defaults form; Schema Metatag
  performs the token replacement and JSON-LD assembly. This module adds no tokens of its own.
- To also describe the awarded credential as its own top-level entity, pair with the sibling
  `schema_educational_occupational_credential` module.
