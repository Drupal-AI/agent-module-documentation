# Configuration

Pantheon SI Tokens has one settings form: the **allowlist** of Pantheon Secure
Integration constants that should be turned into tokens.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Pantheon SI Tokens**, or navigate directly to
   `/admin/config/system/pantheon-si-tokens`.

## Allowlist the constants to expose

The form stores a list of **constant names** you want surfaced as tokens. Add the
`PANTHEON_SOIP_*` constant names your integrations need — for example
`PANTHEON_SOIP_LDAP`. The module only accepts names that:

- start with the **`PANTHEON_SOIP_`** prefix, and
- hold an **integer in the valid port range (1–65535)**.

That guard keeps the module to its intended purpose — Pantheon SI tunnel ports —
and prevents accidentally exposing other PHP constants. Save the form when done.

## Use the tokens

Each allowlisted constant becomes a token under the **`pantheon_si_tunnel`** token
type, named as the constant lowercased:

- `PANTHEON_SOIP_LDAP` → `[pantheon_si_tunnel:pantheon_soip_ldap]`

Use that token anywhere Drupal processes tokens. A common example is a Feeds source
pointing at a firewalled service through the SI tunnel:

```
127.0.0.1:[pantheon_si_tunnel:pantheon_soip_ldap]
```

When the token is evaluated, the module returns the runtime value of the constant
if it is both allowlisted **and** defined; otherwise it returns an empty string.

## Security note

Whatever the named constant holds is returned **verbatim**. The allowlist is your
control: do not allowlist a sensitive constant and then place its token into
content or output that unprivileged users can see, or you would disclose that
value. Audit periodically which constants you have surfaced, and keep the list to
the SI tunnel ports your integrations actually require.
