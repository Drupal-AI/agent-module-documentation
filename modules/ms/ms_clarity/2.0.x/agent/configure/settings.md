# Microsoft Clarity — configuration

## Settings form
- Route `ms_clarity.admin_settings_form`, path `/admin/config/services/microsoft_clarity`, `_permission: administer microsoft clarity`.
- Form `\Drupal\ms_clarity\Form\MicrosoftClarityAdminSettingsForm` (extends `ConfigFormBase`, edits `ms_clarity.settings`).
- **Clarity ID** — required textfield, max length 20; element-validated by `mstagElementValidate` to match `^[a-zA-Z0-9]+$` (rejects anything non-alphanumeric).
- **Tracking Options** vertical tabs:
  - *Pages* — radios `request_path_mode` (0 = "every page except the listed pages", 1 = "the listed pages only") + textarea of paths (one per line, `*` wildcard, `<front>`). Paths must start with `/` (validated) unless `<front>`.
  - *Roles* — radios `user_role_mode` (0 = "add to the selected roles only", 1 = "add to every role except the selected ones") + role checkboxes.
- Note: form field `request_path_mode == 2` is a legacy "PHP snippet" mode that only locks the stored value and is not selectable in the UI.

## Config object `ms_clarity.settings`
```yaml
account: 'abcd1234'            # Clarity project ID
visibility:
  request_path_mode: 0        # 0 = all except listed, 1 = only listed
  request_path_pages: "/admin\n/admin/*\n/user/*"
  user_role_mode: 0           # 0 = only selected roles, 1 = all except selected
  user_role_roles:            # role machine names (sequence)
    anonymous: anonymous
```
Schema: `config/schema/ms_clarity.schema.yml`.

Set the ID via Drush:
```
drush config:set ms_clarity.settings account YOURID -y
```

## How the tag is emitted (`ms_clarity_page_attachments`)
1. `ms_clarity.accounts`→`getProjectId()` returns `account` (empty string if unset).
2. `ms_clarity.visibility`→`getVisibilityPages()` — matches current path (lowercased alias and internal path) against `request_path_pages` per `request_path_mode`; empty list ⇒ all pages.
3. `ms_clarity.visibility`→`getUserVisibilty($account)` — `getVisibilityRoles()` checks the current user's roles against `user_role_roles`/`user_role_mode`; no roles selected ⇒ everyone tracked.
4. If project ID is truthy AND both visibility checks pass, a `script` head element (`#theme => script_head`, `#id => <project-id>`) is added to `html_head`, loading `https://www.clarity.ms/tag/<id>` asynchronously.

If any check fails, no script is attached.
