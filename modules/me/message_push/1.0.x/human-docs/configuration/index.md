# Configuration

Message Push is configured by defining **subscription types** — each one ties a
**flag** (how a user subscribes) to a **message type** (what gets generated) and a
**push type** (how it is delivered through Push Framework). The steps below assume
Message, Flag and Push Framework are all enabled.

## Step 1 — Create a flag

Using the [Flag](https://www.drupal.org/project/flag) module, create the flag users
will use to subscribe to the thing they care about (for example, "follow this
content" or "notify me about this group"). This is the opt-in mechanism — only users
who set the flag will receive the resulting notifications.

## Step 2 — Create a message type

Using the [Message](https://www.drupal.org/project/message) module, create the
message template that will be used for these notifications. This defines the content
and tokens of the message that gets pushed. Message Push makes the message's tokens
available in the Push Framework notification template.

## Step 3 — Add a subscription type

1. Go to **`/admin/config/people/subscription-type`** as a user with the **Administer
   subscription type** permission.
2. Add a new **subscription type** and tie together:
   - the **flag** from Step 1 (how users subscribe),
   - the **message type** from Step 2 (what is sent), and
   - the **push type** provided by Push Framework (how it is delivered).
3. Save.

## Generating the messages

Message Push relays messages — it does **not** create them. To actually trigger
notifications you still need something that creates Message entities when the relevant
event happens, either custom code or the
[ECA](https://www.drupal.org/project/eca) module. (If you use ECA, you may prefer to
tie the message to Push Framework through ECA directly instead of through this
module.)

## Verify it worked

Have a test user set the flag, then trigger the event that generates the message.
Confirm the push notification is delivered through your Push Framework channel. If
nothing arrives, check that the subscription type correctly links the flag, message
type and push type, and that Push Framework's own delivery channels are configured.
