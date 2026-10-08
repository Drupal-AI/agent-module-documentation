<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LMS access model

Access is layered: **route access** (mostly Group operations) + **entity access handlers** +
**field access hooks**. Enrolment = group membership; the gate to take a course is the
`take course` Group permission.

## Routes and their gates (`lms.routing.yml`)
- `lms.course.start` `/course/{group}/start` — `_entity_access: group.take`.
- `lms.group.answer_form` `course/{group}/{lesson_delta}/{activity_delta}` — `_entity_access: group.take`.
  The take-lesson/take-activity route. Gate is enrolment, not the activity id.
- `lms.course.reset_test` `/course/{group}/reset-test` — `_entity_access: group.update` + `_csrf_token`.
  Editor-only "reset my test progress".
- `lms.group.results` `group/{group}/course-results/{user}` — `_entity_access: group.results`
  (admin route; intended for graders).
- `lms.group.self_results` `group/{group}/course-results` — `_entity_access: group.results`
  (own results; `{user}` defaults to current user).
- `lms.answer.details` / `entity.lms_answer.edit_form` `answer/{lms_answer}/…` —
  `_entity_access: lms_answer.see_details`.
- `lms.modal_subform_endpoint` `lms/modal-reference-form` (POST) — `_user_is_logged_in: TRUE`;
  the invoked `modal_subform` plugin re-checks entity create/update access (`EntityForm::access`).
- Admin/settings routes — `administer lms` / `access administration pages`.

## Custom Group operations → permissions (`LmsEntityHooks::groupAccess`, `hook_group_access`)
Only fires for `CourseInterface` groups:
- **`take`** → `Course::takeAccess()` → requires `take course` group permission (published course).
  For unpublished courses it additionally honours `view any/own unpublished group`.
- **`results`** → returns `takeAccess()` if allowed, else falls back to `grade students`. This
  operation gates the course-results pages (a learner's own results and the grader views).

## Entity access handlers
- Editable entities (`lms_lesson`, `lms_activity`) — `LmsEntityAccessControlHandlerBase`:
  owner with the `create … entities` permission, or anyone with `edit … entities` / `administer lms`.
  Field-level: `uid`/`created`/`changed`/`revision_log` need `administer lms`; revision timestamp/uid
  are read-only. **Canonical view of an activity is therefore restricted to editors** — students
  never see the raw activity (with its correct-answer fields), only the answering form.
- `lms_answer` — `AnswerAccessControlHandler`: operation `see_details` allowed if the answer is the
  current user's **or** the account has `grade students` on the course; create is always forbidden
  (answers are created only by the answer-form flow). The evaluation form embedded on the answer-
  details page is built only when the viewer has `grade students`.
- `lms_reference` edit access on the course/lesson forms is gated by
  `create|use all|edit` permissions on the target entity type (`lmsReferenceFieldEditAccess`,
  applied via `hook_entity_field_access`).

## Query access
`hook_query_TAG_alter` on `lms_activity_access` and `lms_lesson_access` tags lets listing queries
respect the same permission model (`LmsQueryHooks`).

## Views access
`Drupal\lms\Plugin\views\access\CoursePermission` gates listing views by a Group permission.

## lms_classes submodule
Adds class-scoped access (`LmsCustomAccess`, `ClassPermissionCalculator`) — e.g. "add student"
requires the `administer members` group permission on the class; it composes with, and does not
bypass, the core Group permission model.
