<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node delete redirect — settings, config & mechanism

## Install & enable

```bash
composer require drupal/node_delete_redirect
drush en node_delete_redirect -y
```

Only dependency is core **`node`**. No sub-modules. No permissions of its own — the settings
form is gated by core's **`administer content types`** permission.

## The settings form

- Class: `Drupal\node_delete_redirect\Form\NodeDeleteRedirectConfigForm` (extends
  `ConfigFormBase`). Form id / route id: **`node_delete_redirect.admin_settings_form`**.
- Route: path **`admin/config/content/node-delete-settings`**, requirement
  `_permission: 'administer content types'` (`node_delete_redirect.routing.yml`).
- Menu: *Configuration → Content authoring → Node delete redirect*
  (`node_delete_redirect.links.menu.yml`, parent `system.admin_config_content`).
- `create()` injects `config.factory`, `config.typed`, and the **`node_type`** entity storage
  (`entity_type.manager->getStorage('node_type')`), so the form lists every content type.

Form elements (`buildForm()`):

| Element | Type | Meaning |
|---|---|---|
| `ndr_check` | radios (0 Disable / 1 Enable), **required** | Master switch. When 0, no redirect rules apply. |
| `ndr_settings[<type>][is_enabled]` | checkbox | Enable redirect for that content type. Bundle label escaped with `Html::escape`. |
| `ndr_settings[<type>][redirect]` | textfield (maxlength 128) | The redirect path, e.g. `/node`. `#element_validate` = the path-validate service. |
| `ndr_lang` | checkbox | Alpha "language support": prefix redirect with current language code. |

The per-type redirect field only shows (`#states` visible) when that bundle's checkbox is checked,
and the whole `ndr_settings` fieldset only shows when `ndr_check` = 1.

Note: `$form['#validate']` is set to `NodeDeleteRedirectConfigFormValidate::validate`, which is a
**no-op stub** (`@todo add form validation`) — real validation lives in the element validator below.

## Config object & schema

Saved to config object **`node_delete_redirect.admin_settings_form`** under one key
`ndr_admin_form_settings` (schema `config/schema/node_delete_redirect.schema.yml`):

```yaml
ndr_admin_form_settings:
  ndr_check: integer          # 0/1 master switch
  ndr_settings:               # sequence keyed by content-type machine name, orderby key
    <type>:
      is_enabled: boolean
      redirect: string        # internal path, e.g. /node
  ndr_lang: boolean           # language-aware redirect
```

`submitForm()` rebuilds a clean structure: it only stores `ndr_settings` entries for bundles whose
`is_enabled` is truthy (and only when `ndr_check` is on), casting `is_enabled` to bool and keeping
`redirect` as-is. This avoids persisting form metadata for disabled types.

Example config export:

```yaml
# node_delete_redirect.admin_settings_form.yml
ndr_admin_form_settings:
  ndr_check: 1
  ndr_lang: 0
  ndr_settings:
    article:
      is_enabled: true
      redirect: /admin/content
    page:
      is_enabled: true
      redirect: /node
```

`hook_uninstall()` (`node_delete_redirect.install`) deletes this config object.

## Path validation (save time)

`Drupal\node_delete_redirect\Validate\NodeDeleteRedirectElemPathValidate::validate()`
(service `node_delete_redirect.elem_path_validate`, constructed with `@path.validator`) runs as the
redirect field's `#element_validate`. For an enabled bundle it rejects the value unless it:

1. is non-empty ("The path should not be empty.");
2. is not an array;
3. starts with a leading slash `/` ("Path must start with leading slash.");
4. does not start with `<` — blocks `<front>`/token-style values ("Tokens not allowed.");
5. resolves through core's `PathValidatorInterface::getUrlIfValid($value)` — i.e. it must be a
   valid internal path the current user can access, else "The path %value is either invalid, or you
   do not have access to it."

So only reachable **internal** paths are ever stored; there is no free-text/external URL surface.

## Delete-time redirect mechanism

In `node_delete_redirect.module`:

- `node_delete_redirect_form_alter($form, $form_state, $form_id)` — reads
  `ndr_admin_form_settings`; if `ndr_check` is set, it loops the per-type `ndr_settings`, and for a
  bundle with `is_enabled` whose form id equals `node_{type}_delete_form` it sets
  `$form['#attributes']['node_delete_redirect_to'] = $values['redirect']` and appends
  `node_delete_redirect_form_submit` to `$form['actions']['submit']['#submit']`.
- `node_delete_redirect_form_submit($form, $form_state)` — takes the stashed path; if `ndr_lang` is
  on **and** the current language differs from the default, it becomes
  `'/' . $current_lang . $path`. It then guarantees a leading `/`, `?`, or `#` (prepending `/` if
  absent) and calls `$form_state->setRedirectUrl(Url::fromUserInput($redirect_to))`.
  `Url::fromUserInput` only accepts internal user-input paths, so the redirect cannot leave the site.

## How to operate it

1. Grant an editor role the core **`administer content types`** permission (`/admin/people/permissions`).
2. Go to **`/admin/config/content/node-delete-settings`**, set *Node Delete Redirect* to **Enable**.
3. Check the content types you want, and enter an internal redirect path (e.g. `/admin/content`)
   for each; save (invalid/inaccessible paths are rejected).
4. Optionally tick *Enable language support (alpha)* for language-prefixed redirects.
5. Test by deleting a node of an enabled bundle — you land on the configured path instead of the
   front page.

## Notes / caveats

- `ndr_lang` is labeled **alpha**; it simply prepends the current language code and does not
  consult path aliases per language.
- Redirect targets are admin-configured and validated as internal paths — not derived from request
  input — so this is not an open-redirect vector.
- The `NodeDeleteRedirectConfigFormValidate` form-level validator is an intentional empty stub;
  all real validation is per-element.
- Uninstalling removes `node_delete_redirect.admin_settings_form` entirely.
