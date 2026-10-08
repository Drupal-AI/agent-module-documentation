# hook_gdpr_compliance_policy_alter

Declared in `gdpr_compliance.api.php`; invoked by `PagePolicy::page()` for the
`/gdpr-compliance/policy` page. Lets you alter the raw policy content and the token context
before it is rendered through an `inline_template`.

```php
/**
 * @param string   $policy   Raw content of the policy page (the shipped HTML file body).
 * @param string[] $context  Template context; keys: 'changed', 'url', 'mail'.
 */
function hook_gdpr_compliance_policy_alter(&$policy, array &$context) {
  // Override the contact e-mail shown in the policy.
  $context['mail'] = 'privacy@example.org';
  // Or replace the body entirely.
  // $policy = '<h2>Our privacy policy</h2>...';
}
```

Context defaults set by the controller:
- `changed` — the policy source file's mtime, formatted `medium`.
- `url` — the request host (`$request->getHost()`).
- `mail` — `system.site` mail.

The `$policy` string is compiled as a Twig `inline_template` with `$context`, so `{{ mail }}`,
`{{ url }}`, `{{ changed }}` in the HTML resolve from the context you provide. The shipped
policy source is a module-static file (`assets/policy/policy-{lang}.html`); only code
implementing this hook (or editing that file) changes it.
