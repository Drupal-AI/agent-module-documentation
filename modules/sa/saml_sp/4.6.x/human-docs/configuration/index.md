# Configuration

Configuring SAML SP has two parts: the **site‑wide SP settings** (who you are as a
Service Provider, and what security you require), and one or more **Identity
Provider** records (who you trust to authenticate your users). You will also hand
your IdP administrator the SP metadata that this module publishes.

Open the settings at **Configuration → People → SAML Service Provider**
(`/admin/config/people/saml_sp`). You need the **Configure SAML SP**
(`configure saml sp`) permission.

## The three fixed endpoints

These URLs exist automatically once the module is enabled — you do not create
them, but you will reference them when setting up the IdP:

| Path | Purpose |
|------|---------|
| `/saml/consume` | **Assertion Consumer Service (ACS)** — the IdP POSTs its authentication response here. |
| `/saml/metadata.xml` | **SP metadata** (public XML) — give this URL to your IdP administrator so the IdP can trust your site. |
| `/saml/logout` | **Logout callback** for SAML single logout. |

## Site‑wide SP settings

These live in the `saml_sp.settings` configuration object and are edited on the
main settings form.

### Identity and contacts

- **SP entity ID** — the unique identifier your site presents to the IdP (the
  "relying party" ID). If you leave it empty, it defaults to your site's `/user`
  URL. Many IdPs expect a stable value such as `urn:mysite:sp`.
- **Technical contact** and **Support contact** — a name and email for each,
  published in your SP metadata so the IdP administrator knows who to reach.
- **Organization** — name, display name and URL for your organization, also
  published in metadata.

### The SP certificate and key

- **Certificate location** (`cert_location`) — a server file path to the SP's
  X.509 certificate. This is **public** and gets advertised in your metadata.
- **Key location** (`key_location`) — a server file path to the SP's **private
  key**. This is a **secret**: the file should be readable only by the web server
  user, kept outside the docroot, and never committed to version control. The key
  is loaded from this path and injected into the SAML settings at request time.
- **New certificate location** (`new_cert_location`) — optional. When you are
  rotating certificates, stage the next certificate here; the module advertises
  it in metadata alongside the current one so the IdP can pick it up before you
  switch over.

An event subscriber warns administrators when the SP certificate is approaching
its expiry date, so you get a heads‑up before it lapses.

### Security flags

These decide what must be signed or encrypted. The defaults are secure; loosen
them only if your IdP requires it:

- **Sign AuthnRequests** — sign the login requests Drupal sends to the IdP.
- **Sign logout request / Sign logout response** — sign the logout messages.
- **Want messages signed** — require the IdP to sign its response messages.
- **Want assertions signed** — require the IdP to sign the assertions inside the
  response (strongly recommended).
- **NameID encrypted / Want NameID encrypted** — encrypt, or require encryption
  of, the SAML NameID.
- **Sign metadata** — sign your published SP metadata.
- **Signature algorithm** — the XML signature algorithm used for signing; the
  default is RSA‑SHA256.

### Protocol options

- **Strict** — enable strict SAML 2.0 protocol processing (recommended for
  spec‑compliant validation). On by default.
- **Valid until** — an expiry stamped onto your published metadata (a date/time,
  or the special value that ties it to the certificate).
- **Debug** — turn on verbose debugging while you integrate with an IdP; it helps
  you inspect NameIDs and responses. Turn it off in production.

You can also read or set any of these from the command line:

```bash
drush cget saml_sp.settings
drush cset saml_sp.settings entity_id 'urn:mysite:sp' -y
drush cset saml_sp.settings cert_location '/etc/saml/sp.crt' -y
drush cset saml_sp.settings key_location '/etc/saml/sp.key' -y
```

## Registering an Identity Provider

Your Identity Providers are stored as separate `idp` configuration records.
Manage them at **Configuration → People → SAML Service Provider → Identity
Providers** (`/admin/config/people/saml_sp/idp_collection`), and click **Add
Identity Provider**.

The quickest path is to **paste the IdP's XML metadata** into the form — the
module auto‑fills most of the fields below from it. Otherwise fill them in by
hand:

- **Label** — a human‑friendly name for this IdP.
- **Entity ID** — the IdP's unique identifier (its entityID).
- **Login URL** (Single Sign‑On URL) — where Drupal sends users to authenticate.
- **Logout URL** (Single Logout URL) — where logout messages are sent.
- **X.509 certificate** — the IdP's public certificate, used to verify the
  signatures on its responses. (Multiple can be stored; the first is used.)
- **NameID field** — which incoming attribute identifies the user, e.g. `mail`.
- **Authentication context class references** — optionally require a specific
  authentication method. The built‑in choices are: username and password,
  password‑protected transport, TLS client, X.509 certificate, integrated Windows
  authentication, and Kerberos. Leaving this empty places no constraint.

Once the IdP is saved, complete the loop on the IdP side: register your SP there
using the metadata from `/saml/metadata.xml`, so the IdP knows to POST responses
to your `/saml/consume` endpoint.

## Testing the round trip

With both the SP settings and an IdP configured, and the `saml_sp_drupal_login`
submodule enabled, initiate a login. Drupal redirects the user to the IdP; after
the user authenticates there, the IdP posts a response back to `/saml/consume`,
the module validates it, and the login submodule signs the matching Drupal
account in. If something fails, turn on **Debug** temporarily and check your logs
to inspect the response and NameID.
