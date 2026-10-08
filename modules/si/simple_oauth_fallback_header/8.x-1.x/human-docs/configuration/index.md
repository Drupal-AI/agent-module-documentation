# Configuration

This module has **no settings form and no admin page**. It works with zero
configuration out of the box. Everything on this page is optional, and every
setting lives in your site's `settings.php` file (typically
`sites/default/settings.php`).

## Rename the fallback header

By default the module reads the token from the `X-OAuth-Authorization` header.
If that name clashes with something else, or you simply prefer another, set your
own:

```php
// Rename the fallback header (default: X-OAuth-Authorization):
$settings['simple_oauth_fallback_header'] = 'X-My-Api-Auth';
```

Clients then send their token in whichever header name you chose:

```
X-My-Api-Auth: Bearer <access-token>
```

## Allow the token in a GET query

By default this is off. If you enable it, the module will also accept the token
in an `access_token` URL query parameter — for example `/api?access_token=XXX`
(RFC 6750 §2.3):

```php
// Allow the token in an access_token GET query. Off by default.
$settings['simple_oauth_allow_get_query'] = TRUE;
```

> **Think twice before enabling this.** Putting an access token in a URL means it
> can be captured in server access logs, browser history and `Referer` headers.
> RFC 6750 discourages the practice for exactly this reason. Prefer the header,
> and use the GET-query mode only where you must (for example while migrating
> older clients over to header-based tokens).

## How the token source is chosen

When more than one source is present, the module resolves them in this order:

1. The configured fallback header (`X-OAuth-Authorization` by default).
2. The `access_token` GET query — only if you enabled it above, and only if no
   header was found.

Whichever wins is written into the standard `Authorization` header as
`Bearer <token>`, and **any value that was already in `Authorization` for that
request is lost**. Simple OAuth then validates the token exactly as normal — no
token means no change and an unauthenticated request.

## Coexisting with server-side HTTP authentication

If your server also uses basic or digest HTTP authentication, Simple OAuth's
built-in `basic_auth_swap` middleware can get in the way — it converts
`PHP_AUTH_USER` / `PHP_AUTH_PW` into OAuth client credentials, which breaks token
creation when you are combining the two schemes. To let them coexist, add a small
service provider in a custom module that removes that middleware:

```php
public function alter(ContainerBuilder $container): void {
  // Remove Simple OAuth's basic-auth-swap HTTP middleware so PHP_AUTH_USER/PW
  // are not turned into OAuth client_id/client_secret.
  $container->removeDefinition('simple_oauth.http_middleware.basic_auth_swap');
}
```

After that, you can safely use the custom header for OAuth while keeping the
standard `Authorization` header free for basic/digest HTTP auth.

Remember to `drush cr` (rebuild caches) after changing `settings.php` or adding a
service provider so the changes take effect.
