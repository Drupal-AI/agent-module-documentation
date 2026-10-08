# Configuration

Noscript Tag needs a message before it shows anything, and you decide which users
the tag is served to. Both are handled through one settings form plus the
permissions page.

## Open the settings form

1. Log in as a user with the **administer noscript tag** permission.
2. Go to **Configuration → Development → Noscript Tag**, or navigate directly to
   `/admin/config/development/noscript-tag-setting`.

## Set the message

- **Noscript message / content** — enter the text or markup you want to appear for
  visitors with JavaScript disabled. This can be plain text (for example, "This
  site works best with JavaScript enabled") or markup for a richer, branded notice.
  The content is stored as configuration (`noscript_tag.settings`) and rendered
  inside a `<noscript>` element, so it is only shown when JavaScript is
  unavailable. Because it lives in configuration, you can update it here without
  editing theme code, and it can be exported with the rest of your config.

Save the form when you're done.

## Control who sees the tag

Who the `<noscript>` message is shown to is governed by the **view noscript tag**
permission:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Tick **view noscript tag** for the roles that should receive the notice — in
   most cases you'll want it for **Anonymous** and **Authenticated** users so all
   visitors see it.
3. Keep **administer noscript tag** restricted to trusted administrator roles, since
   it controls the message content.
4. Click **Save permissions**.

## Verify

Load a front‑end page with JavaScript **disabled** in your browser (or via
developer tools) as a user who has the *view noscript tag* permission — the
configured message should appear. With JavaScript enabled, it should not be visible.
