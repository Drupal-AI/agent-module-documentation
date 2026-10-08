# hook_robotstxt (robotstxt.api.php)

## `hook_robotstxt(): array`
Return an array of strings to append to the generated robots.txt. Invoked via
`invokeAll('robotstxt')` in `RobotsTxtController::content()`; each returned line
is trimmed, empties are dropped, and lines are joined with `\n` onto the
configured content.
```php
function mymodule_robotstxt() {
  return [
    'Disallow: /foo',
    'Disallow: /bar',
  ];
}
```
Typical uses: a sitemap module adding a `Sitemap:` line, or an environment
module injecting `Disallow: /` on non-production hosts. Remember the output is
cached under the `robotstxt` cache tag — add appropriate cacheability if your
lines vary.
