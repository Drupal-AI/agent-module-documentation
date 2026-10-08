# Configuration

SpamSpan has no dedicated settings page — you configure it by adding its filter to a
**text format**. Everything below happens under **Configuration → Content authoring →
Text formats and editors**, which requires core's **Administer filters** permission.

## Enable the filter on a text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit the format you want to protect (for
   example *Full HTML*).
2. Under **Enabled filters**, tick **SpamSpan email address encoding filter**.
3. Under **Filter processing order**, drag SpamSpan so it runs **after** filters that
   generate HTML — for example after "Convert URLs into links" — so it can catch the
   `mailto:` links those filters produce.
4. Adjust its options under **Filter settings** (below), then **Save configuration**.

Once enabled, any bare email address or `mailto:` link in content using that format is
obfuscated automatically on output.

## Filter settings

Each format's SpamSpan filter has its own settings, so you can be stricter on
anonymous-facing formats than on internal ones:

| Setting | Default | What it does |
|---------|---------|--------------|
| **"@" replacement** | ` [at] ` | The text shown in place of `@` when JavaScript is off. |
| **Use a graphical replacement** | Off | Show a small image for `@` instead of text (overrides the "@" replacement text). |
| **Replace dots** | Off | Also obfuscate `.` in the address for stronger hiding. |
| **"." replacement** | ` [dot] ` | The text shown in place of `.` when dot replacement is on. |
| **Use a contact form** | Off | Link to a contact form instead of exposing a `mailto:` at all. |
| **Form URL / display text** | `contact` / *contact form* | The default form URL and link text used in contact-form mode. |

### Per-address overrides in content

When contact-form mode is on, an editor can override the form and link text for a
single address directly in content using this syntax:

```
user@example.com[mycontactform|Contact me using this form]
```

## Email field formatter

If you store addresses in core **Email** fields, you can obfuscate those too. On the
content type's **Manage display**, choose the **Email SpamSpan** formatter for the Email
field. It exposes the same options as the filter and obfuscates the field value the same
way.

## What the output looks like

An address like `me@example.com` is rendered as obfuscated markup — roughly
`<span class="spamspan">me [at] example.com</span>` with the pieces split into separate
spans — which the SpamSpan JavaScript reassembles into a real `mailto:` link in the
browser. Visitors without JavaScript still see the readable `me [at] example.com`
fallback.

## Preview before you commit

Use the built-in test page at `/admin/config/content/formats/spamspan` (also reachable
as a tab from the Text formats page) to paste some text and preview exactly how SpamSpan
will obfuscate it — handy for checking your settings before enabling the filter on a
production format.

## Deploying settings

There's no SpamSpan-specific Drush command. Its settings live inside each text format's
configuration (and each formatter's display configuration), so `drush config:export` /
`drush config:import` move them between environments like any other core config.
