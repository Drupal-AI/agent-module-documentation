# Configuration

All of EVA's settings live at **Configuration → System → EVA - Email Validator**
(`/admin/config/system/email-validator`), reachable by a user with the
**Administer EVA API settings** permission. Validation runs automatically once the
form is configured — there is no separate per‑user permission for validation
itself.

## Access Key

Paste the **Access Key** you generated at **https://e‑va.io** into the API key
field. This is **required** — EVA cannot call the service without it. The key is
sent to e‑va.io in an `api-key` request header, and it is stored in module
configuration as plain text, so treat any exported configuration as sensitive.

## Forms to validate

The **forms** setting is a textarea where you list which forms and fields EVA
should validate, **one `form_id:field` per line**. The default is:

```
user_register_form:mail
```

which validates the email on the standard user registration form. Add more lines
to cover other forms, for example:

```
user_register_form:mail
commerce_checkout_flow_multistep_default:contact_information
```

The module handles a few forms specially:

- **Commerce checkout** (`commerce_checkout_flow_multistep_default`) reads the
  address from `contact_information[email]`.
- **Webform submissions** (any form id containing `webform_submission`) read the
  field from the submission's elements.
- **Any other form** reads the value named by the field you list.

The `field` part may use dotted notation for nested values (for example
`elements.email`).

## Allowed email states

e‑va.io classifies each address into one of four states, and you choose which of
them your site will **accept**:

- **Safe** — deliverable and trustworthy.
- **Unknown** — could not be determined conclusively.
- **Invalid** — not a real, deliverable address.
- **Risky** — deliverable but low‑quality or disposable.

An address is accepted only if its returned state is in your allowed list. The
default accepts **Safe** and **Unknown**, which rejects Invalid and Risky
addresses. Tighten this to Safe‑only for the strictest policy, or widen it if you
are getting too many false rejections.

## Disable EVA

A **Disable EVA** switch turns validation off site‑wide. When it is on, all states
are treated as allowed and **no API call is made** — useful for temporarily
suspending checks (for example if you run low on e‑va.io credits) without
uninstalling the module.

## Logging

- **Log rejected addresses** — when enabled (the default), rejected addresses are
  written to the `email_validator` logger channel so you can review what was
  blocked.

## Fail policy (when the service is unavailable)

The **system down** policy decides what happens when e‑va.io returns an error or
you are out of credits:

- **Bypass / accept all (fail‑open)** — validation is skipped and the address is
  accepted. This is the default and avoids blocking legitimate signups during an
  outage.
- **Reject all (fail‑closed)** — validations fail while the service is
  unreachable. Choose this only if it is more important to never accept an
  unvalidated address than to keep your forms working during an outage.

## Behaviour to be aware of

- **Result caching.** Each address's result is cached for one hour to reduce API
  calls, so re‑submitting the same address shortly after will not trigger a fresh
  lookup.
- **Core service override.** With EVA active (Disable EVA off and an allowed‑states
  list set), it replaces core's `email.validator` service, so email validations
  elsewhere in Drupal can also trigger the external check under the same rules. If
  another module has already decorated `email.validator`, EVA steps aside and that
  module takes precedence.
- **Fixed endpoint over HTTPS.** The e‑va.io endpoint is fixed (not configurable)
  and the call is made over HTTPS with default TLS certificate verification.

## Save

Click **Save configuration**. With a valid Access Key and at least one target
form, EVA begins validating addresses on your next form submission.

> **Privacy reminder:** EVA transmits the submitted addresses to the third‑party
> e‑va.io service. Confirm this is acceptable for your site and disclose it to
> your users where required.
