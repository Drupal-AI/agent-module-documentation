# Configuration

Obfuscate has one small settings form: you pick a single **site-wide obfuscation method**,
and everything else (the text filter, the Twig helpers, the service, and the default for the
field formatter) uses it. There is nothing else to configure globally.

## Who can change the settings

The form is gated by the **Administer Obfuscate** permission (`administer obfuscate`). Grant
it at **People → Permissions** to the roles you trust to change how addresses are hidden —
by default an administrator has it. Everyone else can still see obfuscated addresses; they
just can't change the method.

## Open the settings form

1. Log in as a user with the **Administer Obfuscate** permission.
2. Go to **Configuration → Content authoring → Email obfuscation configuration**, or
   navigate directly to `/admin/config/obfuscate`.

## System-wide obfuscation method

The form has a single radio, **System wide obfuscation method**, with two choices:

- **HTML entity** *(default)* — a pure-PHP method with no JavaScript. It randomly encodes
  about a quarter of the address's characters (and always the `.`, `@`, and `:`) as HTML
  entities, URL-encodes the `mailto:` link, and adds `rel="nofollow"`. Bots that don't
  decode HTML entities see gibberish; browsers render the address normally. Choose this if
  you want obfuscation that works even with JavaScript disabled.

- **ROT13** — the real address never appears in the page source at all. The module outputs a
  scrambled (ROT13-rotated) version wrapped in a `js-enabled` span, plus a reversed-text
  span as a no-JavaScript CSS fallback. A small script (`js/rot13.js`) unscrambles it in the
  browser and rebuilds a genuine `mailto:` link. Choose this to defeat scrapers that simply
  decode HTML entities — at the cost of relying on JavaScript for the clickable link (the
  reversed-text fallback still shows the address to no-JS visitors).

Neither method is encryption; both are aids that stop naive harvesters, not determined ones.

## Save

Click **Save configuration**. Because changing the method affects already-rendered and
cached output, saving the form **flushes all caches** so the new method takes effect
everywhere immediately.

> **Overriding per field:** the Email field **Obfuscate** formatter uses this site-wide
> method as its default, but you can override the method on an individual field from that
> field's *Manage display* settings. The text filter, Twig helpers, and service always use
> the site-wide method.

## Setting the method without the UI

You can set the method from Drush instead of the form:

```bash
drush config:set obfuscate.settings obfuscate.method rot_13 -y
```

Use `html_entity` or `rot_13` as the value.
