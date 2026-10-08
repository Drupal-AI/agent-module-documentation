# Configuration

Disable Back Button needs to know **which pages** should have the Back button
disabled. You set that on its configuration form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Disable Back configuration**, or navigate
   directly to `/admin/config/browser/noback/settings`.

## Choose the pages

Enter the paths on which you want the Back button disabled. The module's own help
text describes this as a list of URLs (its help wording refers to a comma-separated
list of paths), and the path matching follows Drupal's standard visibility-path
style with `*` wildcards, so you can target a single page, a section, or a whole
flow. Depending on how you configure it, the protection can apply site-wide or only
on the listed pages, and it can affect both anonymous and authenticated sessions.

When you save, the module attaches its `disable_back_button` JavaScript library on
the matching responses. Click **Save configuration** to apply.

## Keep the limits in mind

Everything this form controls is client-side JavaScript. It does not enforce any
server-side access control — a user with JavaScript turned off, or who uses browser
dev tools, bypasses it entirely. Treat it as a UX aid, not as a way to protect
sensitive pages. For genuine post-logout protection, combine it with
`Cache-Control: no-store` on those pages and correct session handling. Because
history behaviour varies between browsers, test the result in the browsers your
users actually use.
