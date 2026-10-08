# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **[Schema.org Metatag](https://www.drupal.org/project/schema_metatag)**
  module (`schema_metatag`) — the medical type submodules extend it, so it must be
  present and enabled. Schema.org Metatag in turn builds on the
  [Metatag](https://www.drupal.org/project/metatag) module.

There are no third-party PHP libraries to install.

## Install with Composer

The whole project (base module and all submodules) is installed from one Composer
package. From the project root:

```bash
composer require drupal/schema_medical_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies, including Schema.org Metatag and Metatag if they are not already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schema_medical_entity -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module, then enable **only the type submodules you actually need** —
that is the whole point of the submodule-per-type design. For example:

```bash
drush en schema_medical_entity -y
drush en schema_medical_condition schema_drug -y
```

## Submodules — enable one per Schema.org type

The project ships **18 submodules**, each providing one type from Schema.org's
medical vocabulary. Enable the ones matching the content you publish and leave the
rest off. The available types include:

| Schema.org type | Typical use |
|-----------------|-------------|
| **MedicalEntity** | Base medical type |
| **AnatomicalStructure**, **AnatomicalSystem**, **SuperficialAnatomy** | Anatomy content |
| **Drug**, **DrugClass**, **DrugCost**, **Substance** | Medication and substance pages |
| **MedicalCondition**, **MedicalCause**, **MedicalContraindication**, **MedicalIndication**, **MedicalRiskFactor**, **MedicalRiskEstimator** | Condition and risk information |
| **MedicalProcedure**, **MedicalTest**, **MedicalDevice** | Procedures, tests, devices |
| **MedicalGuideline**, **MedicalStudy**, **MedicalIntangible** | Guidelines and clinical studies |
| **Physician** | Practitioner profiles |
| **MedicalWebPage** | Medical web pages |

(The submodule machine names follow the pattern `schema_<type>`, e.g.
`schema_drug`, `schema_medical_condition`, `schema_physician`.)

## Next step

The submodules have no settings pages of their own — you configure each type's
fields inside the Metatag UI at **Configuration → Search and metadata → Metatag**.
See the [main guide](../index.md) for the step-by-step walkthrough, and have the
mappings reviewed as carefully as the clinical text.
