<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Term level field adds a single field type that stores a taxonomy term reference together with a numeric level in one field item, so a tag can carry a degree as well as a subject.

---

The pattern shows up wherever a tag is not a yes-or-no. A person's skills are not a list of technologies but a list of technologies with proficiencies — "PHP, advanced; French, conversational; project management, intermediate". Prerequisites have required levels, certifications have grades, job requirements have minimums. Modelling that with a plain term reference throws away the half people actually search on. term_level solves it with one field item that holds both the term (`target_id`, always a `taxonomy_term`) and an integer `level`. The allowed levels are defined per field in the storage settings as newline-separated `numeric-key|label` lines (e.g. `1|Beginner`), so the scale is a controlled, ordered list shared across every value of that field. The module ships three plugins that all extend core equivalents: the field type `term_level` (extends `EntityReferenceItem`), the widget `term_level_widget` (extends the entity-reference autocomplete widget, adding a Level `<select>`), and the formatter `term_level_formatter` (extends the entity-reference label formatter, appending ` : <level label>` after the term). It depends only on core `taxonomy`. Version **8.x-1.x** on `^9.1 || ^10 || ^11`. Two things worth remembering: because the level list is keyed by number, the scale is orderable and comparison queries like "at least intermediate" are meaningful; and self-assessed levels are self-assessed — a skills directory built on them records what people say about themselves, not a verified qualification record, so anything consequential needs a separate notion of who assessed the level and when.

---

- Record employee skills with proficiency levels.
- Store spoken languages with a fluency level.
- Model course prerequisites with a required level.
- Record professional certifications with grades.
- Build a searchable staff skills directory.
- Store competencies with numeric ratings.
- Model job requirements with minimum levels.
- Record training completion levels per subject.
- Find people fluent in a given language.
- Store subject expertise with a depth level.
- Model supplier accreditation levels.
- Record volunteer skill levels for matching.
- Build a staff expertise register on a user entity.
- Store technology proficiencies on a profile.
- Model membership grades by category.
- Record musical-instrument proficiency.
- Build a mentor/mentee matching dataset.
- Store qualification levels keyed by subject term.
- Attach a difficulty level to tagged content.
- Include the level value in HAL+JSON exports when the hal module is enabled.
