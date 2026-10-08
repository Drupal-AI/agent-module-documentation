# Configuration

Pages Restriction Access is configured on one form. This page walks through each
setting and how the redirect and bypass rules behave.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Pages Restriction Access**, or navigate
   directly to `/admin/config/development/pages-restriction/settings`.

## The settings

### Restricted pages (the mappings)

This is the main setting — a textarea where you list one rule per line in the
form:

```
restricted-path|target-path
```

The **left** side is the page you want to protect; the **right** side is where a
disallowed visitor is sent instead. For example:

```
contact/thank-you|contact/send-your-message
newsletter/success|newsletter/subscribe
```

Here, anyone who tries to open `/contact/thank-you` directly is redirected to
`/contact/send-your-message`. Paths are matched against the **current page's URL
alias**, so use the aliased paths your visitors actually see. Add as many rules
as you need, one per line.

### Keep Parameters

A checkbox. When enabled, any query parameters on the incoming request (for
example `?utm_source=…` tracking parameters) are carried over onto the redirect
target's URL. Leave it off if you want the target page to load with a clean URL.

### Bypass roles

A list of roles whose **logged-in** users skip all restrictions entirely. Tick
the roles that should always be able to reach restricted pages directly —
commonly administrators, and perhaps editors or QA staff. Users without a bypass
role are subject to the redirect rules.

## Save

Click **Save configuration**. The rules take effect immediately on the next page
request — the module checks every request early, before the page renders.

## One-time session bypass (for developers)

Beyond role-based bypass, the module can let a specific user view a restricted
page **once** — the intended use for a genuine "thank you" flow. When a user
completes the preceding step (say, submitting the form on the target page), your
code calls the module's session service to mark the restricted page as allowed
for that user's session:

```php
\Drupal::service('pages_restriction.session_service')
  ->setBypass('/contact/thank-you');
```

Typically you'd call this from the submit handler of the form on the *target*
page. The next time that user lands on the restricted page they're let through;
a later direct visit (without having completed the step) is redirected as
normal. See the agent docs at
[`api/services.md`](../../agent/api/services.md) for the full behavior.

## Deploying the configuration

All settings live in a single config object, `pages_restriction.settings`, so
you can export it with the rest of your site configuration
(`drush config:export`) and deploy it between environments like any other
configuration.
