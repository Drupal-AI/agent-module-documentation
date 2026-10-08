# Configure (settings) — State keys, forms, match logic

There is **no module settings form and no config entity**. Everything is stored in the **State** API
(`\Drupal::state()`), and edited via `hook_form_alter` additions to the **Domain** module's own forms.
Nothing is exported to config, so these values are per-environment (not captured by
`drush config:export`).

## Where you set it (admin UI)

| Setting | Form altered | Route / path | Saved by |
|---|---|---|---|
| Global on/off + auto-assign domain | `domain_settings` | `/admin/config/domain/settings` | `_domain_login_restrict_config_submit` (`domain_login_restrict.module:212`) |
| Per-domain allowed roles + auto-assign roles | `domain_edit_form` (edit mode only) | `/admin/config/domain/edit/<domainId>` | `_domain_login_restrict_config_role_submit` (`:225`) |

The `domain_settings` fieldset is titled *Domain User: Login restrict*; the `domain_edit_form` fieldset
is *Domain User: Login restrict using Role* and only appears when editing an existing domain
(`isset($currentDomain)` guard at `:157`).

## State keys (exact)

| Key | Type | Meaning | Written at |
|---|---|---|---|
| `domain_login_restrict_enabled` | bool | Master switch. When falsy, **the check is a no-op** — no restriction at all. | `:213` |
| `domain_login_restrict_assign_domain` | bool | On `hook_user_insert`, add the current domain id to the new user's `field_domain_access`. | `:214` |
| `domain_login_restrict_role_<domainId>` | array (role id ⇒ role id / 0) | Roles allowed to log in on that domain. Empty/all-unchecked ⇒ role check skipped for that domain. | `:227` |
| `domain_login_restrict_assign_role_<domainId>` | array (role id ⇒ role id / 0) | Roles auto-granted to a new user created on that domain (`hook_user_insert`). | `:228` |

`<domainId>` is the Domain config-entity machine id (`$domain->id()`), from
`\Drupal::routeMatch()->getParameter('domain')` on the edit form and from
`domain.negotiator->getActiveDomain()->id()` at runtime.

Set them from code:

```php
\Drupal::state()->set('domain_login_restrict_enabled', TRUE);
\Drupal::state()->set('domain_login_restrict_assign_domain', TRUE);
// Allow only the 'editor' and 'staff' roles to log in on domain 'example_com':
\Drupal::state()->set('domain_login_restrict_role_example_com', ['editor' => 'editor', 'staff' => 'staff']);
```

## How the check runs (`_domain_login_restrict_check`, `:334`)

Entry points that call it:

- **Interactive login**: `hook_form_alter` (`:85`) `array_unshift`-es `_domain_login_restrict_validate`
  onto `#validate` of `user_login`, `user_login_block`, `user_login_form`, so it runs **first**, before
  core's authentication validators. A `$form_state->setErrorByName('name', …)` stops the submit, so no
  session is created on the interactive path.
- **Password-reset request**: `_domain_login_restrict_reset_password_validate` (`:239`) on the
  `user_pass` form — blocks requesting a reset mail when the account is not affiliated with the active
  domain.
- **API login**: `hook_user_login` (`:410`) calls the check only when
  `$request->getPreferredFormat()` is `api_json` or `json`; on failure it emits
  `new JsonResponse([...], 403)->send(); exit;`.

The comparison itself:

1. Load the account by the submitted `name`, falling back to `mail`
   (`_domain_login_restrict_user_lookup`, `:295`; for a mail shared across domains it prefers the user
   whose `field_domain_access` contains the active domain).
2. If the account has `login to any domain`, **return immediately** (full bypass).
3. Build `$userDomainList` from the account's `field_domain_access` target ids.
4. Get the active domain id from `domain.negotiator->getActiveDomain()`.
5. **Domain check** — strict membership: fail if `!in_array($currentDomain->id(), $userDomainList)`.
   (An account with an empty `field_domain_access` therefore fails on every domain — fail-closed.)
6. **Role check** — only if `domain_login_restrict_role_<domainId>` is non-empty after `array_filter`:
   fail if `empty(array_intersect($domainWiseRoleSettings, $user->getRoles()))`.
7. On failure: set a form error (interactive/reset) or send a 403 JSON response (API), and log an
   error on the `domain_login_restrict` channel with the user and hostname.

The error message is deliberately generic — *"%name is not recognized as a username or email to this
site."* — the same wording for a wrong domain and a wrong role.

## Auto-assignment on user creation (`hook_user_insert`, `:36`)

Independent of the login gate: when `domain_login_restrict_assign_domain` is on, a newly inserted user
is given the current domain id in `field_domain_access` (appended if the field already had values).
When `domain_login_restrict_assign_role_<currentDomainId>` lists roles, those roles are added to the
new account. The user is re-saved only if either applied.
