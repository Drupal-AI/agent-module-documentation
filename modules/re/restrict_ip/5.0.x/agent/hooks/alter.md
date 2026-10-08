# Restrict IP — alter hooks

From `restrict_ip.api.php`. All are optional and implemented in a module or a theme's `.theme`
file (prefix with your theme/module key).

## `hook_restrict_ip_whitelisted_regions()`

Return an array of theme region keys that should still render even for a blocked user (keys are
the `regions:` keys from the theme `.info.yml`).

```php
function hook_restrict_ip_whitelisted_regions() {
  return ['sidebar_first'];
}
```

## `hook_restrict_ip_whitelisted_js_keys()`

Return an array of JavaScript asset keys (as used in `hook_js_alter()`) allowed to load even
when access is denied.

```php
function hook_restrict_ip_whitelisted_js_keys() {
  return ['core/assets/vendor/jquery/jquery.js'];
}
```

## `hook_restrict_ip_access_denied_page_alter(array &$page)`

Add to, remove from, rewrite, or redirect away from the Access Denied page. The render array
exposes keys such as `access_denied`, `contact_us`, `logout_link`, `login_link` (some only exist
depending on configuration).

```php
// Add information:
function mytheme_restrict_ip_access_denied_page_alter(array &$page) {
  $page['extra'] = ['#markup' => t('Contact IT for access.'), '#prefix' => '<p>', '#suffix' => '</p>'];
}

// Or redirect denied users elsewhere:
function mytheme_restrict_ip_access_denied_page_alter(array &$page) {
  (new \Symfony\Component\HttpFoundation\RedirectResponse('https://example.com/'))->send();
}
```
