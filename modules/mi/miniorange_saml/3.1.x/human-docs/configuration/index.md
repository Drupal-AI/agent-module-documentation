# Configuration

Configuring a SAML Service Provider is a two-sided handshake: you tell Drupal about
your Identity Provider, and you tell your Identity Provider about Drupal. All of the
Drupal-side settings live under **Configuration → People → miniOrange SAML**
(`/admin/config/people/miniorange_saml/…`) and require the **Administer site
configuration** permission.

## Step 1 — Enter your IdP's details (Service Provider Setup)

Open the **Service Provider Setup** tab
(`/admin/config/people/miniorange_saml/sp_setup`). This is the main setup screen and
the module's default configure page. Enter:

- **IdP name** — a display name for your identity provider (this is the text that
  appears in the "Login using [name]" link).
- **IdP entity ID / issuer** — the identifier your IdP uses for itself.
- **IdP SSO / login URL** — the URL Drupal sends the login request to.
- **IdP x509 certificate** — your IdP's **public** signing certificate, used to
  validate the assertions it sends back. (This is a public certificate, not a
  secret.)

Save. The module treats the SP as "configured" once **login is enabled** and both the
**IdP name** and **IdP issuer** are filled in — at which point a "Login using [IdP
name]" link is automatically added to the Drupal login form and login block.

## Step 2 — Register Drupal with your IdP (Identity Provider Setup)

Open the **Identity Provider Setup** tab
(`/admin/config/people/miniorange_saml/idp_setup`). It shows the details your IdP
administrator needs to register Drupal as a Service Provider — the SP entity ID, the
base URL, and the endpoints. You can also fetch the SP metadata XML directly at
`/saml_metadata` and hand that file to your IdP. The key endpoints are:

| Purpose | Path |
|---|---|
| SP-initiated login (start SSO) | `/samllogin` |
| Assertion Consumer Service (ACS — receives the IdP's response) | `/samlassertion` |
| SP metadata XML | `/saml_metadata` |
| Test the configuration | `/testSAMLConfig` |

In your IdP, set the ACS / reply URL to your site's `/samlassertion` endpoint and the
SP entity ID to the value shown on this tab.

## Step 3 — Map the login and email attributes (Mapping)

Open the **Attribute & Role Mapping** tab
(`/admin/config/people/miniorange_saml/Mapping`). Here you choose which piece of the
SAML assertion becomes the Drupal **username** and which becomes the **email**. Both
default to **NameID** (the standard subject identifier), which works for many IdPs;
change them to a named attribute (for example an `EmailAddress` attribute) if your IdP
sends the values that way. Role mapping and automatic user provisioning also live on
this tab but are licensed features.

## Step 4 — Sign-in options (Sign-in Settings)

Open the **Sign-in Settings** tab
(`/admin/config/people/miniorange_saml/signon_settings`). Useful options:

- **Enable login** — the master switch for SAML login (needed for the module to count
  as configured).
- **Auto-redirect to IdP** — send visitors straight to the IdP instead of showing the
  Drupal login form.
- **Force authentication** — make the IdP re-authenticate the user on every login.
- **Enable backdoor** — keep a Drupal-native login available even while SSO is on
  (recommended so you are not locked out if the IdP is unreachable).
- **Default RelayState / redirect** — where to send the user after a successful login.

## Testing

Once both sides are configured, use the **Test Configuration** flow (`/testSAMLConfig`)
to run an end-to-end login and confirm the assertion is received and validated. If the
test succeeds, the "Login using [IdP]" link on the login form will log real users in.

## The NameID format

The AuthnRequest Drupal sends asks for a NameID format that defaults to
`urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified`. Most IdPs accept this; change
it only if your IdP requires a specific format.
