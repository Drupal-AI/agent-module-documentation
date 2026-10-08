# Configuration

All this module does is let you map SAML attributes to Drupal user fields, so the
configuration is a single mapping screen.

## Open the mapping UI

1. Log in as an administrator (the same trusted role that administers simpleSAMLphp
   Authentication).
2. Go to **Configuration → People → SimpleSAMLphp Auth Attribute Mapping**.

## Map attributes to user fields

For each piece of profile data you want to bring across, pair a **SAML attribute**
with a **Drupal user field**. Use the attribute names your SimpleSAMLphp setup
returns:

- If your SimpleSAMLphp configuration provides **friendly names**, use those — for
  example `givenName` or `sn`.
- If friendly names are not configured, you will use the **OID-style** names instead,
  such as `urn:x`. Refer to your own SimpleSAMLphp configuration to see which form
  applies.

The target Drupal field must already exist on the user entity — create it first under
the user account field settings if it does not.

## How it applies

Once the mappings are saved, the module writes the incoming attribute values into the
mapped user fields **on each login**, via the
`hook_simplesamlphp_auth_user_attributes` hook that the base module fires. That means
a returning user's profile fields are refreshed from the identity provider every time
they authenticate, keeping the identity provider authoritative.

## Save and test

Save the mappings, then log in as a SAML user and check that the mapped fields on
their account have been populated with the values from the identity provider.
