# Configuration

Gated Entity has one configuration page where you decide which node types are
locked and which locker does the locking.

## Open the settings form

1. Log in as a user with the **Configure gated entities** permission (an
   administrator by default).
2. Go to **Configuration → Content authoring → Gated entities**, or navigate
   directly to `/admin/config/content/gated-entities`.

## The fields

- **Gated node types** — a set of checkboxes, one per content type on your site.
  Tick the node types you want to gate. Only **Node** entities are supported, so
  every option here is a content type. Any node type you leave unticked renders
  normally.
- **Default locker** — a select list of the available locker plugins. Out of the
  box the only option is **Login to unlock** (`login_locker`), which shows
  anonymous visitors a login link where the body would be and unlocks the content
  for any authenticated user. If a developer has added a custom locker plugin, it
  appears here too.

Click **Save configuration** to apply your choices. From then on, any node of a
ticked type is checked against the chosen locker when it is viewed: if the locker
says the visitor is not allowed, the body is replaced with the locker's message
(for the login locker, a "Login to unlock" link) while the title stays visible.

## Important limitations to keep in mind

- This is a **view‑layer** gate. It does **not** implement Drupal node‑access
  grants, so a gated node is still retrievable through JSON:API, REST, Views field
  output, search, and its edit form. Do not use it to protect sensitive data.
- The default **Login Locker** unlocks for **any** authenticated user, regardless
  of role — it is "logged in or not", not "has a specific role". If you need
  role‑ or password‑based unlocking, that requires a custom locker plugin.
- For genuinely restricted content, combine Gated Entity with a real
  access‑control mechanism.
