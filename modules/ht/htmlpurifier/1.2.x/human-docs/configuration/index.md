# Configuration

HTML Purifier is configured in two places: on each text format (the filter and its
directives), and once globally for the cache path.

## 1. Enable the filter on a text format

1. Log in as an administrator and go to **Configuration → Content authoring → Text
   formats and editors** (`/admin/config/content/formats`).
2. Edit the format that accepts untrusted or semi-trusted HTML (for example a
   "Full HTML"-like format used by non-admin authors). Enable it only on formats
   that need it — it adds nothing to a plain-text format.
3. Under **Enabled filters**, tick **HTML Purifier**.
4. A **HTML Purifier** settings section (a vertical tab) appears — see the directives
   below.

## 2. Order the filter correctly (important for security)

In the **Filter processing order** list, HTML Purifier must run **after** — i.e. sit
**lower** in the list / have a higher weight than — any filter that can add or
re-introduce markup, such as "Convert line breaks", "Convert URLs into links", or
media/embed filters. Because it is an irreversible transform, if it runs too early a
later filter could add HTML that never gets sanitized. In practice: **keep it
last.**

## 3. Write the HTML Purifier directives (YAML)

The filter's settings section holds one textarea, **HTML Purifier configuration**,
where you paste HTML Purifier directives as YAML. Each `Namespace: { Key: value }`
pair becomes one Purifier setting. For example:

```yaml
HTML:
  Allowed: 'p,br,strong,em,a[href],ul,ol,li'
URI:
  AllowedSchemes:
    http: true
    https: true
    mailto: true
```

- **Leave the textarea empty** to use the library's built-in default configuration —
  a permissive but safe whitelist. (The form pre-fills the textarea with the full
  default directive set as a convenient starting point.)
- The full directive reference is at
  <http://htmlpurifier.org/live/configdoc/plain.html>. Common choices include
  `HTML.Allowed` (the tag/attribute whitelist), `URI.*` (allowed link protocols),
  and `CSS.AllowedProperties` (permitted inline-style properties).
- The **`Cache` namespace is ignored** if you add it — a text format cannot change
  Purifier's cache internals; that is managed globally (below).
- **Invalid directives are caught when you save**: the form surfaces the library's
  own error messages as validation errors, so you will know if a directive is
  wrong.

Save the format.

## 4. Global: the serializer cache path

HTML Purifier writes a serializer cache to speed itself up. By default this goes to
a `htmlpurifier` folder inside the site's temporary directory, and the folder is
created and made writable on each run. On multi-server or high-traffic sites you can
point it at a stable, fast, writable path via the `htmlpurifier.settings` config
object:

```bash
drush cset htmlpurifier.settings cache_serializer_path /var/cache/htmlpurifier -y
```

Leave it empty to keep the default temporary-directory location.

## What it does *not* provide

There are no permissions, no plugin types to implement, no services to call, no
Drush commands, and no submodules. The only moving parts are the one filter (per
format) and this one global cache-path setting — so getting the protection right is
about **enabling it on the correct formats and ordering it last**.
