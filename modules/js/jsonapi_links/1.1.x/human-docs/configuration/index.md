# Configuration

JSON:API Links has a single, small settings form. Enabling the module does nothing
by itself — you decide whether links are removed here.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Web services → JSON:API → Links**, or navigate directly
   to `/admin/config/services/jsonapi/links`.

## Remove all links attributes

The form has one checkbox:

- **Remove all links attributes** — when ticked, the `links` members are stripped
  from JSON:API responses. When unticked (the default), responses are unchanged and
  behave exactly like standard JSON:API.

The API root path (`/jsonapi`, or whatever you have set as the root path) is always
exempt: its links are never removed, so API discovery from the entry point keeps
working even with this setting on.

## Save

Click **Save configuration**. The change takes effect immediately — request a
JSON:API collection such as `/jsonapi/node/article` and the `links` members should
be gone.

## Before you turn it on

Because this deviates from the JSON:API specification, decide deliberately:

- It is safe for a **front end you control** that builds its own URLs, and risky as
  a blanket setting if any consumer is a **generic** JSON:API client that discovers
  the API from its links.
- The `self` link is removed too. If a client re-fetches or invalidates individual
  resources via `self`, it will break — often in a way that looks unrelated to this
  setting.
- Removing links makes casual API enumeration slightly harder, but that is
  **obscurity, not access control**. For a real access boundary, use
  `jsonapi_permission` or entity access — not this setting.
