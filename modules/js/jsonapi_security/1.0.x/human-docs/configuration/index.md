# Configuration

JSON:API Security is configured through its global policy settings plus a couple
of `settings.php` flags for the super-user protections. The guiding principle is
"secure by default": start with the strict global policy and open up only the
specific resources you need, using the exception lists.

## Open the settings form

Log in as a user with the **Administer site configuration** permission (an
administrator by default) and open the module's JSON:API Security settings, where
the policy switches described below live.

## Query depth limiting

This caps how deeply a request's `include` parameter can follow relationship
chains, which prevents expensive or abusive deeply-nested queries.

- **Global depth limit** — the default is **2**. Requests that try to include
  relationships more levels deep than this are refused.
- **Per-resource overrides** — some resources legitimately need deeper nesting.
  You can raise the limit for a specific resource type, for example allowing
  `menu_link_content--menu_link_content` a depth of 5 so a menu hierarchy can be
  returned in full.

## Collection access control

Entity *collection* endpoints (such as `/jsonapi/user/user`) can expose more than
you intend. This section lets you lock them down:

- **Restrict Collection Access** — a global switch. When on, a request to a
  collection endpoint returns `403 Forbidden` unless the user could also reach the
  corresponding administrative listing route (for example `/admin/people` for
  users).
- **Exceptions** — define resource-type-and-role pairs that are allowed to bypass
  the restriction regardless of admin permissions, in the form
  `resource_type|role1,role2` (for example `node--event|anonymous,authenticated`).
- **Route mapping** — some resources (for example `file--file`) serve their
  collection through a Drupal View rather than the standard JSON:API route, so the
  automatic admin-route check can't find a route to test. Map those explicitly in
  the form `resource_type|route_name` (for example `file--file|view.files.page_1`)
  so access is checked against the right route.

## Strict read-only mode

This enforces read-only behaviour at the API level, which is ideal for a site
that only ever serves data outward.

- **Block Write Operations** — a global switch. When on, `POST`, `PATCH`, and
  `DELETE` requests are rejected with `405 Method Not Allowed`.
- **Allowlist** — define the specific resources and methods that *are* permitted
  to write, in the form `resource--bundle|METHOD[, METHOD]` (for example
  `contact_message--feedback|POST, PATCH`).

## UID 1 (super-user) protection

These protections are on by default and are controlled from `settings.php` rather
than the form:

- **Information hiding** — by default, UID 1's user data is completely blocked
  over JSON:API; requests return `404 Not Found`, hiding even the account's UUID.
  To allow access, add to `settings.php`:

  ```php
  $settings['jsonapi_security_allow_uid1_access'] = TRUE;
  ```

- **Login blocking** — by default, attempts to authenticate as UID 1 over
  JSON:API using HTTP Basic Authentication fail silently with `401 Unauthorized`.
  This applies only when core's `basic_auth` module is enabled. To allow it, add
  to `settings.php`:

  ```php
  $settings['jsonapi_security_allow_uid1_login'] = TRUE;
  ```

Leaving both at their defaults is the safer choice; only enable them if a specific
integration genuinely needs UID 1 over the API.

## Two-factor enforcement

If you enabled the `jsonapi_security_tfa` submodule (see
[Installation](../installation/index.md)), users must have TFA set up before they
can read or write through JSON:API. Make sure users can enrol in TFA before you
rely on this.

## Save

Save the settings form to apply the policy switches. The `settings.php` flags take
effect on the next request once the file is deployed. Remember these controls
complement your core JSON:API resource and field access configuration — keep both
in good order.
