# Configuration

Domain Language is configured **per domain**. There is no global settings page —
each domain has its own Languages form.

## Open a domain's Languages form

1. Log in as a user with the **Administer domains** permission (from Domain
   Access).
2. Go to **Configuration → Domains** (`/admin/config/domain`).
3. In the row for the domain you want to configure, click the **Languages**
   operation. (Direct path: `/admin/config/domain/language/{domain}/edit`.)

## The Languages form, field by field

### Default language

A required select that sets the domain's default language.

- The first option, **Site's default language (X)**, means *no override* — the
  domain simply uses the global site default. Choosing it clears any previous
  per-domain default.
- The other options are your site's configured languages (shown by their native
  names). Pick one to make it this domain's default.

### Languages allowed

A set of checkboxes listing every site language. Tick the languages this domain
should offer.

- **If you leave every box unchecked, all languages are available** — clearing the
  list means "no restriction", not "no languages".
- The default language you selected above is always added to the allowed set
  automatically on save, so you cannot accidentally forbid your own default.

Saving returns you to the domain list with a confirmation message and rebuilds the
site's routes so the new language rules take effect.

## What saving does

Behind the scenes the form writes (or removes) two configuration objects for the
domain:

- `domain.config.{domain}.system.site` → the `default_langcode`. Choosing *Site's
  default language* removes this key (and deletes the object if it becomes empty).
- `domain.language.{domain}.language.negotiation` → the `languages` map of allowed
  languages. Unchecking everything deletes this object entirely (meaning "all
  languages allowed").

It also strips any competing `url.prefixes` / `url.domains` overrides so a stale
setting can't fight the module's own negotiation rules.

## The effect on visitors

- The **language switcher** block on that domain only lists the allowed
  languages; disallowed ones disappear from it.
- The domain's URL language prefixes and domains resolve only to allowed
  languages.
- The domain uses the default language you chose instead of the global site
  default.

Remember these overrides apply only for the **active domain of the request**, so
if you test from the command line you need to pass the domain's URL (for example
`--uri=https://example.com`) to see the effect.

## The "Bypass language restrictions" permission

The module ships a single permission, **Bypass language restrictions**
(*"Allows users to access all languages for all domains"*). A user who holds it
skips the restrictions entirely and sees the site-wide default language and the
full, unfiltered set of languages on every domain.

Two things to know before granting it:

- Because it changes which config overrides apply, a bypassing user may see a
  *different* default language, URL behavior, and language switcher than a regular
  visitor on the same domain. That makes it a poor fit for a role you use to QA
  the public experience — give it to a dedicated maintenance role instead.
- The language switcher block itself is filtered for **everyone**, including
  bypassing users; the bypass affects negotiation and the default-language
  service, not the switcher's link list.

You can grant it from the UI on the Permissions page, or with Drush:

```bash
drush role:perm:add content_editor 'bypass language restrictions'
```

## Driving it from the command line

Because it is all config, you can set a domain's languages with `drush cset`
instead of the form. For a domain whose id is `example_com`, defaulting to French
and allowing French + German:

```bash
drush cset domain.config.example_com.system.site default_langcode fr -y
drush cset domain.language.example_com.language.negotiation languages.fr fr -y
drush cset domain.language.example_com.language.negotiation languages.de de -y
drush cr
```

The `languages` value is a map, so both the key and value must be the langcode
(`fr: fr`). To return a domain to "all languages / site default":

```bash
drush config:delete domain.language.example_com.language.negotiation -y
drush cdel domain.config.example_com.system.site default_langcode -y
```

Neither config object ships a schema with this module, so validation tooling will
report these keys as untyped even though they import and work.
