# Configuration

Configuration has two halves, and it is important to keep them straight. The
**simpleSAMLphp service provider** is configured outside Drupal (its metadata,
certificates and assertion validation), and the **Drupal module** is configured on a
settings form. The trust and the cryptography live in the first half; the second half
just tells Drupal how to map an authenticated SAML user onto an account.

## Configure the simpleSAMLphp service provider first

Before the Drupal form matters, make sure your simpleSAMLphp SP is fully configured:
the service-provider metadata, the identity provider's certificate and entity ID, and
— most importantly — **signature validation** of incoming assertions. This is where
SAML security actually resides; an SP that does not validate assertion signatures is
the classic SAML vulnerability. Follow the simpleSAMLphp SP installation instructions
for this part, and remember the session store must not be `phpsession`.

## Open the module's settings form

The module adds a settings form under **Configuration → People**. Only users with the
**Administer simpleSAMLphp authentication** permission can reach it, and that
permission is high-privilege — grant it to trusted administrators only.

On the form you configure how Drupal treats an authenticated SAML user, including:

- **Activation** — a master switch. Nothing happens until you turn it on, so you can
  set everything up safely first and enable SAML last.
- **Attribute mapping** — which SAML attributes supply the account's unique identifier,
  username and email. Getting the unique-identifier attribute right is what keeps a
  returning user linked to the same Drupal account.
- **Just-in-time provisioning** — whether to automatically create a Drupal account the
  first time a user authenticates via SAML.
- **Role assignment** — rules that map SAML attribute values to Drupal roles, so group
  membership at the identity provider drives roles on your site.
- **Local login behaviour** — whether traditional Drupal logins are still allowed
  alongside SAML ("dual mode"), and which accounts may continue to log in locally.

## The two permissions

- **Administer simpleSAMLphp authentication** — access to the settings form above,
  including the activate switch, attribute mapping and role rules. It governs how the
  whole site authenticates, so it is restricted to trusted admins.
- **Change SAML authentication setting** — controls who may enable or disable SAML on
  an individual user account.

## Save and test

Configure the SP and the form, then enable **activate** and test the SAML login flow
end to end — confirm a user is redirected to the identity provider, comes back
authenticated, and is linked to (or provisioned as) the correct Drupal account with
the expected roles.
