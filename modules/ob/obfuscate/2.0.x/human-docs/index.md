# Obfuscate — manual setup guide

**Obfuscate** (`obfuscate`) hides email addresses from spam harvesters. It turns a plain
address like `you@example.com` into markup that still renders as a normal, clickable
`mailto:` link for humans, but that automated bots scraping your pages have a hard time
reading. It's a lightweight anti-spam aid — not encryption — so a determined scraper can
still recover addresses, but it defeats the naive harvesters responsible for most address
scraping.

You pick **one obfuscation method** for the whole site, and Obfuscate exposes it four ways
so you can hide addresses wherever they appear:

- an **Email field formatter** ("Obfuscate") for Email fields,
- a **text-format filter** that hides every address in WYSIWYG body text,
- a **Twig filter and function** for use in templates, and
- a **service** for custom code.

Two methods are available. **HTML-entity encoding** (the default) is pure PHP with no
JavaScript: it randomly encodes some characters as HTML entities and adds `rel="nofollow"`
to the link. **ROT13** never puts the real address in the raw HTML at all — it emits a
scrambled version plus a reversed-text CSS fallback, and a small JavaScript file unscrambles
it into a real link in the visitor's browser. The module depends only on core's **Field**
and **Filter** modules.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings form (choosing the site-wide
   method) and the `administer obfuscate` permission.

## Where it lives in the admin menu

- **Configuration → Content authoring → Email obfuscation configuration**
  (`/admin/config/obfuscate`) — the one settings form, where you pick the site-wide method.
- **Configuration → Content authoring → Text formats and editors** — where you turn on the
  obfuscation filter for a text format.
- **Manage display** of any Email field — where you apply the *Obfuscate* formatter.

## How to use it

Once the method is chosen (see [Configuration](configuration/index.md)), pick whichever of
the four delivery paths fits where your addresses live:

### Obfuscate an Email field

On the entity's **Manage display** tab, set an Email field's format to **Obfuscate**. The
formatter has two options: an **obfuscation method** (defaults to the site-wide method but
can be overridden here per field), and an optional **link label** that shows custom text
instead of the raw address — the label supports tokens, so you can use something like
`Contact [node:title]`.

### Obfuscate addresses in body text

Turn on the **Email address obfuscation filter** for a text format (for example *Full HTML*
or *Basic HTML*) at **Configuration → Content authoring → Text formats and editors**. Once
enabled, every email address an editor types into that format — both bare addresses and
`mailto:` links — is obfuscated automatically, with no extra effort from editors. The filter
always uses the site-wide method.

### Obfuscate in a Twig template

```twig
{{ 'you@example.com'|obfuscateMail }}
{{ obfuscate('you@example.com', 'Email us') }}
```

The `|obfuscateMail` filter prints an obfuscated link; the `obfuscate()` function does the
same but lets you set custom link text.

### Obfuscate from custom code

Use the `obfuscate_mail` service. Its `getObfuscatedLink()` returns a render array for a
finished link, and `obfuscateEmail()` returns just the obfuscated address string. Both honor
the site-wide method.
