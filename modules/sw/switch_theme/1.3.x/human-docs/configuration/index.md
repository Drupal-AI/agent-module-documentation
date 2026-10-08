# Configuration

Switch Theme does nothing until you tell it which role should see which theme,
and where. You do that by adding one or more **rules** on the module's settings
form.

## Open the settings form

1. Log in as a user with permission to administer the site.
2. Open the **Switch Theme** settings form. These docs don't record its exact
   menu path — look for it under **Configuration** in the admin menu, or click
   the **Configure** link next to Switch Theme on the **Extend** page
   (`/admin/modules`).

## Build a rule

Each rule ties three things together:

- **Role** — the user role the rule applies to (for example *Authenticated
  user*, *Editor*, or *Anonymous*).
- **URI pattern** — a regular expression matched against the current path. Use
  it to scope a theme to particular pages. For instance, `#^/account$#` matches
  only the exact path `/account`; a broader pattern like `#^/account#` would
  match `/account` and anything beneath it. Leave it as broad as your use case
  needs — the pattern is a standard PHP regular expression, delimiters and all.
- **Theme** — the theme to activate when a visitor's role and current URL match
  the rule.

When a page loads, Switch Theme checks the current user's roles and the path
against your rules and, on a match, swaps in the theme you chose. If nothing
matches, the visitor keeps the site's normal default theme.

## A worked example

To give authenticated users a special theme only on the account page:

- **Role:** Authenticated user
- **URI pattern:** `#^/account$#`
- **Theme:** the theme you want them to see there

Save the form and visit `/account` as an authenticated user — the chosen theme
takes over on that page while the rest of the site stays on the default theme.

## A reminder about scope

These rules change only the **look** of the page. They are not a security
control: a visitor still has exactly the same access to content and actions
regardless of which theme renders. Never use a theme swap to try to hide
sensitive data — enforce that with roles and permissions instead.
