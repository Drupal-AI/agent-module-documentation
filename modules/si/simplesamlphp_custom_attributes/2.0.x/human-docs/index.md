# simpleSAMLphp Custom Attributes — manual setup guide

**simpleSAMLphp Custom Attributes** (`simplesamlphp_custom_attributes`) extends the
base simpleSAMLphp Authentication module by mapping *additional* SAML attributes
returned by your identity provider onto Drupal user fields. Where the base module
handles the essentials (username, email, roles), this child module lets you pull
across the richer profile data an enterprise directory usually holds — department, job
title, phone, manager, location, and any other custom claim.

It provides a user interface for defining those mappings: you pair each SAML attribute
with a Drupal user field. On each login it then calls the
`hook_simplesamlphp_auth_user_attributes` hook to write the incoming values into the
user's fields, so profile data stays in step with what the identity provider reports.
Because attribute mapping uses friendly names like `givenName` and `sn` when your
SimpleSAMLphp setup provides them (and OID-style names such as `urn:x` otherwise), you
map against whatever your SP is configured to return.

This is a small companion module — it depends on **simpleSAMLphp Authentication** and
does nothing on its own. Keeping HR-authoritative data in the identity provider and
letting it flow into Drupal on login is the whole idea: less manual profile entry, and
fields that reflect the source of truth.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it requires simpleSAMLphp Authentication).
2. [Configuration](configuration/index.md) — map SAML attributes to user fields.

## Where it lives in the admin menu

The mapping UI is at **Configuration → People → SimpleSAMLphp Auth Attribute
Mapping**.
