# Configuration

You configure this module by creating an **OpenID Connect client** and choosing **Windows
Azure AD** as its type. There is no separate settings page. A real login flow needs a working
Microsoft Entra tenant; the steps below assume you have an Entra app registration with a
Client ID, a client secret, and the tenant's endpoint URLs.

## Step 1 — Store the client secret as a Key

The client secret is always resolved through a **Key** entity, never stored in plain Drupal
config. Create the Key first.

The most robust approach is an environment variable read by the Key module. With DDEV, for
example, save the secret into the container's environment and then create an env‑backed Key:

```bash
drush key:save entra_secret --label='Entra secret' --key-type=authentication \
  --key-provider=env --key-provider-settings='{"env_variable":"ENTRA_SECRET"}' \
  --key-input=none -y
```

Alternatively create the Key in the UI at **Configuration → System → Keys → Add key**
(`/admin/config/system/keys/add`). You will select this Key by name in the client form below.

## Step 2 — Add the Windows Azure AD client

1. Go to **Configuration → Web services → OpenID Connect**
   (`/admin/config/services/openid-connect`).
2. Click **+ Add OpenID Connect client**.
3. Give it a label (e.g. *Microsoft Entra ID*) and choose **Windows Azure AD** as the client
   plugin.

## Step 3 — Fill in the client settings

- **Client ID** — the Application (client) ID from your Entra app registration.
- **Client secret** — select the **Key** you created in step 1.
- **Authorization endpoint** — your tenant's authorize URL, typically
  `https://login.microsoftonline.com/<tenant‑id>/oauth2/v2.0/authorize`.
- **Token endpoint** — the matching token URL,
  `https://login.microsoftonline.com/<tenant‑id>/oauth2/v2.0/token`.
  (For **Azure AD B2C** the host is `https://<tenant>.b2clogin.com/...` — the module detects
  B2C automatically from that host and adjusts the flow.)
- **End‑session / logout endpoint** — optional; provide it to enable single sign‑out so Entra
  can log the user out of Drupal.
- **Userinfo endpoint** — leave blank unless you use the "alternate/none" Graph option below.

### How user info is fetched

- **User info endpoint** (Graph choice) — pick **Microsoft Graph v1.0** (recommended) for
  modern tenants. **Azure AD Graph v1.6** exists only for legacy setups (deprecated by
  Microsoft). The third option skips a userinfo call and reads claims straight from the token
  for lean flows.
- **Update email address** — when on, the Drupal account's email is refreshed from Entra on
  each login.
- **Use other mails** — fall back to Graph's `otherMails` property when the primary mail is
  missing.
- **Hide email address warning** — suppress the "email not found" message shown to users when
  no mail claim is available.
- **Immutable identifier** (`sub` vs `oid`) — which claim is used to match an Entra user to a
  Drupal account. `sub` is the default; `oid` is more stable across app registrations and
  environments but requires a patch to OpenID Connect (see the linked issue in the agent
  docs).

### Sign‑in prompt

- **Prompt** — optional Entra prompt behaviors: force re‑login, force consent, show an
  account picker (`select_account`), or trigger a sign‑up experience (`create`).

## Step 4 — Map Entra groups to Drupal roles (optional)

- **Map AD groups to Drupal roles** — turn this on to grant Drupal roles based on the user's
  Entra group membership.
- **Mapping method:**
  - **Automatic** — a Drupal role is granted when its name or ID matches an Entra group.
  - **Manual** — you provide explicit mappings, one per line, in the form
    `role | group‑object‑id` (you can list several group IDs for one role, separated by
    semicolons). Use this when Entra group names differ from your Drupal role names.
- **Strict mode** — when on, roles that are *not* backed by a current Entra group are removed
  from the user on each login, so Drupal roles stay in lock‑step with Entra groups.

## Step 5 — Save and test

Save the client. On the OpenID Connect settings you can also control whether the "Log in with
Microsoft" button appears on the user login form. Then, in a private browser window, use that
button and complete the Microsoft sign‑in — a Drupal account should be created (or matched)
and any configured role mapping applied.

> Remember: without a reachable Entra tenant and valid credentials the client is only
> *registered*, not functional — it cannot authenticate anyone by itself.
