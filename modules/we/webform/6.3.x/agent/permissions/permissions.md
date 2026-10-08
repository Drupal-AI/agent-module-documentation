# Webform permissions

Defined in `webform.permissions.yml` (plus dynamic per-webform permissions). Grant at
`/admin/people/permissions`.

## Administration
- `administer webform` — full control of the module, all forms and settings (trusted only).
- `administer webform submission` — manage all submissions.
- `administer webform element access` — set per-element access rules.
- `administer webform overview` — reorder/manage the webforms list.
- `access webform overview` — see the admin webforms listing.
- `access webform help` — view the built-in help/videos.

## Building forms
- `create webform` — create new webforms.
- `edit any webform` / `edit own webform` — edit forms.
- `delete any webform` / `delete own webform` — delete forms.
- `edit webform source` — use the raw YAML Source editor (powerful).
- `edit webform twig` — use Twig in computed elements / markup (powerful).
- `edit webform assets` — edit per-form CSS/JS.
- `edit webform variants` — manage A/B variants.
- `access own webform configuration` / `access any webform configuration` — reach form settings.

## Submissions
- `view any webform submission` / `view own webform submission`
- `edit any webform submission` / `edit own webform submission`
- `delete any webform submission` / `delete own webform submission`
- `access webform submission user` — a user sees their own submissions list.

Finer, per-form access (create/view/update/delete/purge, plus custom rules) is configured on each
webform's **Access** tab and evaluated by `webform.access_rules_manager`; the `webform_access`
submodule adds group-based access for webform nodes.
