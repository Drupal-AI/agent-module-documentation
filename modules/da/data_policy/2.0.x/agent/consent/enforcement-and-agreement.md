<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Consent flow: enforcement, agreement form, and the consent text

## The consent text drives everything

`data_policy.data_policy:consent_text` (edited at
`/admin/config/people/data-policy/settings`, `DataPolicySettingsForm`) is free text where **each
line is a checkbox**. Policies are inserted with tokens:

- `[id:N]` — reference `data_policy` entity N (optional consent).
- `[id:N*]` — reference entity N as **required** consent.

`DataPolicyConsentManager::getEntityIdsFromConsentText()` regex-extracts the ids; `isDataPolicy()`
returns true when at least one token is present; `isRequiredEntityInEntities()` detects the `*`
marker. Default installed value is `I read and consent to the [id:1]` with `enforce_consent: false`.

## Enforcement — `RedirectSubscriber::checkForRedirection()`

Subscribes to `KernelEvents::REQUEST` at **priority 28**. It returns early (no enforcement) when:

- the request is XHR/AJAX;
- no data policy token is configured (`isDataPolicy()` false);
- the account is a `simple_oauth` `TokenAuthUserInterface` (decoupled/API request — the front end
  is expected to handle its own consent gate);
- the route is the agreement page itself, or one of a small allow-list
  (`user.logout`, `user.cancel_confirm`, `entity.user.cancel_form`, `data_policy.data_policy`,
  `system.403/404`, batch/asset routes, `image.style_private`, …);
- the user has the **`without consent`** permission;
- no `data_policy` entity actually exists yet.

Otherwise it compares the user's active `user_consent` records against the active revisions named
in the consent text:

- If a **required** policy exists and the user has not agreed to it
  (`didUserAgreeOnRequiredEntities()` false) → **redirect** to `/data-policy-agreement`.
- If a **new required** revision has appeared → **redirect**.
- If there is a new *optional* revision or an undecided state → it only **adds a status message**
  with a link to the agreement page (no redirect).

`doRedirect()` builds the agreement URL with the current destination attached (so the user returns
where they were), and lets `hook_data_policy_destination_alter()` implementations override the
destination first.

> Note: this is a **consent gate**, not an access-control layer. It nudges/redirects the browser;
> it does not itself protect any resource. Protected content still relies on normal Drupal
> permissions. API/token requests bypass it entirely by design.

## The agreement form — `DataPolicyAgreement`

Route `data_policy.data_policy.agreement` (`/data-policy-agreement`). Access
(`DataPolicy::agreementAccess`) requires that a policy exists and `needConsent()` is true
(`isDataPolicy() && !hasPermission('without consent')`). Being a Drupal `FormBase`, it carries the
standard CSRF token.

- `buildForm()` calls `DataPolicyConsentManager::addCheckbox()` to render one checkbox per policy
  (each linking to a modal of the full text), records a `visit`-state consent, and — when
  `enforce_consent` is on — warns that refusing a required policy leads to account cancellation.
- `submitForm()` writes the decisions via `saveConsent(uid, 'submit', …)`. If a **required** box is
  left unchecked, the user is redirected to `entity.user.cancel_form` (their own account cancel
  page). Otherwise, if they came straight to the agreement page, they are sent to `<front>`.

## Registration hook

`data_policy_form_user_register_form_alter()` injects the same consent checkboxes into the user
registration form (skipped on the admin `user.admin_create` route) and saves consent for the new
uid on submit, so consent is captured at sign-up.

## `saveConsent()` state machine (`DataPolicyConsentManager`)

- `action = 'submit'` — unpublishes the user's prior active consents and creates a new
  `user_consent` per policy with the chosen state.
- `action = 'visit'` — records that the user saw the current revisions; if the active revisions
  differ from what the user previously agreed to, old records are unpublished and fresh
  (undecided/agree) ones created; unchanged agreements are preserved.
- `createUserConsent()` writes owner + `data_policy_revision_id` (the agreed revision's `vid`) +
  `state`.
