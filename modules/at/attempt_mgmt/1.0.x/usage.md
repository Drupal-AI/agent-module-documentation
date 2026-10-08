Attempt Management provides an "attempt" content entity type and a configurable field you attach to any content entity, so a site can record repeated attempts against something — a quiz, a SCORM package, an exercise — without building the data model each time.

---

Anything a user tries more than once and that records a result — an assessment, an e-learning module, a submission that can be retried — needs the same underlying shape: a per-user, per-entity record of each attempt. Attempt Management supplies that as reusable infrastructure. It defines the `attempt_mgmt_attempt` content entity (bundled by configurable **attempt types**), a field type (`attempt_mgmt_attempt_settings`) that carries per-host settings (attempt type, a 0-100 limit, force-new-attempt, grading method, display status, confirm delay, lock-after-final-attempt), and an `AttemptFactory` service with an API to create, update, count, and close attempts for both authenticated users (by uid) and anonymous visitors (by a per-session UUID). An `AttemptProcessing` annotation plugin type lets a consumer react to or validate attempts. Each attempt stores the host entity type/id, user/session, attempt number, created/changed timestamps, a computed duration, the client IP, and `temporary`/`closed` flags. Because it is a building block rather than a finished feature, what it does on a given site is defined by the attempt types you create and the module driving it — `scorm_field` is the primary consumer, using it to record SCORM completion and score data. Site-wide confirm/limit strings live at `/admin/config/system/attempt-management/settings`; attempt types are managed under `/admin/structure/attempt_mgmt_attempt_types`. Entity CRUD and type administration are gated on the `administer attempt_mgmt_attempt types` permission.

---

- Record repeated attempts against a piece of content.
- Track quiz or assessment attempts per user.
- Store SCORM attempt results (via scorm_field).
- Attach attempt tracking to any content entity through one field.
- Define attempt types as reusable bundles.
- Limit a user to a maximum number of attempts (0-100).
- Choose a grading method: best attempt or last attempt.
- Force a new attempt on each visit.
- Lock the item after the final allowed attempt.
- Show an attempt-status / confirm message to users.
- Track attempts for anonymous visitors via a session UUID.
- Count how many attempts a user has already made.
- Check programmatically whether a new attempt is allowed.
- Close a user's open attempts automatically at logout.
- Compute how long an attempt took (duration field).
- Create and update attempts from another module via AttemptFactory.
- Add an AttemptProcessing plugin to validate or react to an attempt.
- Provide the storage layer for an e-learning results model.
- List and administer attempts at /admin/content/attempt.
- Expose attempts over REST (optional config, cookie auth) for a decoupled front end.
- Reuse one attempt model across several features.
- Separate attempt storage from presentation.
- Restrict attempt-type management by permission.
- Build a course-completion or retryable-submission feature on top of it.
