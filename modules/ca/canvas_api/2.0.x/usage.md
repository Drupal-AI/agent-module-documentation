Canvas API provides a single chainable Drupal service for making authenticated calls to Instructure's Canvas LMS REST API using an HTTP method, a relative path, and parameters.

---

The 2.x branch of Canvas API pares the project down to one thin wrapper around Guzzle: the `canvas_api` service. Rather than modelling every Canvas endpoint, it exposes `setMethod()`, `setPath()`, and `setParams()` builders followed by `request()`, which performs the call and returns the JSON-decoded response as a PHP array. The Canvas host is derived from the companion `canvas_lms` module's stored institution subdomain and environment (production, test, or beta), and always resolves to `https://<institution>[.test|.beta].instructure.com/api/v1/`. Authentication uses a bearer token stored through the Key module and referenced by key id in `canvas_api.settings`. GET requests are transparently paginated by following the Canvas `rel="next"` Link header (up to a 50-page fail-safe), merging pages into one array. Array parameters are re-encoded into Canvas' `foo[]=bar` style. An administrative tester form lets site administrators issue ad-hoc requests and inspect the raw result. This module is a programmatic building block: it exposes no entities, fields, blocks, or public routes beyond two admin configuration/testing screens, and it is intended to be called from your own custom code, event subscribers, queue workers, or migration plugins.

---

- Fetch all users enrolled in a course by SIS id: `\Drupal::service('canvas_api')->setMethod('GET')->setPath('courses/sis_course_id:3456/users')->request()`.
- Programmatically create a Canvas course from Drupal content by POSTing to `accounts/1/courses` with a nested `course[...]` parameter array.
- Update a Canvas user's email when a Student Information System record changes, via a PUT to `users/:id`.
- Sync enrollments from Drupal (e.g. after a commerce purchase) by POSTing to `courses/:id/enrollments`.
- List all courses in an account, relying on automatic pagination to gather every page.
- Retrieve assignments or submissions for grading dashboards built in Drupal.
- Create or update Canvas sections and terms as part of an institutional provisioning workflow.
- Delete or conclude enrollments with a DELETE request when a student drops a course.
- Pull course analytics or activity data into a Drupal reporting view.
- Look up a user by SIS login id to reconcile Drupal accounts with Canvas identities.
- Drive bulk imports by iterating Drupal records and issuing one Canvas call per record from a queue worker.
- Post announcements or discussion topics to a course from Drupal editorial workflows.
- Manage Canvas groups and group memberships tied to Drupal organic groups or roles.
- Query the Canvas `self` user or account metadata to validate that credentials and environment are configured correctly.
- Use the admin tester at `/admin/reports/canvas_api` to prototype an endpoint, method, and JSON parameter payload before writing code.
- Switch between production, test, and beta Canvas environments by changing the `canvas_lms` environment setting without touching code.
- Store the Canvas access token securely as a Key entity (environment variable, file, or config provider) rather than in plain module config.
- Build a migration source or destination plugin that reads from or writes to Canvas through the service.
- Integrate Canvas grade passback or roster sync into a scheduled cron job.
- Wrap the service in your own domain-specific helper classes for the subset of Canvas endpoints your site uses.
