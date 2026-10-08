<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

API Connection is configured through its own settings form (the
`api_connection.settings_form` route), reachable by users who hold the module's
administration permission. This is where you define the API connection details —
endpoints and credentials — that consuming modules then use.

## Open the settings form

1. Log in as a user granted the module's connection-administration permission
   (grant it under **People → Permissions** to trusted roles only).
2. Open the API Connection settings form. Because this is a small helper module,
   confirm the exact menu location on your site's **Extend** or configuration
   listing after enabling it.

## Configure the connection securely

When you fill in the connection details, keep two security rules in mind:

- **Store credentials as secrets.** Do not paste long-lived API keys or passwords
  directly into configuration that gets exported to code. Prefer an environment
  variable or a Key entity, so the secret never lands in version control.
- **Keep TLS verification on.** The module verifies certificates by default when
  it makes outbound calls. Leave that enabled — never disable certificate
  verification, which would expose the connection to interception.

## Save

Save the form to store your connection settings. Consuming modules (including the
`api_connection_example` submodule, if you enabled it) then use this shared
configuration to make their outbound API calls.
