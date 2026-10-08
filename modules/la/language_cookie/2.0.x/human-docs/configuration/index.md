# Configuration

Setting up Language Cookie is two steps: enable and order the **Cookie** detection
method in core's language UI, then tune the cookie's own settings.

## 1. Enable and order the Cookie method

1. Log in as a user with the **Administer languages** permission.
2. Go to **Configuration → Regional and language → Languages → Detection and
   selection** (`/admin/config/regional/language/detection`).
3. For the **Interface language** (and any other language type you want), tick the
   **Cookie** method to enable it.
4. Drag the methods into the order you want. The module's README recommends:
   **URL → Cookie → Language Selection Page → Default**. Order matters — each request
   uses the first method that resolves a language.
5. Save.

With the method enabled, a cookie hit will also switch off the internal page cache
for that request, so a page cached in one language is never served in another.

## 2. Tune the cookie settings

Open the module's own settings form at
`/admin/config/regional/language/detection/language_cookie` (an old Drupal 7 path
redirects here automatically). The fields are:

| Field | Default | What it does |
|-------|---------|--------------|
| **Cookie name** (`param`) | `language` | The name of the cookie that is read and written. |
| **Cookie lifetime** (`time`) | 1 year (in seconds) | How long the cookie lasts, counted from now. |
| **Path** | `/` | The cookie's path scope. |
| **Domain** | empty | The cookie's domain scope. Empty means the current host. |
| **Secure** | Off | When on, the cookie is only sent over HTTPS. (Set on automatically at install if the install request was secure.) |
| **HttpOnly** | On | Blocks client-side JavaScript from reading the cookie — leave on unless you specifically need JS access. |
| **Set on every page load** | Off | When on, the cookie is re-sent on every response. Useful behind Varnish or other reverse caches. |

Each condition plugin (below) may add its own sub-form to this page — for example
the *Blacklisted paths* condition adds a textarea for the paths to skip. Saving the
form returns you to the detection-and-selection page.

## How the cookie is chosen and written

- **Which language type drives it.** By default the cookie follows the **interface**
  language, but it can be tied to the content or URL language type instead.
- **When it is written.** On each response, the module works out the language using
  the detection methods that sit *above* the Cookie method, then writes the cookie
  only if it is missing, has changed, or "set on every page load" is on.

## Condition plugins (when the cookie is *not* set)

The cookie is written only when **every** condition passes. The shipped conditions
skip setting it in situations where it would be wrong or wasteful, including:

- **Blacklisted paths** — paths you list (glob patterns) where the cookie must not
  be set.
- **AJAX / XMLHttpRequest** responses.
- **Non-`index.php` requests** such as CLI and cron.
- **Language the user cannot access.**
- Various request-method, path, PHP-SAPI, and server-address checks.

Developers can add site-specific rules by writing a condition plugin, or adjust the
outgoing cookie directly — see the [`agent/`](../agent/start.md) docs for the plugin
type and the two alter hooks (`hook_language_cookie_alter`,
`hook_language_cookie_condition_info_alter`).
