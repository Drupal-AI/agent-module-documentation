# Configuration

SSO Bouncer needs to know two things: whether it should be active, and which
OpenID Connect client's group mappings decide who is allowed in.

## Open the settings form

1. Log in as an administrator.
2. Go to **Administration → Configuration → People → SSO Bouncer Settings**, or
   navigate directly to `/admin/config/people/sso-bouncer`.

## Settings

- **Enabled** — turns the bouncer on or off. When off, OpenID Connect login
  behaves as normal with no group gating. When on, SSO Bouncer checks each SSO
  login against the authorized groups and denies anyone who does not match.
- **Client ID** — the OpenID Connect client whose role mappings supply the list
  of allowed groups. Set this to the client that carries the Keycloak group
  mappings you want to enforce.

Save the form to apply your changes.

## Managing it from Drush

The same on/off state can be managed from the command line:

```bash
drush sso_bouncer:enable [CLIENT_ID]   # enable and (optionally) set the client ID
drush sso_bouncer:disable              # turn the bouncer off
drush sso_bouncer:status               # show the current configuration
```

## Getting the mapping right

Because this form decides who can and cannot log in, treat the group-to-role
mappings as a security boundary. A mapping that is too permissive lets in groups
you did not intend, so define it carefully in OpenID Connect's role-mapping
settings and then **test with an account whose group is not authorized** to
confirm that login is actually denied — you should see the message *"Your group
is not authorized to access this Drupal instance."* Keep the OpenID Connect
client secret stored as a secret rather than in exportable configuration.
