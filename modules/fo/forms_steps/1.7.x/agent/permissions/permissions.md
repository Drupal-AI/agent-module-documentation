# Forms Steps permissions

| Permission | Defined in | Gates |
|---|---|---|
| `administer forms_steps` | `forms_steps.permissions.yml` | Full admin of Forms Steps: the collection UI, adding/editing/deleting workflows, steps, progress steps, and the settings form. It is the entity's `admin_permission` and the requirement on all `/admin/config/workflow/forms_steps/*` config routes. |
| `view forms_steps_workflow entity` | `forms_steps_workflow` entity | View the list of workflow **instances** at `/admin/config/workflow/forms_steps/workflows/list`. |
| `access content` (core) | core | **Requirement on the generated front-end step routes** (`<step url>/{instance_id}`). This is what lets end users — including anonymous, if they have "access content" — actually walk a wizard. Not a Forms Steps permission, but it is the access gate for the public flow. |

Notes:
- There is no finer-grained per-workflow permission; anyone with `administer forms_steps`
  administers **all** workflows.
- The public reachability of a wizard is by design: multi-step forms (applications, surveys)
  are meant to be filled in by front-end users, so the step routes use `access content`.
  Add CAPTCHA/flood/Honeypot at the site level if you expose a wizard to anonymous users.
