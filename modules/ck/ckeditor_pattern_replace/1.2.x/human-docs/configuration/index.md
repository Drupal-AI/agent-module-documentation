# Configuration

The module is configured entirely as a **filter on a text format**. You enable the
filter and enter your search‑and‑replace rules; both live on the format.

## Enable the filter on a text format

1. Log in as a user with the **Administer filters** permission. Grant this only to
   people you trust — see the caution below.
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. Edit the text format you want to apply rules to.
4. On the **Filters** list, enable the **CKEditor pattern replace** filter.
5. Mind the **filter processing order** (the "Filter processing order" section):
   because this filter rewrites markup, its position relative to other filters can
   change the result. Place it where it makes sense — usually after the editor's
   own markup‑producing filters.

## Write your rules

Open the filter's settings and enter the rules in the textarea, **one rule per
line**, each in the form:

```
/pattern/|replacement
```

- The text **before** the `|` is a PHP regular expression (including its
  delimiters and any flags, e.g. `/foo/i`).
- The text **after** the `|` is the replacement. Leave it empty to delete matches.
- Rules are applied **in order**, top to bottom, so later rules see the output of
  earlier ones.

Some worked examples:

```
/badword/|****
/badword/|betterword
/(\+\d{1,3}[- ]?)?\d{10}/|####
```

The first masks a word, the second replaces it, and the third masks phone‑number
patterns. An email pattern such as `[\w\.]+@([\w-]+\.)+[\w-]{2,4}` can be used the
same way to redact addresses.

## Save

Click **Save configuration** on the text format. Rules take effect immediately for
content rendered through that format.

## Important cautions

- **This is an admin‑trusted feature.** The patterns are PHP regular expressions,
  and a malformed or overly broad pattern can break your output or alter markup
  unexpectedly. Restrict **Administer filters** to trusted users, and test rules on
  sample content before applying them to a production format.
- **No code execution risk on modern PHP.** PHP's deprecated `/e` modifier, which
  once allowed code execution via `preg_replace`, was removed in PHP 7, so these
  patterns cannot run code on any supported PHP version.
