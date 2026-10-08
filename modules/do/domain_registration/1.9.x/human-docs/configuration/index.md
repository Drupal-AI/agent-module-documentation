# Configuration

## Open the settings form

1. Log in as a user with the **Administer domain registration** permission.
2. Go to **Configuration → System → Domain registration**, or navigate directly to
   `/admin/config/system/domain_register`.

The form has three settings, all stored in `domain_registration.settings`.

## Restriction Type

Choose how the domain list is interpreted:

- **Allow only domains listed** *(default)* — only email addresses whose domain
  matches an entry in the list may register. Everyone else is rejected. This is a
  *fail-closed* allowlist: if the list is misconfigured, registration is blocked
  rather than opened.
- **Prevent domains listed from registering** — anyone may register *except*
  addresses whose domain matches the list. This is a blocklist for keeping
  specific domains out (for example throwaway/spam email providers or competitors).

## Email domains

A text box where you list the domains, **one per line**. Two wildcards are
supported:

- `*` matches any sequence of characters.
- `?` matches any single character.

Matching is case-insensitive and **anchored** — a bare `example.com` matches only
`example.com`, not `sub.example.com`. To include subdomains, add a wildcard entry
such as `*.example.com`. Some examples:

```
company.com
*.company.com
*.edu
```

If you leave this box **empty**, no restriction is applied at all and registration
is open — a handy way to temporarily lift the rule without uninstalling the module.

## Error message

The message shown to the visitor when their email domain fails the check (for
example "You are not allowed to register for this site."). This text is
translatable per language via configuration translation, so you can localize the
rejection message.

## Save

Click **Save configuration**. The rule takes effect immediately on the standard
`/user/register` form.

## Things to know

- **Only the standard registration form is enforced.** Accounts created by an
  administrator via *People → Add user*, by migrations, or programmatically are
  **not** validated against these rules.
- **Deployment caveat.** The domain list is split on Windows-style (`\r\n`) line
  endings. When the box is filled in through this form that's exactly what gets
  saved, so the UI always works. But if you set
  `domain_registration.settings:pattern` some other way — a config import from a
  YAML file, `drush config:set`, config-split, or a Features-style deployment —
  using Unix (`\n`) newlines, the whole list collapses into a single unusable
  pattern. After any config deployment that touches this module, re-test that the
  restriction still behaves as intended. See the sibling `agent/` docs for detail.

## Switching strategies

Because the mode is a single radio and the domains a single list, you can flip
between an allowlist and a blocklist strategy quickly, or clear the list to open
registration, all from this one form.
