# Configuration

Expirable Content is configured **per bundle** — you decide which content entity
types should have a calculated expiration date, rather than turning it on globally.
The module is designed to be invisible to the entity type it's applied to, so
enabling it doesn't change how that content otherwise behaves.

## 1. Enable expiration for a bundle

1. Log in as a user with permission to administer content types (and the module's
   own permissions — see below).
2. Go to the bundle you want to make expirable — for example a content type under
   **Structure → Content types → *(your type)***.
3. In that bundle's settings, enable Expirable Content's expiration configuration
   and set how the expiration date should be calculated for that bundle.
4. Save the bundle.

From then on, content of that bundle carries a calculated expiration date.

## 2. Set permissions

Expirable Content provides its own permissions to control who can manage expiration
configuration. Go to **People → Permissions**, find the Expirable Content
permissions, and grant them to the roles that should be allowed to configure or
manage expiration. Keep them limited to trusted editorial/administrative roles.

## 3. Decide what happens on expiry

This is the key thing to understand about Expirable Content: **it does not take any
action itself when an expiration or warning date arrives.** It calculates and
exposes the dates, and leaves the response entirely up to you. That's intentional —
it means you can drive the outcome with whatever automation framework you already
use:

- **Rules** or **ECA** — trigger an action (unpublish, notify, move, etc.) when a
  date is reached.
- The **Message** module suite — send notifications.
- A custom **cron** routine or hook — do whatever your site needs.

Choose one of these to define the actual behaviour (for example, unpublishing
content once it expires).

## 4. Build listings with Views (optional)

The module integrates with **Views**, so you can surface expiration data in
listings — for instance a "content expiring soon" dashboard or an "already expired"
report. Add a View on the relevant entity type and use the expiration data as a
field, filter, or sort.
