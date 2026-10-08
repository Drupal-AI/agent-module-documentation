# Configuration

Setting up Key Authentication is three steps: adjust the site-wide settings, grant
the permission that makes keys usable, and generate a key for each API user (who
then sends it on their requests).

## Site-wide settings

Go to **Configuration → Web services → Key authentication**
(`/admin/config/services/key-auth`). You need the *Administer site configuration*
permission. The values are stored in the `key_auth.settings` config object:

| Setting | Default | What it does |
|---|---|---|
| **Automatically generate a key when users are created** (`auto_generate_keys`) | on | When a new user is created, give them a key automatically — but only if their role already has the *Use key authentication* permission. |
| **Key length** (`key_length`) | `32` | The character length of generated keys (between 8 and 255). Raise it for higher-entropy keys. |
| **Parameter name** (`param_name`) | `api-key` | The name of both the HTTP header and the query parameter clients use to send their key. Change it to something project-specific, e.g. `x-api-token`, if you prefer. |
| **Detection methods** (`detection_methods`) | header + query | Which delivery methods are accepted: **header**, **query**, or both. You can also enable just one to be stricter. |

A few notes on how detection works: the **header is checked first**, and if a key is
found there the query string is not consulted. Changing the **parameter name**
changes *both* the header name and the query parameter name — they always share one
name. Disabling both methods effectively turns key authentication off.

You can also read or change settings from the command line:

```bash
drush cget key_auth.settings
drush cset key_auth.settings param_name 'x-api-token'
drush cset key_auth.settings key_length 48
# detection_methods is a list, so set it with php:eval:
drush php:eval "\Drupal::configFactory()->getEditable('key_auth.settings')->set('detection_methods', ['header'])->save();"
```

## The permission that makes keys work

Regardless of the settings above, a key only authenticates a request — and a user is
only *given* an auto-generated key — if the user's role holds the **Use key
authentication** permission (`use key authentication`), set at **People →
Permissions**. This is deliberate: it lets you restrict working keys to a specific
"service account" role rather than every user on the site.

```bash
drush role:perm:add api_consumer 'use key authentication'
```

## Generating and revoking a key

Every user has a **Key authentication** tab on their account, at
**/user/{user}/key-auth**. There they can:

- **Generate a new key** — creates a fresh random key (this also rotates an existing
  one).
- **Delete the current key** — immediately revokes it.

The tab also shows ready-made **header** and **query** examples built from the
current settings, so an API consumer can copy exactly what to send. An administrator
with the *Administer users* permission can manage another user's key from the same
tab.

If **Automatically generate a key when users are created** is on, users who already
have the *Use key authentication* permission at creation time get a key without
anyone visiting this tab. Users created without the permission (or while
auto-generation is off) start with no key and need one generated here later.

## How a client sends the key

Depending on the enabled detection methods, a client presents its key as:

- **A header** named by the parameter name — with the default `api-key`, that is
  `api-key: <key>`. Preferred for server-to-server calls, since it avoids the key
  appearing in server logs.
- **A query parameter** — `?api-key=<key>`. Convenient for quick testing or clients
  that cannot set custom headers.

Pair this with core's REST module or JSON:API to authenticate calls to your
endpoints as the key's owner. Note that a key alone is never enough: a blocked user,
a key that matches no active user, or a user whose role lacks *Use key
authentication* will not authenticate.

## Page cache safety

You do not need to configure this, but it is worth knowing: any request that carries
a key is automatically excluded from Drupal's internal page cache — even if
authentication ultimately fails — so a key-authenticated response is never cached and
served to another visitor.
