<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Schema.org Education is a vocabulary add-on for Schema Metatag. It registers the `EducationalOccupationalProgram` Schema.org type as a metatag group with 28 properties, so a school, college or training provider can describe its degree, vocational or apprenticeship programmes in the JSON-LD structured data that search engines read.

---

The module contains no runtime logic of its own — the `.module` file is empty and there are no routes, controllers, forms, services or hooks. Its entire contribution is Metatag plugin definitions: one `@MetatagGroup` plugin (`SchemaEducationalOccupationalProgram`, id `schema_educational_occupational_program`) extending schema_metatag's `SchemaGroupBase`, and 28 `@MetatagTag` plugins under `src/Plugin/metatag/Tag/`, each a thin subclass of `SchemaNameBase` carrying only annotation metadata (name, group, weight, `property_type`, `tree_parent`, `multiple`). Schema Metatag does all the real work: it discovers these plugins, renders the per-bundle configuration form under Metatag defaults, performs token replacement on the values an admin enters, assembles the nested JSON-LD object, and — critically for security — owns the escaping and serialization of that output. The `property_type` on each tag tells Schema Metatag how to shape the value: plain `text`, `date`, `url`, `duration`, `type`, or a nested object such as `offer` (offers), `organization` (provider), `monetary_amount` (salaryUponCompletion, trainingSalary) and `creative_work` (educationalCredentialAwarded, occupationalCredentialAwarded, programPrerequisites). The `@type` tag is fixed to `EducationalOccupationalProgram`. Installed version is **1.0.1** on `^9 || ^10 || ^11`; the declared `php: 7.2.0` is stale floor metadata, harmless on a Drupal 11 site. There is no configuration UI of the module's own — everything happens inside the standard Metatag defaults screens at `/admin/config/search/metatag`. The value is entirely in the mapping: each property must be pointed at the field (or token) that genuinely holds it, because a programme marked up with the wrong credential or a stale start date is worse for SEO than one with no markup at all.

---

- Mark up a university degree programme for search engines.
- Describe a vocational or occupational training programme in JSON-LD.
- Add `EducationalOccupationalProgram` structured data to a college site.
- Show programme duration (`timeToComplete`, `termDuration`) in rich results.
- Publish the credential awarded on completion (`educationalCredentialAwarded`).
- Describe an apprenticeship's occupational category and training salary.
- Add start dates and application deadlines to a course listing's markup.
- Map programme fields on a content type to Schema.org properties.
- Expose the estimated cost of a programme via the nested `offers` object.
- Attribute a programme to its providing organization (`provider`).
- Describe admission prerequisites (`programPrerequisites`).
- State the number of credits and typical credits per term.
- Flag whether a programme is financial-aid eligible.
- Publish maximum enrolment and terms per year for a programme.
- Describe the salary a graduate can expect (`salaryUponCompletion`).
- Support a programme-finder or prospectus site's SEO.
- Add semantic metadata to satisfy an SEO agency's rich-result requirement.
- Standardise how education programmes are described across a multisite.
- Describe the mode of study (`educationalProgramMode`, e.g. full-time/part-time).
- List which days of the week (`dayOfWeek`) and time of day a programme runs.
- Provide a canonical `url` and `identifier` for each programme entity.
- Complement other schema_metatag type add-ons (course, credential) on the same page.
- Improve rich-result eligibility for job-training programmes per Google's guidance.
