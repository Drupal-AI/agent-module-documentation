# Configuration

Reauthenticate's configuration is a single list: the paths that should require a
fresh password entry.

## Open the settings form

1. Log in as an administrator (or a role granted the module's administer
   permission).
2. Open the module's settings form — via **Extend**, then the module's
   **Configure** link, or from the site's configuration section.

## Choose the pages to protect

The form provides a text area where you list **path patterns**, one per line. Any
page whose path matches a pattern will prompt the logged‑in user to re‑enter their
password before the page is shown. Patterns use the familiar `*` wildcard, for
example:

```
/user/*/edit*
/admin/structure/webform*
```

The first line protects every user's edit form; the second protects the webform
administration area. Add as many patterns as you need to cover your sensitive
areas, and keep the list tight — every protected path is one more password prompt
for your editors, so protect what genuinely warrants it rather than everything.

## Save

Click **Save**. From then on, an already‑logged‑in user who visits a matching page
must confirm their password before continuing. Test each pattern by visiting a
matching page while logged in.

> **Tip:** because this is a beta and isn't covered by the security advisory
> policy, treat it as one layer among several (strong passwords, session timeouts,
> two‑factor authentication) rather than your only safeguard on high‑risk pages.
