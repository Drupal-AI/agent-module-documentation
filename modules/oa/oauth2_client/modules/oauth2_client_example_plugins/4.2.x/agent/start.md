# oauth2_client_example_plugins — agent index

Demonstration submodule of **OAuth2 Client**. Registers four `oauth2_client` example plugins and
nothing else (no config, schema, permissions, or services). Read them as templates; see the
parent module's `plugins/client-and-grant.md` for the full plugin contract.

- **The four example plugins (ids, grant types, storage traits, interfaces)** →
  [plugins/examples.md](plugins/examples.md)

Quick reference:

| Plugin id | Grant type | Token storage | Extra interface |
|---|---|---|---|
| `authcode_example` | authorization_code | StateTokenStorage | — (`success_message: TRUE`) |
| `resource_owner_example` | resource_owner | StateTokenStorage | — |
| `authcode_redirect_example` | authorization_code | TempStoreTokenStorage | `Oauth2ClientPluginRedirectInterface` (redirect to `<front>`) |
| `authcode_access_example` | authorization_code | TempStoreTokenStorage | `Oauth2ClientPluginAccessInterface` (needs `access content`) |

Auth-code examples use `https://oauth.mocklab.io/oauth/{authorize,token}`. Note there is **no**
`client_credentials` example plugin in this version.
