# Secure Login developer API

Service id: `securelogin.manager` (class `Drupal\securelogin\SecureLoginManager`, also
autowirable by its class name). Implements `TrustedCallbackInterface`.

## Opt a form / URL in from code (no service needed)

```php
// In a hook_form_alter or a form builder: mark the form as needing HTTPS.
$form['#https'] = TRUE;

// Force a generated URL onto HTTPS.
$url = Url::fromRoute('my.route', [], ['https' => TRUE]);
```

Setting `#https = TRUE` is the same signal the module's own `form_alter` sets for configured
forms; core + Secure Login then secure the action. `$options['https'] = TRUE` is honoured by
`SecureLoginPathProcessor` (an outbound `path_processor`) which, if a `base_url` is configured,
forces `absolute` + the configured secure `base_url`.

## Service methods

```php
$manager = \Drupal::service('securelogin.manager');

// Secure a form array in place: sets #https, adds url.site cache context,
// rewrites #action to the secure base URL, and (if secure_forms is on and the
// request is insecure) schedules a redirect of the whole page to HTTPS.
$manager->secureForm($form);

// Redirect the current request to the same path on the secure base URL.
// No-op if the request is already HTTPS. Uses 301 for cacheable (GET/HEAD)
// requests, 308 otherwise, via a high-priority KernelEvents::RESPONSE listener.
$manager->secureRedirect();

// Rewrite a single URL string to the secure base URL (or forcibly http->https).
$secure = $manager->secureUrl($url);
```

`secureForm()` also rewires the form-action lazy-builder placeholders
(`renderPlaceholderFormAction`) and, for the user login block, is re-run through the
`userLoginBlockPreRender` pre-render callback so the block's action survives user module's late
alteration.

## Related services (internal, no public API surface)

- `securelogin.path_processor` — outbound path processor applying `base_url` when `https` option set.
- `securelogin.request_subscriber` — redirects insecure `user.reset.login` (one-time login) requests to HTTPS when `user_pass_reset` is secured.
- `securelogin.response_subscriber` — on POST as an already-authenticated user landing on 403/404, redirects to the `destination`.

## Notes

- The secure base URL used is `securelogin.settings:base_url` if set, else Drupal's computed
  `$base_secure_url`.
- Redirects are `TrustedRedirectResponse` objects tagged with a `securelogin` cache tag.
