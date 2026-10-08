<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Quiz Maker — agent index

Create **quizzes/assessments** (question types, scoring, results). Built on `entity_reference_revisions`,
`inline_entity_form`, `field_group`, `views_bulk_operations`, `entity_browser`, `entity`, `editor`.
`quiz_maker_export` submodule. Provides permissions. Version **1.1.0**. Core `^9||^10||^11`.

**Privacy:** responses/scores are user data — gate result access (respondents shouldn't see others'
answers; exports contain PII). Verify take/view permissions.
