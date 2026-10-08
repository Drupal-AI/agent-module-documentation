# Configuration

You manage identity providers at **`/admin/config/people/saml/idp`**. Each IdP is
a configuration entity, so everything you set here can be exported and imported
between environments alongside your other Drupal configuration.

## Managing IdPs

1. Go to **`/admin/config/people/saml/idp`**.
2. You will find the **default IdP** already present — created on installation, or
   imported from your existing `samlauth` configuration if you had one. This
   default is also used as a fallback if someone follows an invalid IdP link.
3. **Add additional IdPs** for each organisation, tenant or portal you need to
   support. Configure each one with its own certificate and metadata.
4. For each IdP, decide whether to **enable a login link**. You can disable the
   link for any IdP you do not want shown on the login page.

## How the login links behave

- With login links enabled for the relevant IdPs, those links appear on the
  standard Drupal login page.
- If **more than one** IdP has a login link enabled, the single samlauth login
  link is replaced by a page that lists all the enabled providers, letting the
  user choose which one to sign in with.

## Keep it secure

The SAML assertion validation itself — signature checks and assertion conditions
— is handled by `samlauth` and its underlying toolkit; this module adds the
per‑IdP configuration and routing. So for each IdP you add:

- keep its **certificate and metadata** accurate and up to date;
- confirm that assertions are actually being **validated for that IdP**;
- store any **signing keys securely** (for example via the Key module rather than
  in plain configuration);
- serve the site over **HTTPS**.
