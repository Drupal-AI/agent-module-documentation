<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LMS content model

## Entity graph
```
group (bundle: lms_course)          <- the course (bundle class Course)
  └─ lessons (lms_reference)         ordered, per-item: max_score, required_score, mandatory
       → lms_lesson
            └─ activities (lms_reference)  ordered, per-item: max_score
                 → lms_activity  (bundle = lms_activity_type config entity)

Per-learner (derived, created as the student progresses):
lms_course_status  (uid, course, started, finished, status, score, current_lesson_status, last_activity_ts)
  └─ lms_lesson_status  (course_status, lesson, activities, given_answers, score/percent, required_score, mandatory, evaluated, finished)
       └─ lms_answer  (user_id, activity, lesson_status, data, score, evaluated)
```

## Course (`group` / `lms_course`)
- Not a separate entity type — a **Group bundle**. `hook_entity_bundle_info_alter` sets the bundle
  class to `Drupal\lms\Entity\Bundle\Course` (implements `CourseInterface`).
- Course-specific fields are added both on the bundle class (`bundleFieldDefinitions`) and globally
  on `group` (`LmsEntityHooks::entityBaseFieldInfo`, to avoid storage mismatches): `lessons`
  (`lms_reference`, revisionable, unlimited), `revisit_mode` (bool), `free_navigation` (bool),
  `start_link` (computed string, `StartLinkFieldItemList`).
- Config: `group.type.lms_course`, a `group_membership` relationship, and default form/view
  displays ship in `config/install`.

## Lesson (`lms_lesson`)
- Content entity, revisionable. Single default bundle `lesson`. References `activities`
  (`lms_reference`). Settings: randomization (0 none / 1 shuffle / 2 random subset), backwards
  navigation, close time (timer). Access handler `LessonAccessControlHandler`.

## Activity (`lms_activity`) + Activity type (`lms_activity_type`)
- `lms_activity_type` is a **config entity** (the "bundle") that stores which `activity_answer`
  plugin scores this type and its plugin configuration; installing a type can install extra fields
  via the plugin's `install()`.
- `lms_activity` is the content entity. Its fields hold presentation **and** correct-answer data.
  Access handler `ActivityAccessControlHandler` (canonical view restricted to editors/admins — see
  `access/access-model.md`).

## `lms_reference` field type
Custom entity-reference field (`Drupal\lms\Plugin\Field\FieldType\LMSReferenceItem`) that also
carries per-reference data used by the engine: `getMaxScore()`, `getRequiredScore()`,
`isMandatory()`. Widget `lms_reference_table` (an editable table) drives the course→lessons and
lesson→activities editing UX, backed by the `modal_subform` AJAX endpoint. A revision-aware variant
`RevisionReferenceItem` (`lms_revision_reference`) exists too.

## Status entities (derived progress — do not trust client to set)
- `lms_course_status`: one per learner attempt. Statuses: `new`, `in progress`, `passed`,
  `failed`, `evaluation` (needs grading), `expired`. Weighted `score`.
- `lms_lesson_status`: snapshot of the activities the learner actually faces this attempt (matters
  with randomization), their given-answer count, percentage score, evaluated/finished flags.
- Neither has a canonical view route; they are read through `CourseController::results` and Views.
- Deletion cascades via queue workers: deleting a course/user queues its statuses; deleting a
  course status queues lesson statuses; deleting a lesson status queues answers
  (`DeleteEntitiesWorker`, `lms_delete_entities` queue).
